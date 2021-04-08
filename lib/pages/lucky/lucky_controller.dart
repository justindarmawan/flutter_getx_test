import 'dart:convert';

import 'package:flutter_getx_test/pages/home/currencies_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../consts/links.dart';
import '../../models/lucky.dart';
import '../../models/lucky_history.dart';
import '../auth/auth_controller.dart';

class LuckyController extends GetxController {
  final AuthController authController = Get.find();
  final CurrenciesController _currenciesController = Get.find();

  var _isQuiz = false.obs;
  var _isLoading = false.obs;
  var _firstLoad = true.obs;
  // var _dataImages = RxList<String>([]);
  var _dataImages = [];
  var _indexImages = 0.obs;
  var _luckyDate = ''.obs;
  var _dataLucky = RxList<Lucky>([]);
  var _dataLuckyHistory = RxList<LuckyHistory>([]);

  DateTime _expiryDate;

  bool get getLoading {
    return _isLoading.value;
  }

  firstLoaded() {
    _firstLoad.value = false;
  }

  int get lengthImages {
    return _dataImages.length;
  }

  int get indexImages {
    return _indexImages.value;
  }

  String get images {
    return _dataImages[_indexImages.value];
  }

  nextImages() {
    _indexImages++;
  }

  bool get getFirstLoad {
    return _firstLoad.value;
  }

  List<Lucky> get fetchListLucky {
    if (_dataLucky.isEmpty) {
      return List<Lucky>.empty();
    }
    return _dataLucky;
  }

  List<LuckyHistory> get fetchListLuckyHistory {
    if (_dataLuckyHistory.isEmpty) {
      return List<LuckyHistory>.empty();
    }
    return _dataLuckyHistory;
  }

  String get getDate {
    final DateTime tempDate = DateFormat('yyyy-MM-dd').parse(_luckyDate.value);
    final DateFormat formatter = DateFormat('EEEEE, dd MMMM yyyy');
    return formatter.format(tempDate);
  }

  bool get isQuiz {
    if (_expiryDate != null && _expiryDate.isAfter(DateTime.now())) {
      _isQuiz.value = true;
      return _isQuiz.value;
    }
    _isQuiz.value = false;
    return _isQuiz.value;
  }

  Future<void> passedQuiz() async {
    _isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    _expiryDate = DateTime.now().add(Duration(days: 1));
    final luckyData = json.encode({
      'quiz': true,
      'expiry': _expiryDate.toIso8601String(),
    });
    prefs.setString('luckyData', luckyData);
    _isLoading.value = false;
    return;
  }

  Future<void> loadIsQuiz() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('luckyData')) {
      return;
    }
    final extractedLuckyData =
        json.decode(prefs.getString('luckyData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedLuckyData['expiry']);
    if (expiryDate.isBefore(DateTime.now())) {
      _isQuiz.value = false;
      _expiryDate = null;
      return;
    }
    _isQuiz.value = extractedLuckyData['quiz'];
    _expiryDate = expiryDate;
    return;
  }

  Future<void> getPopupImages() async {
    try {
      final response = await http.get(Uri.parse(linkGetPopupImages));
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      // print(responseData.toString());
      if (responseData['query_result'] == 'DATA') {
        responseData['imgName'].map((data) {
          print(urlImages + data);
          _dataImages.add(urlImages + data);
        }).toList();
      }
      return;
    } catch (error) {
      throw error;
    }
  }

  Future<void> checkDate() async {
    try {
      final response = await http.get(Uri.parse(linkCheckDate));
      final responseData = json.decode(response.body);
      _luckyDate.value = responseData['date'];
      return;
    } catch (error) {
      throw error;
    }
  }

  Future<void> refreshScreen() async {
    _dataLucky.clear();
    // _firstLoad.value = true;
    try {
      _isLoading.value = true;
      await checkDate();
      await getListLucky();
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> getListLucky() async {
    try {
      final response = await http.get(Uri.parse(linkGetListLucky +
          '?email=${authController.userId}&betDate=${_luckyDate.value}'));
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      if (responseData['query_result'] == 'DATA') {
        responseData['results'].map((data) {
          _dataLucky.add(Lucky(data['number'], data['diamond']));
        }).toList();
      }
      return;
    } catch (error) {
      throw error;
    }
  }

  Future<void> getListLuckyHistory() async {
    _isLoading.value = true;
    _dataLuckyHistory.clear();
    try {
      final response = await http.get(Uri.parse(
          linkGetListLuckyHistory + '?email=${authController.userId}'));
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      print(responseData);
      if (responseData['query_result'] == 'DATA') {
        responseData['data'].map((data) {
          List<String> _number = [];
          List<String> _diamond = [];
          data['number'].forEach((data) {
            _number.add(data);
          });
          data['diamond'].forEach((data) {
            _diamond.add(data);
          });
          _dataLuckyHistory.add(LuckyHistory(
              betDate: data['betDate'], number: _number, diamond: _diamond));
        }).toList();
      }
      _isLoading.value = false;
      return;
    } catch (error) {
      _isLoading.value = false;
      throw error;
    }
  }

  Future<void> submitLuckyNumber(String number, int diamond) async {
    try {
      final response = await http.post(
        Uri.parse(linkSubmitLuckyNumber),
        body: json.encode(
          {
            'email': authController.userId,
            'diamond': diamond,
            'number': number,
          },
        ),
      );
      final responseData = json.decode(response.body);
      print(responseData.toString());
      await _currenciesController.loadDiamond();
      return;
      // return responseData['query_result'];
    } catch (error) {
      await _currenciesController.loadDiamond();
      throw error;
    }
  }

  // @override
  // void onInit() async {
  //   await refreshScreen();
  //   super.onInit();
  // }
}

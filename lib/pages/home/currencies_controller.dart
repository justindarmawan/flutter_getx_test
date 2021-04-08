import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../consts/links.dart';
import '../auth/auth_controller.dart';

class CurrenciesController extends GetxController {
  final AuthController _authController = Get.find();

  var _coin = RxString();
  var _diamond = RxString();

  var _dailyCoin = false.obs;

  var _isLoading = true.obs;

  String get getCoin {
    return _coin.value;
  }

  String get getDiamond {
    return _diamond.value;
  }

  bool get getLoading {
    return _isLoading.value;
  }

  bool get getDailyCoin {
    return _dailyCoin.value;
  }

  Future<String> _getCurrencies(String currency, String link) async {
    final prefs = await SharedPreferences.getInstance();
    String data = 'retry';
    if (!prefs.containsKey('userData')) {
      return 'failed!';
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    String _userId = extractedUserData['userId'];
    try {
      final response = await http.get(Uri.parse(link + '?email=$_userId'));
      final responseData = json.decode(response.body);
      print(responseData.toString());
      if (responseData['query_result'] == "SUCCESS") {
        data = responseData['$currency'];
        return data;
      }
      return data;
    } catch (error) {
      throw error;
    }
  }

  Future<void> checkDailyCoin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      _dailyCoin.value = false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    String _userId = extractedUserData['userId'];
    try {
      final response =
          await http.get(Uri.parse(linkCheckDailyCoin + '?email=$_userId'));
      final responseData = json.decode(response.body);
      print(responseData.toString());
      if (responseData['query_result'] == "NOTYET") {
        _dailyCoin.value = true;
        return;
      }
      _dailyCoin.value = false;
    } catch (error) {
      throw error;
    }
  }

  Future<void> claimCoin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      _dailyCoin.value = false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    String _userId = extractedUserData['userId'];
    try {
      final response =
          await http.get(Uri.parse(linkClaimCoin + '?email=$_userId'));
      final responseData = json.decode(response.body);
      print(responseData.toString());
      if (responseData['query_result'] == "SUCCESS") {
        _dailyCoin.value = false;
        await loadCoin();
        return;
      }
      _dailyCoin.value = true;
    } catch (error) {
      throw error;
    }
  }

  Future<String> loadCoin() async {
    return _coin.value = await _getCurrencies('coin', linkGetCoin);
  }

  Future<String> loadDiamond() async {
    return _diamond.value = await _getCurrencies('diamond', linkGetDiamond);
  }

  Future<void> refreshScreen() async {
    // try {
    //   _isLoading.value = true;
    // } finally {
    //   _isLoading.value = false;
    // }
    await loadCoin();
    await loadDiamond();
    await checkDailyCoin();
    _authController.alreadyLogin();
  }

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() async {
    // await refreshScreen();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

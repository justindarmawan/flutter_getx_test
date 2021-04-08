import 'dart:async';
import 'dart:convert';

import 'package:flutter_getx_test/pages/game/game_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../consts/links.dart';
import '../dashboard/dashboard_controller.dart';
import '../home/currencies_controller.dart';
import '../lucky/lucky_controller.dart';
import '../lucky/quiz_controller.dart';

class AuthController extends GetxController {
  var _userId = RxString();
  String _tempId, _tempPassword;
  var _isLoading = false.obs;
  var _firstLogin = true.obs;

  var _stackIndex = 0.obs;

  void changeStackIndex(int index) {
    _stackIndex.value = index;
    update();
  }

  int get stackIndex {
    return _stackIndex.value;
  }

  bool get isAuth {
    return _userId.value != null;
  }

  String get userId {
    return _userId.value;
  }

  bool get firstLogin {
    return _firstLogin.value;
  }

  bool get getLoading {
    return _isLoading.value;
  }

  alreadyLogin() {
    _firstLogin.value = false;
  }

  Future<String> login(String email, String password) async {
    _isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse(linkLogin),
        body: json.encode(
          {
            'email': email,
            'pass': password,
          },
        ),
      );
      final responseData = json.decode(response.body);
      print(responseData.toString());
      if (responseData['query_result'] == "SUCCESS") {
        _userId.value = email;
        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode({
          'userId': _userId,
        });
        prefs.setString('userData', userData);
        _userId.value = email;
      }
      _tempId = email;
      _isLoading.value = false;
      return responseData['query_result'];
    } catch (error) {
      _isLoading.value = false;
      throw error;
    }
  }

  Future<void> logout() async {
    _userId.value = null;
    _isLoading.value = false;
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Get.delete<LuckyController>();
    Get.delete<QuizController>();
    Get.delete<CurrenciesController>();
    Get.delete<DashboardController>();
    Get.delete<GameController>();
    _firstLogin.value = true;
  }

  Future<bool> tryAutoLogin() async {
    _isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      _isLoading.value = false;
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    _userId.value = extractedUserData['userId'];
    _isLoading.value = false;
    return true;
  }

  Future<String> checkEmail(String email, String password) async {
    _isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse(linkCheckEmail),
        body: json.encode(
          {
            'email': email,
          },
        ),
      );
      final responseData = json.decode(response.body);
      print(responseData.toString());
      if (responseData['query_result'] == "UNUSED") {
        _tempId = email;
        _tempPassword = password;
      }
      // _tempId = email;
      _isLoading.value = false;
      return responseData['query_result'];
    } catch (error) {
      _isLoading.value = false;
      throw error;
    }
  }

  Future<String> register(
      String firstName, String lastName, String gender, String city) async {
    _isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse(linkRegis),
        body: json.encode(
          {
            'email': _tempId,
            'pass': _tempPassword,
            'firstName': firstName,
            'lastName': lastName,
            'gender': gender,
            'city': city,
          },
        ),
      );
      final responseData = json.decode(response.body);
      // print(responseData.toString());
      _isLoading.value = false;
      return responseData['query_result'];
    } catch (error) {
      _isLoading.value = false;
      throw error;
    }
  }

  Future<String> verification(String code) async {
    _isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse(linkVerification),
        body: json.encode(
          {
            'email': _tempId,
            'code': code,
          },
        ),
      );
      final responseData = json.decode(response.body);
      // print(responseData.toString());
      _isLoading.value = false;
      return responseData['query_result'];
    } catch (error) {
      _isLoading.value = false;
      throw error;
    }
  }
}

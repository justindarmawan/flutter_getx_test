import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import './lucky_controller.dart';
import '../../consts/links.dart';
import '../../models/quiz.dart';

class QuizController extends GetxController {
  final LuckyController luckyController = Get.find();

  var _dataQuiz = RxList<Quiz>([]);
  var _isLoading = false.obs;
  var _index = 0.obs;
  var _right = 0.obs;
  var _isPressed = false.obs;
  var _isDone = false.obs;

  List<Quiz> get dataQuiz {
    return _dataQuiz;
  }

  Quiz get fetchQuiz {
    if (_dataQuiz.isEmpty) {
      return Quiz('', '', []);
    }
    return _dataQuiz[_index.value];
  }

  bool get getLoading {
    return _isLoading.value;
  }

  bool get isPressed {
    return _isPressed.value;
  }

  bool get isDone {
    return _isDone.value;
  }

  int get index {
    return _index.value;
  }

  int get rightAnswers {
    return _right.value;
  }

  nextQuestion() {
    _isPressed.value = false;
    if (_index.value == 2 && _right.value == 3) {
      _isDone.value = true;
      return luckyController.passedQuiz();
    } else if (_index.value == 2) {
      return _isDone.value = true;
    }
    _index.value++;
  }

  answerRight() {
    _right.value++;
  }

  setIsPressed() {
    _isPressed.value = true;
  }

  Future<void> getQuiz() async {
    try {
      final response = await http.get(Uri.parse(linkQuiz));
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      // print(responseData.toString());
      if (responseData['response_code'] == 0) {
        responseData['results'].map((data) {
          // print(data['question']);
          // print(data['correct_answer']);
          // print(data['incorrect_answers']);
          List<String> _ans = [];
          data['incorrect_answers'].forEach((data) {
            _ans.add(data);
          });
          _ans.add(data['correct_answer']);
          _ans.shuffle();
          _dataQuiz.add(Quiz(data['question'], data['correct_answer'], _ans));
        }).toList();
      }
      return;
    } catch (error) {
      throw error;
    }
  }

  Future<void> refreshScreen() async {
    _dataQuiz.clear();
    _index.value = 0;
    _right.value = 0;
    _isDone.value = false;
    try {
      _isLoading.value = true;
      await getQuiz();
    } finally {
      _isLoading.value = false;
    }
  }

  // @override
  // void onInit() async {
  //   super.onInit();
  //   await refreshScreen();
  // }

  // @override
  // void onReady() async {
  //   super.onReady();
  //   // await refreshScreen();
  // }
}

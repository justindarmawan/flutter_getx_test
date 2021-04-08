import 'package:flutter/material.dart';
import 'package:flutter_getx_test/pages/lucky/quiz_widget.dart';
import 'package:get/get.dart';

import './quiz_controller.dart';

class QuizPage extends GetView<QuizController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
          child: controller.dataQuiz.isEmpty
              ? FutureBuilder(
                  future: controller.refreshScreen(),
                  builder: (context, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? CircularProgressIndicator()
                          : QuizWidget())
              : QuizWidget()),
    );
  }
}

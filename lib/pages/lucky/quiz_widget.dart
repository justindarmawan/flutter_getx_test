import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/colors.dart';
import 'lucky_controller.dart';
import 'quiz_controller.dart';

class QuizWidget extends GetView<QuizController> {
  final LuckyController luckyController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            controller.fetchQuiz.question,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline3,
          ),
          SizedBox(height: 20),
          Container(
            height: 200,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (ctx, i) {
                return Obx(() {
                  return ElevatedButton(
                    child: Text(
                      controller.fetchQuiz.answers[i],
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      controller.setIsPressed();
                      var _title = '';
                      if (controller.fetchQuiz.answers[i] ==
                          controller.fetchQuiz.correctAnswer) {
                        controller.answerRight();
                        _title = 'Correct';
                      } else {
                        _title = 'False';
                      }
                      return Get.defaultDialog(
                        title: _title,
                        middleText: 'Next question!',
                        textConfirm: controller.index == 2 ? 'Done' : 'Next',
                        onConfirm: () {
                          Get.back();
                          controller.nextQuestion();
                          if (controller.isDone &&
                              controller.rightAnswers == 3) {
                            return Get.defaultDialog(
                              title: 'Lucky Diamond Unlocked!',
                              middleText:
                                  'Now you get Lucky Diamond access for 24 hours!',
                              textConfirm: 'Okay',
                              onConfirm: () {
                                Get.back();
                                luckyController.passedQuiz();
                                print(
                                    'Checking is quiz: ${luckyController.isQuiz}');
                              },
                              barrierDismissible: false,
                            );
                          } else if (controller.isDone) {
                            return Get.defaultDialog(
                              title: 'Failed!',
                              middleText:
                                  'You have to answer 3 questions correctly!',
                              textConfirm: 'Try Again',
                              onConfirm: () {
                                Get.back();
                                controller.refreshScreen();
                              },
                              barrierDismissible: false,
                            );
                          }
                        },
                        barrierDismissible: false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: controller.isPressed
                          ? ((controller.fetchQuiz.answers[i] ==
                                  controller.fetchQuiz.correctAnswer)
                              ? Colors.green
                              : Colors.red)
                          : yellow,
                      onPrimary: white,
                    ),
                  );
                });
              },
              itemCount: controller.fetchQuiz.answers.length,
            ),
          ),
        ],
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './lucky_controller.dart';
import './lucky_page.dart';
import './quiz_page.dart';

class Lucky extends GetView<LuckyController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      print('first load: ${controller.getFirstLoad}');
      return controller.isQuiz
          ? LuckyPage()
          : FutureBuilder(
              future: controller.loadIsQuiz(),
              builder: (ctx, luckyResultSnapshot) =>
                  luckyResultSnapshot.connectionState == ConnectionState.waiting
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : QuizPage(),
            );
    });
  }
}

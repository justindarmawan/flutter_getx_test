import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './lucky_controller.dart';
import 'lucky_dialog.dart';
import 'lucky_widget.dart';

class LuckyPage extends GetView<LuckyController> {
  @override
  Widget build(BuildContext context) {
    // if (dashboardController.tabIndex == 2 && controller.getFirstLoad) {
    if (controller.getFirstLoad) {
      luckyDialog(controller);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: (controller.fetchListLucky.isEmpty)
          ? FutureBuilder(
              future: controller.refreshScreen(),
              builder: (context, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? Center(child: CircularProgressIndicator())
                      : LuckyWidget())
          : LuckyWidget(),
    );
  }
}

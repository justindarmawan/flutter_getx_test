import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'lucky_controller.dart';
import 'lucky_history_widget.dart';

class LuckyHistory extends GetView<LuckyController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lucky History'),
      ),
      body: controller.fetchListLuckyHistory.isEmpty
          ? FutureBuilder(
              future: controller.getListLuckyHistory(),
              builder: (context, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? Center(child: CircularProgressIndicator())
                      : LuckyHistoryWidget())
          : LuckyHistoryWidget(),
    );
  }
}

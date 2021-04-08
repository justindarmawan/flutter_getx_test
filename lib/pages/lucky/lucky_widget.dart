import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_getx_test/pages/home/currencies_controller.dart';
import 'package:flutter_getx_test/routes/app_routes.dart';
import 'package:flutter_getx_test/themes/colors.dart';
import 'package:get/get.dart';

import 'lucky_controller.dart';

class LuckyWidget extends GetView<LuckyController> {
  final CurrenciesController _currenciesController = Get.find();

  final _luckyTextController = TextEditingController();
  final _diamondTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return controller.getLoading
            ? Center(child: CircularProgressIndicator())
            : LayoutBuilder(
                builder: (context, constraint) {
                  return ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraint.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: constraint.maxHeight * 0.2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 5.0),
                                Text(
                                  'Period: ${controller.getDate}',
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                SizedBox(height: 15.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Number',
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                    Text(
                                      'Diamond',
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    )
                                  ],
                                ),
                                SizedBox(height: 10.0),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              height: constraint.maxHeight * 0.55,
                              child: Obx(() {
                                return controller.fetchListLucky.isEmpty
                                    ? Center(
                                        child: Text(
                                        'You not enter any Lucky Number for this period!',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                        textAlign: TextAlign.center,
                                      ))
                                    : ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        itemCount:
                                            controller.fetchListLucky.length,
                                        itemBuilder: (context, i) {
                                          return Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                    controller.fetchListLucky[i]
                                                        .number,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5,
                                                  ),
                                                  Text(
                                                    controller.fetchListLucky[i]
                                                        .diamond,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10.0),
                                            ],
                                          );
                                        },
                                      );
                              }),
                            ),
                          ),
                          Container(
                            height: constraint.maxHeight * 0.25,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      luckyModal(
                                        context,
                                        _luckyTextController,
                                        _diamondTextController,
                                      );
                                    },
                                    child: Text('Pick Your Lucky Number!'),
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Get.toNamed(AppRoutes.LUCKYHISTORY);
                                    },
                                    child: Text('History'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
      },
    );
  }

  void luckyModal(
      BuildContext context,
      TextEditingController luckyTextController,
      TextEditingController diamondTextController) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20.0),
          topRight: const Radius.circular(20.0),
        ),
      ),
      backgroundColor: white,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          height: 220,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Pick Your Lucky Number',
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Lucky Number',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    'Bet Diamond',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 150,
                    child: TextField(
                      controller: luckyTextController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 4,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        counter: SizedBox.shrink(),
                        hintText: '7777',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: TextField(
                      controller: diamondTextController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 4,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        counter: SizedBox.shrink(),
                        hintText: '50',
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        luckyTextController.text = randomLucky();
                      },
                      child: Text('Lucky Pick'),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        submit(luckyTextController, diamondTextController);
                      },
                      child: Text('Submit'),
                      style: ElevatedButton.styleFrom(
                        primary: red,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void submit(TextEditingController luckyTextController,
      TextEditingController diamondTextController) {
    if (int.parse(_currenciesController.getDiamond) <
        int.parse(diamondTextController.text)) {
      Get.defaultDialog(
        title: 'Warning',
        middleText: 'Not enough diamonds!\nGo to Store?',
        textCancel: 'Back',
        onCancel: () => Get.back(),
        textConfirm: 'Store',
        onConfirm: () {
          Get.back();
          Get.back();
          resetController(luckyTextController, diamondTextController);
          Get.toNamed(AppRoutes.STORE);
        },
      );
    } else {
      Get.defaultDialog(
        title: 'Confirm',
        middleText:
            'Bet number ${luckyTextController.text} with ${diamondTextController.text} Diamonds?',
        textCancel: 'Cancel',
        onCancel: () => Get.back(),
        textConfirm: 'Ok',
        onConfirm: () {
          controller.submitLuckyNumber(
              luckyTextController.text, int.parse(diamondTextController.text));
          controller.refreshScreen();
          resetController(luckyTextController, diamondTextController);
          Get.back();
        },
      );
    }
  }

  void resetController(TextEditingController luckyTextController,
      TextEditingController diamondTextController) {
    luckyTextController.text = '';
    diamondTextController.text = '';
  }

  String randomLucky() {
    String randomNum = '';
    Random random = Random();
    for (int i = 0; i < 4; i++) {
      randomNum += random.nextInt(10).toString();
    }
    return randomNum;
  }
}

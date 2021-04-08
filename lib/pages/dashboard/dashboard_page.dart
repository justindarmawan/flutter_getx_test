import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getx_test/pages/lucky/lucky_controller.dart';
import 'package:get/get.dart';

import './dashboard_controller.dart';
import '../../consts/dashboard_items.dart';
import '../../themes/colors.dart';
import '../../widgets/drawer.dart';
import '../home/currencies_controller.dart';

class DashboardPage extends StatelessWidget {
  final CurrenciesController currenciesController = Get.find();
  final LuckyController luckyController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          // appBar: AppBar(title: Obx(() {
          //   switch (controller.tabIndex) {
          //     case 2:
          //       return luckyController.isQuiz
          //           ? Text(dashboardItems[controller.tabIndex]['label'])
          //           : Text('Quiz');
          //       break;
          //     default:
          //       return Text(dashboardItems[controller.tabIndex]['label']);
          //       break;
          //   }
          // })),
          appBar: AppBar(
            title: Text(dashboardItems[controller.tabIndex]['label']),
          ),
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light.copyWith(
              statusBarColor: red,
            ),
            child: SafeArea(
              // child: IndexedStack(
              //   index: controller.tabIndex,
              //   children: dashboardItems
              //       .map((item) => item['item'] as Widget)
              //       .toList(),
              // ),
              child: dashboardItems[controller.tabIndex]['item'],
            ),
          ),
          resizeToAvoidBottomInset: true,
          drawer: DrawerWidget(),
          bottomNavigationBar: BottomNavigationBar(
            onTap: controller.changeTabIndex,
            backgroundColor: red,
            selectedItemColor: white,
            unselectedItemColor: blue,
            currentIndex: controller.tabIndex,
            type: BottomNavigationBarType.fixed,
            items: dashboardItems
                .map((item) => _bottomNavigationBarItem(
                    label: item['label'],
                    icon: item['icon'],
                    activeIcon: item['activeIcon']) as BottomNavigationBarItem)
                .toList(),
          ),
          floatingActionButton: Obx(() {
            return Visibility(
              visible: controller.tabIndex == 1
                  ? currenciesController.getDailyCoin
                  : false,
              child: FloatingActionButton.extended(
                onPressed: () {
                  currenciesController.claimCoin();
                  Get.defaultDialog(
                    title: 'Claimed!',
                    middleText: 'Get 50 Coins',
                    textConfirm: 'Ok',
                    onConfirm: () {
                      Get.back();
                    },
                  );
                },
                label: Text('Claim Your Coin!'),
                icon: const Icon(Icons.cached),
                backgroundColor: Theme.of(context).buttonColor,
              ),
            );
          }),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }

  _bottomNavigationBarItem({String label, IconData icon, IconData activeIcon}) {
    return BottomNavigationBarItem(
      label: label,
      icon: Icon(icon),
      activeIcon: Icon(activeIcon),
      backgroundColor: red,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_getx_test/pages/home/currencies_controller.dart';
import 'package:flutter_getx_test/routes/app_routes.dart';
import 'package:get/get.dart';

import '../../pages/auth/auth_controller.dart';

class HomePage extends GetView<AuthController> {
  final CurrenciesController currenciesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(() {
        return Container(
          height: Get.height,
          child: controller.firstLogin
              ? FutureBuilder(
                  future: currenciesController.refreshScreen(),
                  builder: (context, snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? Center(child: CircularProgressIndicator())
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(controller.userId),
                              Text(currenciesController.getCoin),
                              Text(currenciesController.getDiamond),
                              Text(controller.getLoading.toString()),
                              Text(DateTime.now().toIso8601String()),
                              ElevatedButton(
                                onPressed: () {
                                  controller.logout();
                                  Get.offNamed(AppRoutes.ROOT);
                                },
                                child: Text('Logout'),
                              ),
                            ],
                          );
                  },
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(controller.userId),
                    Text(currenciesController.getCoin),
                    Text(currenciesController.getDiamond),
                    Text(controller.getLoading.toString()),
                    Text(DateTime.now().toIso8601String()),
                    ElevatedButton(
                      onPressed: () {
                        controller.logout();
                        Get.offNamed(AppRoutes.ROOT);
                      },
                      child: Text('Logout'),
                    ),
                  ],
                ),
        );
      }),
    );
  }
}

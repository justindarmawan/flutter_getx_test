import 'package:flutter/material.dart';
import 'package:flutter_getx_test/consts/auth_items.dart';
import 'package:flutter_getx_test/themes/colors.dart';
import 'package:get/get.dart';

import './auth_controller.dart';

class AuthPage extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: white,
        child: Obx(() {
          if (controller.getLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: IndexedStack(
                key: ValueKey<int>(controller.stackIndex),
                index: controller.stackIndex,
                children:
                    authItems.map((item) => item['item'] as Widget).toList(),
              ),
            );
          }
        }),
      ),
    );
  }
}

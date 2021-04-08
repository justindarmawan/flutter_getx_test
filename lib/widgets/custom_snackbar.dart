import 'package:flutter/material.dart';
import 'package:get/get.dart';

void customSnackbar(String title, String message) {
  return Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    margin: EdgeInsets.only(
        bottom: Get.height * 0.05,
        left: Get.width * 0.1,
        right: Get.width * 0.1),
    duration: Duration(seconds: 4),
  );
}

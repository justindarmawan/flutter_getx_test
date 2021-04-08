import 'package:flutter/material.dart';
import 'package:flutter_getx_test/widgets/custom_dialog.dart';
import 'package:get/get.dart';

void luckyDialog(controller) {
  Future.delayed(
    Duration.zero,
    () => Get.dialog(
      FutureBuilder(
          future: controller.getPopupImages(),
          builder: (ctx, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? CustomDialog(
                    imageUrl: null,
                    buttonText: null,
                    loading: true,
                    onPressed: null,
                  )
                : Obx(() {
                    return CustomDialog(
                      imageUrl: controller.images,
                      buttonText:
                          controller.indexImages < controller.lengthImages - 1
                              ? 'Next'
                              : 'Done',
                      loading: false,
                      onPressed: () {
                        if (controller.indexImages <
                            controller.lengthImages - 1) {
                          controller.nextImages();
                        } else {
                          Get.back();
                          controller.firstLoaded();
                        }
                      },
                    );
                  });
          }),
      barrierDismissible: false,
    ),
  );
}

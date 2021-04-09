import 'package:flutter/material.dart';
import 'package:flutter_getx_test/consts/auth_items.dart';
import 'package:flutter_getx_test/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class VerificationWidget extends GetView<AuthController> {
  final _verificationTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 5.0,
          ),
          height: Get.height * 0.4,
          width: Get.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                authItems[controller.stackIndex]['label'],
                style: Theme.of(context).textTheme.headline3,
              ),
              TextField(
                controller: _verificationTextController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '123456',
                  hintStyle: Theme.of(context).textTheme.headline3,
                ),
                onEditingComplete: () => _submit(),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text('Done'),
                    onPressed: () {
                      _submit();
                    },
                  ),
                  TextButton(
                    child: Text('Back'),
                    onPressed: () {
                      controller.changeStackIndex(1);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() async {
    if (_verificationTextController.text.isEmpty ||
        _verificationTextController.text.length < 6) {
      Get.defaultDialog(
        title: 'Warning!',
        middleText: 'Verification code cannot be empty or less than 6 numbers!',
        textConfirm: 'Okay',
        onConfirm: () => Get.back(),
      );
    } else {
      String res =
          await controller.verification(_verificationTextController.text);
      switch (res) {
        case 'CONFIRMED':
          _verificationTextController.clear();
          // _verificationTextController.dispose();
          controller.changeStackIndex(0);
          customSnackbar('Success!', 'Now you can login!');
          break;
        case 'UNCONFIRMED':
          customSnackbar('Failure!', 'Wrong verification code!');
          break;
        case 'FAILURE':
          customSnackbar(
            'Failure!',
            'An error occured! Please try again!',
          );
          break;
      }
    }
  }
}

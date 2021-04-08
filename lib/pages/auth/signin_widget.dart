import 'package:flutter/material.dart';
import 'package:flutter_getx_test/consts/auth_items.dart';
import 'package:flutter_getx_test/routes/app_routes.dart';
import 'package:flutter_getx_test/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class SigninWidget extends StatefulWidget {
  @override
  _SigninWidgetState createState() => _SigninWidgetState();
}

class _SigninWidgetState extends State<SigninWidget> {
  final AuthController _authController = Get.find();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  var _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    final _focusNode = FocusScope.of(context);
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
          height: Get.height * 0.45,
          width: Get.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                authItems[_authController.stackIndex]['label'],
                style: Theme.of(context).textTheme.headline3,
              ),
              TextField(
                controller: _emailTextController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'E-mail',
                ),
                onEditingComplete: () =>
                    _focusNode.requestFocus(_passwordFocusNode),
              ),
              TextField(
                controller: _passwordTextController,
                focusNode: _passwordFocusNode,
                keyboardType: TextInputType.visiblePassword,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                    // prefixIcon: Icon(Icons.vpn_key),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.remove_red_eye_outlined
                            : Icons.remove_red_eye,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    )),
                onEditingComplete: () => _focusNode.unfocus(),
                onSubmitted: (_) => _submit(),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text('Sign In'),
                    onPressed: () {
                      _submit();
                    },
                  ),
                  TextButton(
                    child: Text('Register'),
                    onPressed: () {
                      _authController.changeStackIndex(1);
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
    if (_emailTextController.text.isEmpty ||
        _passwordTextController.text.isEmpty) {
      Get.defaultDialog(
        title: 'Warning!',
        middleText: 'Email or Password can\'t be empty!',
        textConfirm: 'Okay',
        onConfirm: () => Get.back(),
      );
    } else {
      String res = await _authController.login(
        _emailTextController.text,
        _passwordTextController.text,
      );
      switch (res) {
        case 'SUCCESS':
          _emailTextController.clear();
          _passwordTextController.clear();
          _emailTextController.dispose();
          _passwordTextController.dispose();
          Get.offNamed(AppRoutes.ROOT);
          break;
        case 'UNCONFIRMED':
          _authController.changeStackIndex(3);
          break;
        case 'FAILURE':
          customSnackbar(
            'Failure!',
            'E-mail isn\'t registered or Password is wrong!',
          );
          break;
      }
    }
  }
}

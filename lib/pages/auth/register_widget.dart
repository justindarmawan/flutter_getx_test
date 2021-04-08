import 'package:flutter/material.dart';
import 'package:flutter_getx_test/consts/auth_items.dart';
import 'package:flutter_getx_test/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class RegisterWidget extends StatefulWidget {
  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final AuthController _authController = Get.find();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _passwordConfirmTextController = TextEditingController();

  var _passwordVisible;
  var _passwordConfirmVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _passwordConfirmVisible = false;
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
          height: Get.height * 0.6,
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
                onEditingComplete: () => _focusNode.nextFocus(),
              ),
              TextField(
                controller: _passwordTextController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Password',
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
                onSubmitted: (_) => _focusNode.nextFocus(),
              ),
              TextField(
                controller: _passwordConfirmTextController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: !_passwordConfirmVisible,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Confirm Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordConfirmVisible
                            ? Icons.remove_red_eye_outlined
                            : Icons.remove_red_eye,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordConfirmVisible = !_passwordConfirmVisible;
                        });
                      },
                    )),
                onSubmitted: (_) => _submit(),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text('Register'),
                    onPressed: () {
                      _submit();
                    },
                  ),
                  TextButton(
                    child: Text('Login'),
                    onPressed: () => _authController.changeStackIndex(0),
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
        _passwordTextController.text.isEmpty ||
        _passwordConfirmTextController.text.isEmpty) {
      Get.defaultDialog(
        title: 'Warning!',
        middleText: 'Email or Password can\'t be empty!',
        textConfirm: 'Okay',
        onConfirm: () => Get.back(),
      );
    } else if (_passwordTextController.text !=
        _passwordConfirmTextController.text) {
      Get.defaultDialog(
        title: 'Warning!',
        middleText: 'Passwords is not match!',
        textConfirm: 'Okay',
        onConfirm: () => Get.back(),
      );
    } else {
      String _res = await _authController.checkEmail(
        _emailTextController.text,
        _passwordTextController.text,
      );
      switch (_res) {
        case 'USED':
          _emailTextController.clear();
          _passwordTextController.clear();
          _passwordConfirmTextController.clear();
          customSnackbar('Failure!', 'E-mail already used!');
          break;
        case 'UNUSED':
          _authController.changeStackIndex(2);
          break;
      }
    }
  }
}

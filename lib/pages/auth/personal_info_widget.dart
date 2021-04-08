import 'package:flutter/material.dart';
import 'package:flutter_getx_test/consts/auth_items.dart';
import 'package:flutter_getx_test/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class PersonalInfoWidget extends StatefulWidget {
  @override
  _PersonalInfoWidgetState createState() => _PersonalInfoWidgetState();
}

class _PersonalInfoWidgetState extends State<PersonalInfoWidget> {
  final AuthController _authController = Get.find();

  final _firstNameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();

  var _gender;
  var _city;

  final List<String> _genderList = ['Male', 'Female'];
  final List<String> _cityList = ['Jakarta', 'Kuala Lumpur'];

  @override
  void initState() {
    super.initState();
    _gender = _genderList[0];
    _city = _cityList[0];
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
                controller: _firstNameTextController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'First Name',
                ),
                onEditingComplete: () => _focusNode.nextFocus(),
              ),
              TextField(
                controller: _lastNameTextController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Last Name',
                ),
                onEditingComplete: () => _focusNode.nextFocus(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Gender',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 17,
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (result) {
                      setState(() {
                        _gender = result;
                      });
                    },
                    itemBuilder: (ctx) {
                      return _genderList.map((items) {
                        return PopupMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList();
                    },
                    child: Row(
                      children: [
                        Text(
                          _gender,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 17,
                          ),
                        ),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'City',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 17,
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (result) {
                      setState(() {
                        _city = result;
                      });
                    },
                    itemBuilder: (ctx) {
                      return _cityList.map((items) {
                        return PopupMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList();
                    },
                    child: Row(
                      children: [
                        Text(
                          _city,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 17,
                          ),
                        ),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ],
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
    if (_firstNameTextController.text.isEmpty ||
        _lastNameTextController.text.isEmpty) {
      Get.defaultDialog(
        title: 'Warning!',
        middleText: 'Name cannot be empty!',
        textConfirm: 'Okay',
        onConfirm: () => Get.back(),
      );
    } else {
      String res = await _authController.register(
        _firstNameTextController.text,
        _lastNameTextController.text,
        _gender,
        _city,
      );
      switch (res) {
        case 'SUCCESS':
          _firstNameTextController.clear();
          _lastNameTextController.clear();
          // _firstNameTextController.dispose();
          // _lastNameTextController.dispose();
          _authController.changeStackIndex(3);
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

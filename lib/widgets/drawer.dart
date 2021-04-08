import 'package:flutter/material.dart';
import 'package:flutter_getx_test/routes/app_routes.dart';
import 'package:get/get.dart';

import '../themes/colors.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text('CAF'),
            decoration: BoxDecoration(color: red),
          ),
          ListTile(
            title: Text('Profile'),
            leading: Icon(Icons.person),
            onTap: () {
              Get.back();
              Get.toNamed(AppRoutes.PROFILE);
            },
          ),
          ListTile(
            title: Text('Store'),
            leading: Icon(Icons.store),
            onTap: () {
              Get.back();
              Get.toNamed(AppRoutes.STORE);
            },
          )
        ],
      ),
    );
  }
}

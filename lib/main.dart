import 'package:flutter/material.dart';
import 'package:flutter_getx_test/binding.dart';
import 'package:flutter_getx_test/routes/app_routes.dart';
import 'package:get/get.dart';

import './pages/auth/auth_controller.dart';
import './pages/auth/auth_page.dart';
import './pages/dashboard/dashboard_page.dart';
import './pages/splash/splash_page.dart';
import './routes/app_pages.dart';
import './themes/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CAF App',
      defaultTransition: Transition.cupertino,
      initialRoute: AppRoutes.ROOT,
      initialBinding: RootBinding(),
      getPages: AppPages.list,
      // smartManagement: SmartManagement.keepFactory,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: Obx(() {
        print('Checking is auth: ${controller.isAuth}');
        if (controller.isAuth) {
          return DashboardPage();
        } else {
          return FutureBuilder(
            future: controller.tryAutoLogin(),
            builder: (ctx, authResultSnapshot) =>
                authResultSnapshot.connectionState == ConnectionState.waiting
                    ? SplashPage()
                    : AuthPage(),
          );
        }
      }),
    );
  }
}

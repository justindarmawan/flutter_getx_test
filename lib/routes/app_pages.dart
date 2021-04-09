import 'package:flutter_getx_test/pages/game/game_webview.dart';
import 'package:flutter_getx_test/pages/lucky/lucky_history_page.dart';
import 'package:flutter_getx_test/pages/store/payment/payment_page.dart';
import 'package:flutter_getx_test/pages/store/store_binding.dart';
import 'package:get/get.dart';

import '../binding.dart';
import '../main.dart';
import '../pages/auth/auth_page.dart';
import '../pages/dashboard/dashboard_page.dart';
import '../pages/lucky/lucky.dart';
import '../pages/profile/profile_page.dart';
import '../pages/splash/splash_page.dart';
import '../pages/store/store_page.dart';
import '../routes/app_routes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.ROOT,
      page: () => MyApp(),
      binding: RootBinding(),
    ),
    GetPage(
      name: AppRoutes.AUTH,
      page: () => AuthPage(),
    ),
    GetPage(
      name: AppRoutes.DASHBOARD,
      page: () => DashboardPage(),
      // binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashPage(),
    ),
    GetPage(
      name: AppRoutes.LUCKY,
      page: () => Lucky(),
    ),
    GetPage(
      name: AppRoutes.PROFILE,
      page: () => ProfilePage(),
    ),
    GetPage(
      name: AppRoutes.STORE,
      page: () => StorePage(),
      binding: StoreBinding(),
    ),
    GetPage(
      name: AppRoutes.PAYMENT,
      page: () => PaymentPage(),
    ),
    GetPage(
      name: AppRoutes.LUCKYHISTORY,
      page: () => LuckyHistory(),
    ),
    GetPage(
      name: AppRoutes.GAME + '/:gamesName',
      page: () => GameWebview(),
    ),
  ];
}

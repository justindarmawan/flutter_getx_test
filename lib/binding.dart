import 'package:flutter_getx_test/pages/dashboard/dashboard_controller.dart';
import 'package:flutter_getx_test/pages/game/game_controller.dart';
import 'package:flutter_getx_test/pages/lucky/lucky_controller.dart';
import 'package:flutter_getx_test/pages/lucky/quiz_controller.dart';
import 'package:get/get.dart';

import 'pages/auth/auth_controller.dart';
import 'pages/home/currencies_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => DashboardController(), fenix: true);
    Get.lazyPut(() => LuckyController(), fenix: true);
    Get.lazyPut(() => QuizController(), fenix: true);
    Get.lazyPut(() => CurrenciesController(), fenix: true);
    Get.lazyPut(() => GameController(), fenix: true);
  }
}

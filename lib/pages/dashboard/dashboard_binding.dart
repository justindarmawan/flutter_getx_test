import 'package:get/get.dart';

import '../home/currencies_controller.dart';
import '../lucky/lucky_controller.dart';
import '../lucky/quiz_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuizController());
    Get.lazyPut(() => LuckyController());
    Get.lazyPut(() => CurrenciesController());
  }
}

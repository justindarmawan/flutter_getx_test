import 'package:flutter_getx_test/consts/links.dart';
import 'package:flutter_getx_test/models/payments.dart';
import 'package:flutter_getx_test/models/price.dart';
import 'package:flutter_getx_test/pages/home/currencies_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class StoreController extends GetxController {
  final CurrenciesController _currenciesController = Get.find();

  var _dataPrice = RxList<Price>([]);
  var _dataPayment = RxList<Payment>([]);
  var _isLoading = false.obs;
  var _index = 0.obs;

  var _stackIndex = 0.obs;

  void changeStackIndex(int index) {
    _stackIndex.value = index;
    update();
  }

  int get stackIndex {
    return _stackIndex.value;
  }

  List<Price> get dataPrice {
    return _dataPrice;
  }

  List<Payment> get dataPayment {
    return _dataPayment;
  }

  Price get fetchPrice {
    if (_dataPrice.isEmpty) {
      return Price(kode: '', nominal: '', number: '');
    }
    return _dataPrice[_index.value];
  }

  bool get getLoading {
    return _isLoading.value;
  }

  Future<void> getPayment() async {
    _dataPayment.clear();
    try {
      final response = await http.get(Uri.parse(linkGetListPayment));
      final jsonPayment = jsonPaymentFromMap(response.body);
      if (jsonPayment.queryResult == 'DATA') {
        jsonPayment.data.map((item) {
          _dataPayment
              .add(Payment(paymentsName: item.paymentsName, icons: item.icons));
        }).toList();
      }
      return;
    } catch (error) {
      throw error;
    }
  }

  Future<void> getPrice() async {
    _dataPrice.clear();
    try {
      final response = await http.get(Uri.parse(linkGetListPrice));
      final jsonPrice = jsonPriceFromMap(response.body);
      if (jsonPrice.queryResult == 'SUCCESS') {
        jsonPrice.data.map((item) {
          _dataPrice.add(Price(
              kode: item.kode, nominal: item.nominal, number: item.number));
        }).toList();
      }
      return;
    } catch (error) {
      throw error;
    }
  }
}

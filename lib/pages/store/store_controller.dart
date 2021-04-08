import 'package:flutter_getx_test/consts/links.dart';
import 'package:flutter_getx_test/models/price.dart';
import 'package:flutter_getx_test/pages/home/currencies_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class StoreController extends GetxController {
  final CurrenciesController _currenciesController = Get.find();

  var _dataPrice = RxList<Price>([]);
  var _isLoading = false.obs;
  var _index = 0.obs;

  List<Price> get dataPrice {
    return _dataPrice;
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

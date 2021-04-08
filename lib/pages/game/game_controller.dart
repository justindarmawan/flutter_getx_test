import 'dart:convert';

import 'package:flutter_getx_test/models/games.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../consts/links.dart';

class GameController extends GetxController {
  var _dataGames = RxList<Games>([]);
  var _isLoading = false.obs;

  bool get getLoading {
    return _isLoading.value;
  }

  List<Games> get fetchListGames {
    if (_dataGames.isEmpty) {
      return List<Games>.empty();
    }
    return _dataGames;
  }

  Future<void> getListGames() async {
    _dataGames.clear();
    _isLoading.value = true;
    try {
      final response = await http.get(Uri.parse(linkGetListGames));
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      // print(responseData);
      if (responseData['query_result'] == 'DATA') {
        List<String> _gamesName = [];
        List<String> _icons = [];
        responseData['gamesName'].map((data) {
          _gamesName.add(data);
        }).toList();
        responseData['icons'].map((data) {
          _icons.add(data);
        }).toList();
        for (var i = 0; i < _gamesName.length; i++) {
          _dataGames.add(Games(_gamesName[i], _icons[i]));
        }
      }
      _isLoading.value = false;
      return;
    } catch (error) {
      _isLoading.value = false;
      throw error;
    }
  }
}

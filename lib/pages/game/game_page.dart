import 'package:flutter/material.dart';
import 'package:flutter_getx_test/pages/game/game_controller.dart';
import 'package:get/get.dart';

import 'game_widget.dart';

class GamePage extends GetView<GameController> {
  @override
  Widget build(BuildContext context) {
    return controller.fetchListGames.isEmpty
        ? FutureBuilder(
            future: controller.getListGames(),
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? Center(child: CircularProgressIndicator())
                    : GameWidget(),
          )
        : GameWidget();
  }
}

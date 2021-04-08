import 'package:flutter/material.dart';
import 'package:flutter_getx_test/consts/links.dart';
import 'package:flutter_getx_test/routes/app_routes.dart';
import 'package:flutter_getx_test/widgets/shimmering_image.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';

import 'game_controller.dart';

class GameWidget extends GetView<GameController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.getLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: controller.getListGames,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                padding: EdgeInsets.all(20.0),
                itemCount: controller.fetchListGames.length,
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () {
                      print(controller.fetchListGames[i].gamesName);
                      Get.toNamed(AppRoutes.GAME +
                          '/${controller.fetchListGames[i].gamesName}');
                    },
                    child: Column(
                      children: [
                        Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Stack(
                              children: [
                                ShimmeringImage(120, 120),
                                FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image:
                                      '$urlGames${controller.fetchListGames[i].gamesName}/${controller.fetchListGames[i].icons}',
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.contain,
                                  alignment: Alignment.topCenter,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          controller.fetchListGames[i].gamesName,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
    });
  }
}

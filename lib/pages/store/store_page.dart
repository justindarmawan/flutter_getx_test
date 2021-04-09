import 'package:flutter/material.dart';
import 'package:flutter_getx_test/pages/store/store_controller.dart';
import 'package:get/get.dart';

import 'store_widget.dart';

class StorePage extends GetView<StoreController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Store'),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: FutureBuilder(
                future: controller.getPrice(),
                builder: (context, snapshot) =>
                    snapshot.connectionState == ConnectionState.waiting
                        ? CircularProgressIndicator()
                        : StoreWidget()),
          ),
        ),
      ),
    );
  }
}

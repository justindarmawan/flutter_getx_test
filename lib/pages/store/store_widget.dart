import 'package:flutter/material.dart';
import 'package:flutter_getx_test/pages/store/store_controller.dart';
import 'package:flutter_getx_test/routes/app_routes.dart';
import 'package:get/get.dart';

class StoreWidget extends GetView<StoreController> {
  final _amountTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Select the amount of diamonds',
          style: Theme.of(context).textTheme.headline3,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: Get.height * 0.05),
        Container(
          height: Get.height * 0.4,
          width: Get.width * 0.8,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.dataPrice.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20.0),
                      onTap: () => Get.toNamed(AppRoutes.PAYMENT, parameters: {
                        'diamond': controller.dataPrice[index].nominal,
                        'price': controller.dataPrice[index].number,
                      }),
                      child: Column(
                        children: [
                          Text(
                            'Diamond: ${controller.dataPrice[index].nominal}',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          Text(
                            'Rp. ${controller.dataPrice[index].number}',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02),
                ],
              );
            },
          ),
        ),
        SizedBox(height: Get.height * 0.05),
        Container(
          height: Get.height * 0.2,
          width: Get.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _amountTextController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter amount of diamonds',
                ),
                style: Theme.of(context).textTheme.headline5,
              ),
              ElevatedButton(
                  child: Text('Buy'),
                  onPressed: () {
                    Get.toNamed(AppRoutes.PAYMENT, parameters: {
                      'diamond': _amountTextController.text,
                      'price': (int.parse(_amountTextController.text) * 100)
                          .toString(),
                    });
                  })
            ],
          ),
        ),
      ],
    );
  }
}

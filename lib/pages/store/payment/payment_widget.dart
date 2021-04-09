import 'package:flutter/material.dart';
import 'package:flutter_getx_test/consts/links.dart';
import 'package:get/get.dart';

import '../store_controller.dart';

class PaymentWidget extends GetView<StoreController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            width: Get.width * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'You Will Buy ${Get.parameters['diamond']} Diamonds for Rp. ${Get.parameters['price']}',
                    style: Theme.of(context).textTheme.headline5),
              ],
            ),
          ),
        ),
        SizedBox(height: Get.height * 0.05),
        Text('PAYMENT METHOD', style: Theme.of(context).textTheme.headline4),
        SizedBox(height: Get.height * 0.05),
        Container(
          height: Get.height * 0.5,
          width: Get.width * 0.8,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            physics: BouncingScrollPhysics(),
            itemCount: controller.dataPayment.length,
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
                      onTap: () {},
                      child: Column(
                        children: [
                          Image.network(
                            urlPayments +
                                controller.dataPayment[index].paymentsName +
                                '/' +
                                controller.dataPayment[index].icons,
                            width: 200,
                            height: 100,
                            fit: BoxFit.contain,
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
      ],
    );
  }
}

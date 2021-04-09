import 'package:flutter/material.dart';
import 'package:flutter_getx_test/pages/store/payment/payment_widget.dart';
import 'package:get/get.dart';

import '../store_controller.dart';

class PaymentPage extends GetView<StoreController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: FutureBuilder(
              future: controller.getPayment(),
              builder: (context, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? CircularProgressIndicator()
                      : PaymentWidget(),
            ),
          ),
        ),
      ),
    );
  }
}

// To parse this JSON data, do
//
//     final jsonPayment = jsonPaymentFromMap(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

JsonPayment jsonPaymentFromMap(String str) =>
    JsonPayment.fromMap(json.decode(str));

String jsonPaymentToMap(JsonPayment data) => json.encode(data.toMap());

class JsonPayment {
  JsonPayment({
    @required this.queryResult,
    @required this.data,
  });

  final String queryResult;
  final List<Payment> data;

  factory JsonPayment.fromMap(Map<String, dynamic> json) => JsonPayment(
        queryResult: json["query_result"],
        data: List<Payment>.from(json["data"].map((x) => Payment.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "query_result": queryResult,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Payment {
  Payment({
    @required this.paymentsName,
    @required this.icons,
  });

  final String paymentsName;
  final String icons;

  factory Payment.fromMap(Map<String, dynamic> json) => Payment(
        paymentsName: json["paymentsName"],
        icons: json["icons"],
      );

  Map<String, dynamic> toMap() => {
        "paymentsName": paymentsName,
        "icons": icons,
      };
}

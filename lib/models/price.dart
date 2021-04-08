// To parse this JSON data, do
//
//     final jsonPrice = jsonPriceFromMap(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

JsonPrice jsonPriceFromMap(String str) => JsonPrice.fromMap(json.decode(str));

String jsonPriceToMap(JsonPrice data) => json.encode(data.toMap());

class JsonPrice {
  JsonPrice({
    @required this.queryResult,
    @required this.data,
  });

  final String queryResult;
  final List<Price> data;

  factory JsonPrice.fromMap(Map<String, dynamic> json) => JsonPrice(
        queryResult: json["query_result"],
        data: List<Price>.from(json["data"].map((x) => Price.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "query_result": queryResult,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Price {
  Price({
    @required this.kode,
    @required this.nominal,
    @required this.number,
  });

  final String kode;
  final String nominal;
  final String number;

  factory Price.fromMap(Map<String, dynamic> json) => Price(
        kode: json["kode"],
        nominal: json["nominal"],
        number: json["number"],
      );

  Map<String, dynamic> toMap() => {
        "kode": kode,
        "nominal": nominal,
        "number": number,
      };
}

// To parse this JSON data, do
//
//     final getTopProductModel = getTopProductModelFromJson(jsonString);

import 'dart:convert';

GetTopProductModel getTopProductModelFromJson(String str) =>
    GetTopProductModel.fromJson(json.decode(str));

String getTopProductModelToJson(GetTopProductModel data) =>
    json.encode(data.toJson());

class GetTopProductModel {
  Status? status;
  List<Datum>? data;

  GetTopProductModel({
    this.status,
    this.data,
  });

  factory GetTopProductModel.fromJson(Map<String, dynamic> json) =>
      GetTopProductModel(
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status?.toJson(),
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  String? productImageUrl;
  double? offerPrice;
  String? productDescription;
  String? productName;
  int? subscriptionCount;

  Datum({
    this.id,
    this.productImageUrl,
    this.offerPrice,
    this.productDescription,
    this.productName,
    this.subscriptionCount,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        productImageUrl: json["productImageUrl"],
        offerPrice: json["offerPrice"],
        productDescription: json["productDescription"],
        productName: json["productName"],
        subscriptionCount: json["subscriptionCount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productImageUrl": productImageUrl,
        "offerPrice": offerPrice,
        "productDescription": productDescription,
        "productName": productName,
        "subscriptionCount": subscriptionCount,
      };
}

class Status {
  String? httpCode;
  bool? success;
  String? message;

  Status({
    this.httpCode,
    this.success,
    this.message,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        httpCode: json["httpCode"],
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "httpCode": httpCode,
        "success": success,
        "message": message,
      };
}

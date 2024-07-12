// To parse this JSON data, do
//
//     final getBillingDetailModel = getBillingDetailModelFromJson(jsonString);

import 'dart:convert';

GetBillingDetailModel getBillingDetailModelFromJson(String str) =>
    GetBillingDetailModel.fromJson(json.decode(str));

String getBillingDetailModelToJson(GetBillingDetailModel data) =>
    json.encode(data.toJson());

class GetBillingDetailModel {
  Status? status;
  Data? data;

  GetBillingDetailModel({
    this.status,
    this.data,
  });

  factory GetBillingDetailModel.fromJson(Map<String, dynamic> json) =>
      GetBillingDetailModel(
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status?.toJson(),
        "data": data?.toJson(),
      };
}

class Data {
  String? productName;
  dynamic productPrice;
  int? quantity;
  dynamic totalPrice;
  double? amountWithDelivery;
  int? deliveryDate;
  int? billingId;

  Data({
    this.productName,
    this.productPrice,
    this.quantity,
    this.totalPrice,
    this.amountWithDelivery,
    this.deliveryDate,
    this.billingId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        productName: json["productName"],
        productPrice: json["productPrice"],
        quantity: json["quantity"],
        totalPrice: json["totalPrice"],
        amountWithDelivery: json["amountWithDelivery"],
        deliveryDate: json["deliveryDate"],
        billingId: json["billingId"],
      );

  Map<String, dynamic> toJson() => {
        "productName": productName,
        "productPrice": productPrice,
        "quantity": quantity,
        "totalPrice": totalPrice,
        "amountWithDelivery": amountWithDelivery,
        "deliveryDate": deliveryDate,
        "billingId": billingId,
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

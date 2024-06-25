// To parse this JSON data, do
//
//     final addSubscriptionModel = addSubscriptionModelFromJson(jsonString);

import 'dart:convert';

AddSubscriptionModel addSubscriptionModelFromJson(String str) =>
    AddSubscriptionModel.fromJson(json.decode(str));

String addSubscriptionModelToJson(AddSubscriptionModel data) =>
    json.encode(data.toJson());

class AddSubscriptionModel {
  Status? status;
  Data? data;

  AddSubscriptionModel({
    this.status,
    this.data,
  });

  factory AddSubscriptionModel.fromJson(Map<String, dynamic> json) =>
      AddSubscriptionModel(
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status?.toJson(),
        "data": data?.toJson(),
      };
}

class Data {
  int? userId;
  int? productId;
  String? productName;
  dynamic imageUrl;
  int? quantity;
  String? subscriptionType;
  DateTime? startDate;
  int? subscriptionId;
  dynamic scheduledDates;
  double? deliveryCharge;
  dynamic totalCustomers;
  int? price;

  Data({
    this.userId,
    this.productId,
    this.productName,
    this.imageUrl,
    this.quantity,
    this.subscriptionType,
    this.startDate,
    this.subscriptionId,
    this.scheduledDates,
    this.deliveryCharge,
    this.totalCustomers,
    this.price,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["userId"],
        productId: json["productId"],
        productName: json["productName"],
        imageUrl: json["imageUrl"],
        quantity: json["quantity"],
        subscriptionType: json["subscriptionType"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        subscriptionId: json["subscriptionId"],
        scheduledDates: json["scheduledDates"],
        deliveryCharge: json["deliveryCharge"],
        totalCustomers: json["totalCustomers"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "productId": productId,
        "productName": productName,
        "imageUrl": imageUrl,
        "quantity": quantity,
        "subscriptionType": subscriptionType,
        "startDate":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "subscriptionId": subscriptionId,
        "scheduledDates": scheduledDates,
        "deliveryCharge": deliveryCharge,
        "totalCustomers": totalCustomers,
        "price": price,
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

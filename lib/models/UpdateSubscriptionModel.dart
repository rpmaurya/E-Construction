// To parse this JSON data, do
//
//     final updateSubscriptionModel = updateSubscriptionModelFromJson(jsonString);

import 'dart:convert';

UpdateSubscriptionModel updateSubscriptionModelFromJson(String str) =>
    UpdateSubscriptionModel.fromJson(json.decode(str));

String updateSubscriptionModelToJson(UpdateSubscriptionModel data) =>
    json.encode(data.toJson());

class UpdateSubscriptionModel {
  Status? status;
  Data? data;

  UpdateSubscriptionModel({
    this.status,
    this.data,
  });

  factory UpdateSubscriptionModel.fromJson(Map<String, dynamic> json) =>
      UpdateSubscriptionModel(
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
  String? imageUrl;
  int? quantity;
  dynamic subscriptionType;
  dynamic startDate;
  int? subscriptionId;
  dynamic scheduledDates;
  dynamic deliveryCharge;
  dynamic totalCustomers;
  double? price;

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
        startDate: json["startDate"],
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
        "startDate": startDate,
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

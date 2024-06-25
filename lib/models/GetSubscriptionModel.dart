// To parse this JSON data, do
//
//     final getSubscriptionModel = getSubscriptionModelFromJson(jsonString);

import 'dart:convert';

GetSubscriptionModel getSubscriptionModelFromJson(String str) =>
    GetSubscriptionModel.fromJson(json.decode(str));

String getSubscriptionModelToJson(GetSubscriptionModel data) =>
    json.encode(data.toJson());

class GetSubscriptionModel {
  Status? status;
  Data? data;

  GetSubscriptionModel({
    this.status,
    this.data,
  });

  factory GetSubscriptionModel.fromJson(Map<String, dynamic> json) =>
      GetSubscriptionModel(
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status?.toJson(),
        "data": data?.toJson(),
      };
}

class Data {
  List<Content>? content;
  int? totalElements;
  int? totalPages;
  int? number;

  Data({
    this.content,
    this.totalElements,
    this.totalPages,
    this.number,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        content: json["content"] == null
            ? []
            : List<Content>.from(
                json["content"]!.map((x) => Content.fromJson(x))),
        totalElements: json["totalElements"],
        totalPages: json["totalPages"],
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "content": content == null
            ? []
            : List<dynamic>.from(content!.map((x) => x.toJson())),
        "totalElements": totalElements,
        "totalPages": totalPages,
        "number": number,
      };
}

class Content {
  int? userId;
  int? productId;
  String? productName;
  DateTime? pauseDate;
  String? imageUrl;
  int? temporaryQuantity;
  String? subscriptionChangeStatus;
  int? quantity;
  String? subscriptionType;
  DateTime? startDate;
  int? subscriptionId;
  dynamic scheduledDates;
  dynamic deliveryCharge;
  dynamic totalCustomers;
  int? price;

  Content({
    this.userId,
    this.productId,
    this.productName,
    this.pauseDate,
    this.imageUrl,
    this.temporaryQuantity,
    this.subscriptionChangeStatus,
    this.quantity,
    this.subscriptionType,
    this.startDate,
    this.subscriptionId,
    this.scheduledDates,
    this.deliveryCharge,
    this.totalCustomers,
    this.price,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        userId: json["userId"],
        productId: json["productId"],
        productName: json["productName"],
        pauseDate: json["pauseDate"] == null
            ? null
            : DateTime.parse(json["pauseDate"]),
        imageUrl: json["imageUrl"],
        temporaryQuantity: json["temporaryQuantity"],
        subscriptionChangeStatus: json["subscriptionChangeStatus"],
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
        "pauseDate":
            "${pauseDate!.year.toString().padLeft(4, '0')}-${pauseDate!.month.toString().padLeft(2, '0')}-${pauseDate!.day.toString().padLeft(2, '0')}",
        "imageUrl": imageUrl,
        "temporaryQuantity": temporaryQuantity,
        "subscriptionChangeStatus": subscriptionChangeStatus,
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

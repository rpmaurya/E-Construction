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
  String? imageUrl;
  int? quantity;
  String? subscriptionType;
  DateTime? startDate;
  int? subscriptionId;
  dynamic scheduledDates;
  double? deliveryCharge;
  dynamic totalCustomers;
  double? price;

  Content({
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

  factory Content.fromJson(Map<String, dynamic> json) => Content(
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

enum ProductName { APPLE_JUICE, LEMON_JUICE, TROLLY }

final productNameValues = EnumValues({
  "AppleJuice": ProductName.APPLE_JUICE,
  "LemonJuice": ProductName.LEMON_JUICE,
  "Trolly": ProductName.TROLLY
});

enum SubscriptionType { DAILY, MONTHLY, WEEKLY }

final subscriptionTypeValues = EnumValues({
  "DAILY": SubscriptionType.DAILY,
  "MONTHLY": SubscriptionType.MONTHLY,
  "WEEKLY": SubscriptionType.WEEKLY
});

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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

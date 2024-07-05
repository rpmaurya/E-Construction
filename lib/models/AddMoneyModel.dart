// To parse this JSON data, do
//
//     final addMoneyModel = addMoneyModelFromJson(jsonString);

import 'dart:convert';

AddMoneyModel addMoneyModelFromJson(String str) =>
    AddMoneyModel.fromJson(json.decode(str));

String addMoneyModelToJson(AddMoneyModel data) => json.encode(data.toJson());

class AddMoneyModel {
  Status? status;
  Data? data;

  AddMoneyModel({
    this.status,
    this.data,
  });

  factory AddMoneyModel.fromJson(Map<String, dynamic> json) => AddMoneyModel(
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status?.toJson(),
        "data": data?.toJson(),
      };
}

class Data {
  Headers? headers;
  Body? body;
  int? statusCodeValue;
  String? statusCode;

  Data({
    this.headers,
    this.body,
    this.statusCodeValue,
    this.statusCode,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        headers:
            json["headers"] == null ? null : Headers.fromJson(json["headers"]),
        body: json["body"] == null ? null : Body.fromJson(json["body"]),
        statusCodeValue: json["statusCodeValue"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "headers": headers?.toJson(),
        "body": body?.toJson(),
        "statusCodeValue": statusCodeValue,
        "statusCode": statusCode,
      };
}

class Body {
  int? userId;
  String? status;
  double? amount;
  String? razorpayId;
  int? createdAt;
  int? updatedAt;

  Body({
    this.userId,
    this.status,
    this.amount,
    this.razorpayId,
    this.createdAt,
    this.updatedAt,
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        userId: json["userId"],
        status: json["status"],
        amount: json["amount"],
        razorpayId: json["razorpayId"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "status": status,
        "amount": amount,
        "razorpayId": razorpayId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}

class Headers {
  Headers();

  factory Headers.fromJson(Map<String, dynamic> json) => Headers();

  Map<String, dynamic> toJson() => {};
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

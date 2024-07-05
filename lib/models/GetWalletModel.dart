// To parse this JSON data, do
//
//     final getWalletModel = getWalletModelFromJson(jsonString);

import 'dart:convert';

GetWalletModel getWalletModelFromJson(String str) =>
    GetWalletModel.fromJson(json.decode(str));

String getWalletModelToJson(GetWalletModel data) => json.encode(data.toJson());

class GetWalletModel {
  Status? status;
  Data? data;

  GetWalletModel({
    this.status,
    this.data,
  });

  factory GetWalletModel.fromJson(Map<String, dynamic> json) => GetWalletModel(
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
  String? status;
  double? amount;
  dynamic razorpayId;
  dynamic createdAt;
  dynamic updatedAt;

  Data({
    this.userId,
    this.status,
    this.amount,
    this.razorpayId,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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

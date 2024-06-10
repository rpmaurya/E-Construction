// To parse this JSON data, do
//
//     final otpVerifyModel = otpVerifyModelFromJson(jsonString);

import 'dart:convert';

OtpVerifyModel otpVerifyModelFromJson(String str) =>
    OtpVerifyModel.fromJson(json.decode(str));

String otpVerifyModelToJson(OtpVerifyModel data) => json.encode(data.toJson());

class OtpVerifyModel {
  Status? status;
  Data? data;

  OtpVerifyModel({
    this.status,
    this.data,
  });

  factory OtpVerifyModel.fromJson(Map<String, dynamic> json) => OtpVerifyModel(
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status?.toJson(),
        "data": data?.toJson(),
      };
}

class Data {
  dynamic name;
  dynamic otp;
  int? userId;
  bool? validUser;
  dynamic email;
  String? mobileNo;
  String? token;

  Data({
    this.name,
    this.otp,
    this.userId,
    this.validUser,
    this.email,
    this.mobileNo,
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        otp: json["otp"],
        userId: json["userId"],
        validUser: json["validUser"],
        email: json["email"],
        mobileNo: json["mobileNo"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "otp": otp,
        "userId": userId,
        "validUser": validUser,
        "email": email,
        "mobileNo": mobileNo,
        "token": token,
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

// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  Status? status;
  Data? data;

  LoginModel({
    this.status,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
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
  String? otp;
  dynamic validUser;
  dynamic email;
  String? mobileNo;
  dynamic token;

  Data({
    this.name,
    this.otp,
    this.validUser,
    this.email,
    this.mobileNo,
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        otp: json["otp"],
        validUser: json["validUser"],
        email: json["email"],
        mobileNo: json["mobileNo"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "otp": otp,
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

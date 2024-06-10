// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  Status? status;
  Data? data;

  RegisterModel({
    this.status,
    this.data,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status?.toJson(),
        "data": data?.toJson(),
      };
}

class Data {
  int? id;
  String? userId;
  String? email;
  String? firstName;
  String? lastName;
  String? mobileNo;
  String? countryCode;
  bool? validUser;
  bool? active;
  int? createdAt;
  dynamic updatedAt;

  Data({
    this.id,
    this.userId,
    this.email,
    this.firstName,
    this.lastName,
    this.mobileNo,
    this.countryCode,
    this.validUser,
    this.active,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["userId"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        mobileNo: json["mobileNo"],
        countryCode: json["countryCode"],
        validUser: json["validUser"],
        active: json["active"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "mobileNo": mobileNo,
        "countryCode": countryCode,
        "validUser": validUser,
        "active": active,
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

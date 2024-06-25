// To parse this JSON data, do
//
//     final resumeSubscriptionModel = resumeSubscriptionModelFromJson(jsonString);

import 'dart:convert';

ResumeSubscriptionModel resumeSubscriptionModelFromJson(String str) =>
    ResumeSubscriptionModel.fromJson(json.decode(str));

String resumeSubscriptionModelToJson(ResumeSubscriptionModel data) =>
    json.encode(data.toJson());

class ResumeSubscriptionModel {
  Status? status;
  Data? data;

  ResumeSubscriptionModel({
    this.status,
    this.data,
  });

  factory ResumeSubscriptionModel.fromJson(Map<String, dynamic> json) =>
      ResumeSubscriptionModel(
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
  String? body;
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
        body: json["body"],
        statusCodeValue: json["statusCodeValue"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "headers": headers?.toJson(),
        "body": body,
        "statusCodeValue": statusCodeValue,
        "statusCode": statusCode,
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

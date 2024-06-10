// To parse this JSON data, do
//
//     final updateProductListModel = updateProductListModelFromJson(jsonString);

import 'dart:convert';

UpdateProductListModel updateProductListModelFromJson(String str) => UpdateProductListModel.fromJson(json.decode(str));

String updateProductListModelToJson(UpdateProductListModel data) => json.encode(data.toJson());

class UpdateProductListModel {
    Status? status;
    Data? data;

    UpdateProductListModel({
        this.status,
        this.data,
    });

    factory UpdateProductListModel.fromJson(Map<String, dynamic> json) => UpdateProductListModel(
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
    String? statusCode;
    int? statusCodeValue;

    Data({
        this.headers,
        this.body,
        this.statusCode,
        this.statusCodeValue,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        headers: json["headers"] == null ? null : Headers.fromJson(json["headers"]),
        body: json["body"] == null ? null : Body.fromJson(json["body"]),
        statusCode: json["statusCode"],
        statusCodeValue: json["statusCodeValue"],
    );

    Map<String, dynamic> toJson() => {
        "headers": headers?.toJson(),
        "body": body?.toJson(),
        "statusCode": statusCode,
        "statusCodeValue": statusCodeValue,
    };
}

class Body {
    int? quantity;
    String? message;

    Body({
        this.quantity,
        this.message,
    });

    factory Body.fromJson(Map<String, dynamic> json) => Body(
        quantity: json["quantity"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "message": message,
    };
}

class Headers {
    Headers();

    factory Headers.fromJson(Map<String, dynamic> json) => Headers(
    );

    Map<String, dynamic> toJson() => {
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

// To parse this JSON data, do
//
//     final subCategoryModel = subCategoryModelFromJson(jsonString);

import 'dart:convert';

SubCategoryModel subCategoryModelFromJson(String str) => SubCategoryModel.fromJson(json.decode(str));

String subCategoryModelToJson(SubCategoryModel data) => json.encode(data.toJson());

class SubCategoryModel {
    Status? status;
    List<SubcategoryData>? data;

    SubCategoryModel({
        this.status,
        this.data,
    });

    factory SubCategoryModel.fromJson(Map<String, dynamic> json) => SubCategoryModel(
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        data: json["data"] == null ? [] : List<SubcategoryData>.from(json["data"]!.map((x) => SubcategoryData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class SubcategoryData {
    int? subCategoryId;
    String? subCategoryName;
    int? createdAt;
    int? updatedAt;
    int? categoryId;
    String? categoryName;

    SubcategoryData({
        this.subCategoryId,
        this.subCategoryName,
        this.createdAt,
        this.updatedAt,
        this.categoryId,
        this.categoryName,
    });

    factory SubcategoryData.fromJson(Map<String, dynamic> json) => SubcategoryData(
        subCategoryId: json["subCategoryId"],
        subCategoryName: json["subCategoryName"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
    );

    Map<String, dynamic> toJson() => {
        "subCategoryId": subCategoryId,
        "subCategoryName": subCategoryName,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "categoryId": categoryId,
        "categoryName": categoryName,
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

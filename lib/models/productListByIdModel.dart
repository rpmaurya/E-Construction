// To parse this JSON data, do
//
//     final productListByIdModel = productListByIdModelFromJson(jsonString);

import 'dart:convert';

ProductListByIdModel productListByIdModelFromJson(String str) =>
    ProductListByIdModel.fromJson(json.decode(str));

String productListByIdModelToJson(ProductListByIdModel data) =>
    json.encode(data.toJson());

class ProductListByIdModel {
  Status? status;
  Data? data;

  ProductListByIdModel({
    this.status,
    this.data,
  });

  factory ProductListByIdModel.fromJson(Map<String, dynamic> json) =>
      ProductListByIdModel(
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
  String? productName;
  String? productDescription;
  int? price;
  int? offerPrice;
  int? quantity;
  int? categoryId;
  bool? isDeleted;
  String? categoryName;
  int? brandId;
  String? brandName;
  int? subCategoryId;
  String? subCategoryName;
  int? createdDate;
  int? updatedDate;
  dynamic subscriptions;

  Data({
    this.id,
    this.productName,
    this.productDescription,
    this.price,
    this.offerPrice,
    this.quantity,
    this.categoryId,
    this.isDeleted,
    this.categoryName,
    this.brandId,
    this.brandName,
    this.subCategoryId,
    this.subCategoryName,
    this.createdDate,
    this.updatedDate,
    this.subscriptions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        productName: json["productName"],
        productDescription: json["productDescription"],
        price: json["price"],
        offerPrice: json["offerPrice"],
        quantity: json["quantity"],
        categoryId: json["categoryId"],
        isDeleted: json["isDeleted"],
        categoryName: json["categoryName"],
        brandId: json["brandId"],
        brandName: json["brandName"],
        subCategoryId: json["subCategoryId"],
        subCategoryName: json["subCategoryName"],
        createdDate: json["createdDate"],
        updatedDate: json["updatedDate"],
        subscriptions: json["subscriptions"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productName": productName,
        "productDescription": productDescription,
        "price": price,
        "offerPrice": offerPrice,
        "quantity": quantity,
        "categoryId": categoryId,
        "isDeleted": isDeleted,
        "categoryName": categoryName,
        "brandId": brandId,
        "brandName": brandName,
        "subCategoryId": subCategoryId,
        "subCategoryName": subCategoryName,
        "createdDate": createdDate,
        "updatedDate": updatedDate,
        "subscriptions": subscriptions,
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

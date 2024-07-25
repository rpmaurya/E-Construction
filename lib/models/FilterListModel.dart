// To parse this JSON data, do
//
//     final filterListModel = filterListModelFromJson(jsonString);

import 'dart:convert';

FilterListModel filterListModelFromJson(String str) =>
    FilterListModel.fromJson(json.decode(str));

String filterListModelToJson(FilterListModel data) =>
    json.encode(data.toJson());

class FilterListModel {
  Status? status;
  List<Datum>? data;

  FilterListModel({
    this.status,
    this.data,
  });

  factory FilterListModel.fromJson(Map<String, dynamic> json) =>
      FilterListModel(
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status?.toJson(),
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  String? productName;
  String? productDescription;
  double? price;
  double? offerPrice;
  int? quantity;
  int? userSelectedQuantity;
  bool? isDeleted;
  int? brandId;
  String? brandName;
  int? createdDate;
  int? updatedDate;
  String? productImageUrl;
  int? subscribedCustomers;

  Datum({
    this.id,
    this.productName,
    this.productDescription,
    this.price,
    this.offerPrice,
    this.quantity,
    this.userSelectedQuantity,
    this.isDeleted,
    this.brandId,
    this.brandName,
    this.createdDate,
    this.updatedDate,
    this.productImageUrl,
    this.subscribedCustomers,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        productName: json["productName"],
        productDescription: json["productDescription"],
        price: json["price"],
        offerPrice: json["offerPrice"],
        quantity: json["quantity"],
        userSelectedQuantity: json["userSelectedQuantity"],
        isDeleted: json["isDeleted"],
        brandId: json["brandId"],
        brandName: json["brandName"],
        createdDate: json["createdDate"],
        updatedDate: json["updatedDate"],
        productImageUrl: json["productImageUrl"],
        subscribedCustomers: json["subscribedCustomers"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productName": productName,
        "productDescription": productDescription,
        "price": price,
        "offerPrice": offerPrice,
        "quantity": quantity,
        "userSelectedQuantity": userSelectedQuantity,
        "isDeleted": isDeleted,
        "brandId": brandId,
        "brandName": brandName,
        "createdDate": createdDate,
        "updatedDate": updatedDate,
        "productImageUrl": productImageUrl,
        "subscribedCustomers": subscribedCustomers,
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

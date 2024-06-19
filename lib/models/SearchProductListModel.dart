// To parse this JSON data, do
//
//     final searchProductListModel = searchProductListModelFromJson(jsonString);

import 'dart:convert';

SearchProductListModel searchProductListModelFromJson(String str) =>
    SearchProductListModel.fromJson(json.decode(str));

String searchProductListModelToJson(SearchProductListModel data) =>
    json.encode(data.toJson());

class SearchProductListModel {
  Status? status;
  Data? data;

  SearchProductListModel({
    this.status,
    this.data,
  });

  factory SearchProductListModel.fromJson(Map<String, dynamic> json) =>
      SearchProductListModel(
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status?.toJson(),
        "data": data?.toJson(),
      };
}

class Data {
  List<Content>? content;
  int? totalElements;
  int? totalPages;
  int? number;

  Data({
    this.content,
    this.totalElements,
    this.totalPages,
    this.number,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        content: json["content"] == null
            ? []
            : List<Content>.from(
                json["content"]!.map((x) => Content.fromJson(x))),
        totalElements: json["totalElements"],
        totalPages: json["totalPages"],
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "content": content == null
            ? []
            : List<dynamic>.from(content!.map((x) => x.toJson())),
        "totalElements": totalElements,
        "totalPages": totalPages,
        "number": number,
      };
}

class Content {
  int? id;
  String? productName;
  String? productDescription;
  double? price;
  double? offerPrice;
  int? quantity;
  Map<String, List<Category>>? categories;
  dynamic userSelectedquantity;
  bool? isDeleted;
  int? brandId;
  String? brandName;
  int? productTypeId;
  String? productTypeName;
  int? createdDate;
  int? updatedDate;
  String? productImageUrl;
  dynamic subscriptions;
  int? subscribedCustomers;

  Content({
    this.id,
    this.productName,
    this.productDescription,
    this.price,
    this.offerPrice,
    this.quantity,
    this.categories,
    this.userSelectedquantity,
    this.isDeleted,
    this.brandId,
    this.brandName,
    this.productTypeId,
    this.productTypeName,
    this.createdDate,
    this.updatedDate,
    this.productImageUrl,
    this.subscriptions,
    this.subscribedCustomers,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        productName: json["productName"],
        productDescription: json["productDescription"],
        price: json["price"],
        offerPrice: json["offerPrice"],
        quantity: json["quantity"],
        categories: Map.from(json["categories"]!).map((k, v) =>
            MapEntry<String, List<Category>>(
                k, List<Category>.from(v.map((x) => Category.fromJson(x))))),
        userSelectedquantity: json["userSelectedquantity"],
        isDeleted: json["isDeleted"],
        brandId: json["brandId"],
        brandName: json["brandName"],
        productTypeId: json["productTypeId"],
        productTypeName: json["productTypeName"],
        createdDate: json["createdDate"],
        updatedDate: json["updatedDate"],
        productImageUrl: json["productImageUrl"],
        subscriptions: json["subscriptions"],
        subscribedCustomers: json["subscribedCustomers"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productName": productName,
        "productDescription": productDescription,
        "price": price,
        "offerPrice": offerPrice,
        "quantity": quantity,
        "categories": Map.from(categories!).map((k, v) =>
            MapEntry<String, dynamic>(
                k, List<dynamic>.from(v.map((x) => x.toJson())))),
        "userSelectedquantity": userSelectedquantity,
        "isDeleted": isDeleted,
        "brandId": brandId,
        "brandName": brandName,
        "productTypeId": productTypeId,
        "productTypeName": productTypeName,
        "createdDate": createdDate,
        "updatedDate": updatedDate,
        "productImageUrl": productImageUrl,
        "subscriptions": subscriptions,
        "subscribedCustomers": subscribedCustomers,
      };
}

class Category {
  int? subCategoryId;
  String? subCategoryName;
  int? createdAt;
  int? updatedAt;
  int? categoryId;
  String? categoryName;

  Category({
    this.subCategoryId,
    this.subCategoryName,
    this.createdAt,
    this.updatedAt,
    this.categoryId,
    this.categoryName,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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

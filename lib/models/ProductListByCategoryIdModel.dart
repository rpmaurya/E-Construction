// To parse this JSON data, do
//
//     final productListByCategoryIdModel = productListByCategoryIdModelFromJson(jsonString);

import 'dart:convert';

ProductListByCategoryIdModel productListByCategoryIdModelFromJson(String str) => ProductListByCategoryIdModel.fromJson(json.decode(str));

String productListByCategoryIdModelToJson(ProductListByCategoryIdModel data) => json.encode(data.toJson());

class ProductListByCategoryIdModel {
    Status? status;
    List<ProductListByCategoryId>? data;

    ProductListByCategoryIdModel({
        this.status,
        this.data,
    });

    factory ProductListByCategoryIdModel.fromJson(Map<String, dynamic> json) => ProductListByCategoryIdModel(
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        data: json["data"] == null ? [] : List<ProductListByCategoryId>.from(json["data"]!.map((x) => ProductListByCategoryId.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class ProductListByCategoryId {
    int? id;
    String? productName;
    String? productDescription;
    double? price;
    double? offerPrice;
    int? quantity;
    int? userSelectedquantity;
    int? categoryId;
    bool? isDeleted;
    String? categoryName;
    int? brandId;
    String? brandName;
    int? subCategoryId;
    String? subCategoryName;
    int? createdDate;
    int? updatedDate;
    String? productImageUrl;
    List<dynamic>? imageUrls;
    dynamic subscriptions;
    int? subscribedCustomers;

    ProductListByCategoryId({
        this.id,
        this.productName,
        this.productDescription,
        this.price,
        this.offerPrice,
        this.quantity,
        this.userSelectedquantity,
        this.categoryId,
        this.isDeleted,
        this.categoryName,
        this.brandId,
        this.brandName,
        this.subCategoryId,
        this.subCategoryName,
        this.createdDate,
        this.updatedDate,
        this.productImageUrl,
        this.imageUrls,
        this.subscriptions,
        this.subscribedCustomers,
    });

    factory ProductListByCategoryId.fromJson(Map<String, dynamic> json) => ProductListByCategoryId(
        id: json["id"],
        productName: json["productName"],
        productDescription: json["productDescription"],
        price: json["price"],
        offerPrice: json["offerPrice"],
        quantity: json["quantity"],
        userSelectedquantity: json["userSelectedquantity"],
        categoryId: json["categoryId"],
        isDeleted: json["isDeleted"],
        categoryName: json["categoryName"],
        brandId: json["brandId"],
        brandName: json["brandName"],
        subCategoryId: json["subCategoryId"],
        subCategoryName: json["subCategoryName"],
        createdDate: json["createdDate"],
        updatedDate: json["updatedDate"],
        productImageUrl: json["productImageUrl"],
        imageUrls: json["imageUrls"] == null ? [] : List<dynamic>.from(json["imageUrls"]!.map((x) => x)),
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
        "userSelectedquantity": userSelectedquantity,
        "categoryId": categoryId,
        "isDeleted": isDeleted,
        "categoryName": categoryName,
        "brandId": brandId,
        "brandName": brandName,
        "subCategoryId": subCategoryId,
        "subCategoryName": subCategoryName,
        "createdDate": createdDate,
        "updatedDate": updatedDate,
        "productImageUrl": productImageUrl,
        "imageUrls": imageUrls == null ? [] : List<dynamic>.from(imageUrls!.map((x) => x)),
        "subscriptions": subscriptions,
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

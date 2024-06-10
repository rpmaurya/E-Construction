// To parse this JSON data, do
//
//     final cartProductListModel = cartProductListModelFromJson(jsonString);

import 'dart:convert';

CartProductListModel cartProductListModelFromJson(String str) => CartProductListModel.fromJson(json.decode(str));

String cartProductListModelToJson(CartProductListModel data) => json.encode(data.toJson());

class CartProductListModel {
    Status? status;
    Data? data;

    CartProductListModel({
        this.status,
        this.data,
    });

    factory CartProductListModel.fromJson(Map<String, dynamic> json) => CartProductListModel(
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status?.toJson(),
        "data": data?.toJson(),
    };
}

class Data {
    List<CartResponseList>? cartResponseList;
    OrderSummary? orderSummary;

    Data({
        this.cartResponseList,
        this.orderSummary,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        cartResponseList: json["cartResponseList"] == null ? [] : List<CartResponseList>.from(json["cartResponseList"]!.map((x) => CartResponseList.fromJson(x))),
        orderSummary: json["orderSummary"] == null ? null : OrderSummary.fromJson(json["orderSummary"]),
    );

    Map<String, dynamic> toJson() => {
        "cartResponseList": cartResponseList == null ? [] : List<dynamic>.from(cartResponseList!.map((x) => x.toJson())),
        "orderSummary": orderSummary?.toJson(),
    };
}

class CartResponseList {
    int? userId;
    String? imageurl;
    int? productId;
    String? productName;
    int? quantity;
    double? totalPrice;
    dynamic imageUrls;
    DateTime? today;
    double? price;

    CartResponseList({
        this.userId,
        this.imageurl,
        this.productId,
        this.productName,
        this.quantity,
        this.totalPrice,
        this.imageUrls,
        this.today,
        this.price,
    });

    factory CartResponseList.fromJson(Map<String, dynamic> json) => CartResponseList(
        userId: json["userId"],
        imageurl: json["imageurl"],
        productId: json["productId"],
        productName: json["productName"],
        quantity: json["quantity"],
        totalPrice: json["totalPrice"],
        imageUrls: json["imageUrls"],
        today: json["today"] == null ? null : DateTime.parse(json["today"]),
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "imageurl": imageurl,
        "productId": productId,
        "productName": productName,
        "quantity": quantity,
        "totalPrice": totalPrice,
        "imageUrls": imageUrls,
        "today": "${today!.year.toString().padLeft(4, '0')}-${today!.month.toString().padLeft(2, '0')}-${today!.day.toString().padLeft(2, '0')}",
        "price": price,
    };
}

class OrderSummary {
    double? totalPrice;
    double? price;
    double? deliveryCharge;
    int? totalQuantity;
    DateTime? deliveryDate;

    OrderSummary({
        this.totalPrice,
        this.price,
        this.deliveryCharge,
        this.totalQuantity,
        this.deliveryDate,
    });

    factory OrderSummary.fromJson(Map<String, dynamic> json) => OrderSummary(
        totalPrice: json["totalPrice"],
        price: json["price"],
        deliveryCharge: json["deliveryCharge"],
        totalQuantity: json["totalQuantity"],
        deliveryDate: json["deliveryDate"] == null ? null : DateTime.parse(json["deliveryDate"]),
    );

    Map<String, dynamic> toJson() => {
        "totalPrice": totalPrice,
        "price": price,
        "deliveryCharge": deliveryCharge,
        "totalQuantity": totalQuantity,
        "deliveryDate": "${deliveryDate!.year.toString().padLeft(4, '0')}-${deliveryDate!.month.toString().padLeft(2, '0')}-${deliveryDate!.day.toString().padLeft(2, '0')}",
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

// To parse this JSON data, do
//
//     final placeOrderModel = placeOrderModelFromJson(jsonString);

import 'dart:convert';

PlaceOrderModel placeOrderModelFromJson(String str) =>
    PlaceOrderModel.fromJson(json.decode(str));

String placeOrderModelToJson(PlaceOrderModel data) =>
    json.encode(data.toJson());

class PlaceOrderModel {
  Status? status;
  Data? data;

  PlaceOrderModel({
    this.status,
    this.data,
  });

  factory PlaceOrderModel.fromJson(Map<String, dynamic> json) =>
      PlaceOrderModel(
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
  bool? active;
  int? createdAt;
  int? updatedAt;
  dynamic razorPayOrderId;
  String? orderStatus;
  dynamic paymentStatus;
  int? userId;
  dynamic quantity;
  dynamic basePrice;
  dynamic deliveryPrice;
  int? totalPrice;
  List<Orderitem>? orderitem;

  Data({
    this.id,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.razorPayOrderId,
    this.orderStatus,
    this.paymentStatus,
    this.userId,
    this.quantity,
    this.basePrice,
    this.deliveryPrice,
    this.totalPrice,
    this.orderitem,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        active: json["active"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        razorPayOrderId: json["razorPayOrderId"],
        orderStatus: json["orderStatus"],
        paymentStatus: json["paymentStatus"],
        userId: json["userId"],
        quantity: json["quantity"],
        basePrice: json["basePrice"],
        deliveryPrice: json["deliveryPrice"],
        totalPrice: json["totalPrice"],
        orderitem: json["orderitem"] == null
            ? []
            : List<Orderitem>.from(
                json["orderitem"]!.map((x) => Orderitem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "active": active,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "razorPayOrderId": razorPayOrderId,
        "orderStatus": orderStatus,
        "paymentStatus": paymentStatus,
        "userId": userId,
        "quantity": quantity,
        "basePrice": basePrice,
        "deliveryPrice": deliveryPrice,
        "totalPrice": totalPrice,
        "orderitem": orderitem == null
            ? []
            : List<dynamic>.from(orderitem!.map((x) => x.toJson())),
      };
}

class Orderitem {
  int? id;
  bool? active;
  int? createdAt;
  int? updatedAt;
  int? productId;
  String? productName;
  int? quantity;
  int? productPrice;
  int? totalPrice;
  int? deliveryDate;
  String? deliveryStatus;
  int? userId;

  Orderitem({
    this.id,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.productId,
    this.productName,
    this.quantity,
    this.productPrice,
    this.totalPrice,
    this.deliveryDate,
    this.deliveryStatus,
    this.userId,
  });

  factory Orderitem.fromJson(Map<String, dynamic> json) => Orderitem(
        id: json["id"],
        active: json["active"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        productId: json["productId"],
        productName: json["productName"],
        quantity: json["quantity"],
        productPrice: json["productPrice"],
        totalPrice: json["totalPrice"],
        deliveryDate: json["deliveryDate"],
        deliveryStatus: json["deliveryStatus"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "active": active,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "productId": productId,
        "productName": productName,
        "quantity": quantity,
        "productPrice": productPrice,
        "totalPrice": totalPrice,
        "deliveryDate": deliveryDate,
        "deliveryStatus": deliveryStatus,
        "userId": userId,
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

// // To parse this JSON data, do
// //
// //     final myOrderListModel = myOrderListModelFromJson(jsonString);

// import 'dart:convert';

// MyOrderListModel myOrderListModelFromJson(String str) =>
//     MyOrderListModel.fromJson(json.decode(str));

// String myOrderListModelToJson(MyOrderListModel data) =>
//     json.encode(data.toJson());

// class MyOrderListModel {
//   Status? status;
//   Data? data;

//   MyOrderListModel({
//     this.status,
//     this.data,
//   });

//   factory MyOrderListModel.fromJson(Map<String, dynamic> json) =>
//       MyOrderListModel(
//         status: json["status"] == null ? null : Status.fromJson(json["status"]),
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status?.toJson(),
//         "data": data?.toJson(),
//       };
// }

// class Data {
//   List<ProductDeliveryInfoList>? productDeliveryInfoList;
//   OrderDeliverySummary? orderDeliverySummary;

//   Data({
//     this.productDeliveryInfoList,
//     this.orderDeliverySummary,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         productDeliveryInfoList: json["productDeliveryInfoList"] == null
//             ? []
//             : List<ProductDeliveryInfoList>.from(
//                 json["productDeliveryInfoList"]!
//                     .map((x) => ProductDeliveryInfoList.fromJson(x))),
//         orderDeliverySummary: json["orderDeliverySummary"] == null
//             ? null
//             : OrderDeliverySummary.fromJson(json["orderDeliverySummary"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "productDeliveryInfoList": productDeliveryInfoList == null
//             ? []
//             : List<dynamic>.from(
//                 productDeliveryInfoList!.map((x) => x.toJson())),
//         "orderDeliverySummary": orderDeliverySummary?.toJson(),
//       };
// }

// class OrderDeliverySummary {
//   double? totalSubscriptionPrice;
//   double? totalBuyOncePrice;
//   dynamic deliveryStatus;
//   dynamic saving;
//   double? totalAmount;

//   OrderDeliverySummary({
//     this.totalSubscriptionPrice,
//     this.totalBuyOncePrice,
//     this.deliveryStatus,
//     this.saving,
//     this.totalAmount,
//   });

//   factory OrderDeliverySummary.fromJson(Map<String, dynamic> json) =>
//       OrderDeliverySummary(
//         totalSubscriptionPrice: json["totalSubscriptionPrice"],
//         totalBuyOncePrice: json["totalBuyOncePrice"],
//         deliveryStatus: json["deliveryStatus"],
//         saving: json["saving"],
//         totalAmount: json["totalAmount"],
//       );

//   Map<String, dynamic> toJson() => {
//         "totalSubscriptionPrice": totalSubscriptionPrice,
//         "totalBuyOncePrice": totalBuyOncePrice,
//         "deliveryStatus": deliveryStatus,
//         "saving": saving,
//         "totalAmount": totalAmount,
//       };
// }

// class ProductDeliveryInfoList {
//   String? productName;
//   String? productImageUrl;
//   double? offerPrice;
//   double? price;
//   int? id;
//   String? deliveryStatus;
//   int? deliveryDate;
//   int? quantity;
//   String? orderType;
//   double? savingAmount;

//   ProductDeliveryInfoList({
//     this.productName,
//     this.productImageUrl,
//     this.offerPrice,
//     this.price,
//     this.id,
//     this.deliveryStatus,
//     this.deliveryDate,
//     this.quantity,
//     this.orderType,
//     this.savingAmount,
//   });

//   factory ProductDeliveryInfoList.fromJson(Map<String, dynamic> json) =>
//       ProductDeliveryInfoList(
//         productName: json["productName"],
//         productImageUrl: json["productImageUrl"],
//         offerPrice: json["offerPrice"],
//         price: json["price"],
//         id: json["id"],
//         deliveryStatus: json["deliveryStatus"],
//         deliveryDate: json["deliveryDate"],
//         quantity: json["quantity"],
//         orderType: json["orderType"],
//         savingAmount: json["savingAmount"],
//       );

//   Map<String, dynamic> toJson() => {
//         "productName": productName,
//         "productImageUrl": productImageUrl,
//         "offerPrice": offerPrice,
//         "price": price,
//         "id": id,
//         "deliveryStatus": deliveryStatus,
//         "deliveryDate": deliveryDate,
//         "quantity": quantity,
//         "orderType": orderType,
//         "savingAmount": savingAmount,
//       };
// }

// class Status {
//   String? httpCode;
//   bool? success;
//   String? message;

//   Status({
//     this.httpCode,
//     this.success,
//     this.message,
//   });

//   factory Status.fromJson(Map<String, dynamic> json) => Status(
//         httpCode: json["httpCode"],
//         success: json["success"],
//         message: json["message"],
//       );

//   Map<String, dynamic> toJson() => {
//         "httpCode": httpCode,
//         "success": success,
//         "message": message,
//       };
// }

// To parse this JSON data, do
//
//     final myOrderListModel = myOrderListModelFromJson(jsonString);

import 'dart:convert';

MyOrderListModel myOrderListModelFromJson(String str) =>
    MyOrderListModel.fromJson(json.decode(str));

String myOrderListModelToJson(MyOrderListModel data) =>
    json.encode(data.toJson());

class MyOrderListModel {
  Status? status;
  Data? data;

  MyOrderListModel({
    this.status,
    this.data,
  });

  factory MyOrderListModel.fromJson(Map<String, dynamic> json) =>
      MyOrderListModel(
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status?.toJson(),
        "data": data?.toJson(),
      };
}

class Data {
  List<ProductDeliveryInfoList>? productDeliveryInfoList;
  OrderDeliverySummary? orderDeliverySummary;

  Data({
    this.productDeliveryInfoList,
    this.orderDeliverySummary,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        productDeliveryInfoList: json["productDeliveryInfoList"] == null
            ? []
            : List<ProductDeliveryInfoList>.from(
                json["productDeliveryInfoList"]!
                    .map((x) => ProductDeliveryInfoList.fromJson(x))),
        orderDeliverySummary: json["orderDeliverySummary"] == null
            ? null
            : OrderDeliverySummary.fromJson(json["orderDeliverySummary"]),
      );

  Map<String, dynamic> toJson() => {
        "productDeliveryInfoList": productDeliveryInfoList == null
            ? []
            : List<dynamic>.from(
                productDeliveryInfoList!.map((x) => x.toJson())),
        "orderDeliverySummary": orderDeliverySummary?.toJson(),
      };
}

class OrderDeliverySummary {
  double? totalSubscriptionPrice;
  double? totalBuyOncePrice;
  dynamic deliveryStatus;
  dynamic saving;
  double? totalAmount;

  OrderDeliverySummary({
    this.totalSubscriptionPrice,
    this.totalBuyOncePrice,
    this.deliveryStatus,
    this.saving,
    this.totalAmount,
  });

  factory OrderDeliverySummary.fromJson(Map<String, dynamic> json) =>
      OrderDeliverySummary(
        totalSubscriptionPrice: json["totalSubscriptionPrice"],
        totalBuyOncePrice: json["totalBuyOncePrice"],
        deliveryStatus: json["deliveryStatus"],
        saving: json["saving"],
        totalAmount: json["totalAmount"],
      );

  Map<String, dynamic> toJson() => {
        "totalSubscriptionPrice": totalSubscriptionPrice,
        "totalBuyOncePrice": totalBuyOncePrice,
        "deliveryStatus": deliveryStatus,
        "saving": saving,
        "totalAmount": totalAmount,
      };
}

class ProductDeliveryInfoList {
  String? productName;
  String? productImageUrl;
  double? offerPrice;
  double? price;
  int? id;
  String? deliveryStatus;
  int? deliveryDate;
  int? quantity;
  String? orderType;
  double? savingAmount;

  ProductDeliveryInfoList({
    this.productName,
    this.productImageUrl,
    this.offerPrice,
    this.price,
    this.id,
    this.deliveryStatus,
    this.deliveryDate,
    this.quantity,
    this.orderType,
    this.savingAmount,
  });

  factory ProductDeliveryInfoList.fromJson(Map<String, dynamic> json) =>
      ProductDeliveryInfoList(
        productName: json["productName"],
        productImageUrl: json["productImageUrl"],
        offerPrice: json["offerPrice"],
        price: json["price"],
        id: json["id"],
        deliveryStatus: json["deliveryStatus"],
        deliveryDate: json["deliveryDate"],
        quantity: json["quantity"],
        orderType: json["orderType"],
        savingAmount: json["savingAmount"],
      );

  Map<String, dynamic> toJson() => {
        "productName": productName,
        "productImageUrl": productImageUrl,
        "offerPrice": offerPrice,
        "price": price,
        "id": id,
        "deliveryStatus": deliveryStatus,
        "deliveryDate": deliveryDate,
        "quantity": quantity,
        "orderType": orderType,
        "savingAmount": savingAmount,
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

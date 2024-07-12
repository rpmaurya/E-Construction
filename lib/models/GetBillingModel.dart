// To parse this JSON data, do
//
//     final getBillingListModel = getBillingListModelFromJson(jsonString);

import 'dart:convert';

GetBillingListModel getBillingListModelFromJson(String str) =>
    GetBillingListModel.fromJson(json.decode(str));

String getBillingListModelToJson(GetBillingListModel data) =>
    json.encode(data.toJson());

class GetBillingListModel {
  Status? status;
  List<Datum>? data;

  GetBillingListModel({
    this.status,
    this.data,
  });

  factory GetBillingListModel.fromJson(Map<String, dynamic> json) =>
      GetBillingListModel(
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
  int? userId;
  String? transactionId;
  String? transactionType;
  double? amount;
  DateTime? createdAt;
  double? balanceAmount;
  int? scheduleSubscriptionId;
  int? orderItemId;

  Datum({
    this.id,
    this.userId,
    this.transactionId,
    this.transactionType,
    this.amount,
    this.createdAt,
    this.balanceAmount,
    this.scheduleSubscriptionId,
    this.orderItemId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["userId"],
        transactionId: json["transactionId"],
        transactionType: json["transactionType"],
        amount: json["amount"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        balanceAmount: json["balanceAmount"],
        scheduleSubscriptionId: json["scheduleSubscriptionId"],
        orderItemId: json["orderItemId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "transactionId": transactionId,
        "transactionType": transactionType,
        "amount": amount,
        "createdAt":
            "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
        "balanceAmount": balanceAmount,
        "scheduleSubscriptionId": scheduleSubscriptionId,
        "orderItemId": orderItemId,
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

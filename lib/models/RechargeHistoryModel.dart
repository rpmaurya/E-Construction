// To parse this JSON data, do
//
//     final rechargeHistoryModel = rechargeHistoryModelFromJson(jsonString);

import 'dart:convert';

RechargeHistoryModel rechargeHistoryModelFromJson(String str) =>
    RechargeHistoryModel.fromJson(json.decode(str));

String rechargeHistoryModelToJson(RechargeHistoryModel data) =>
    json.encode(data.toJson());

class RechargeHistoryModel {
  Status? status;
  List<Datum>? data;

  RechargeHistoryModel({
    this.status,
    this.data,
  });

  factory RechargeHistoryModel.fromJson(Map<String, dynamic> json) =>
      RechargeHistoryModel(
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
  int? userId;
  String? status;
  double? amount;
  dynamic razorpayId;
  int? createdAt;
  int? updatedAt;

  Datum({
    this.userId,
    this.status,
    this.amount,
    this.razorpayId,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        userId: json["userId"],
        status: json["status"],
        amount: json["amount"],
        razorpayId: json["razorpayId"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "status": messageValues.reverse[status],
        "amount": amount,
        "razorpayId": razorpayId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}

enum Message { PENDING, SUCCESS }

final messageValues =
    EnumValues({"Pending": Message.PENDING, "Success": Message.SUCCESS});

class Status {
  String? httpCode;
  bool? success;
  Message? message;

  Status({
    this.httpCode,
    this.success,
    this.message,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        httpCode: json["httpCode"],
        success: json["success"],
        message: messageValues.map[json["message"]]!,
      );

  Map<String, dynamic> toJson() => {
        "httpCode": httpCode,
        "success": success,
        "message": messageValues.reverse[message],
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

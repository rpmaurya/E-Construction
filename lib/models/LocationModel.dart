// To parse this JSON data, do
//
//     final locationModel = locationModelFromJson(jsonString);

import 'dart:convert';

LocationModel locationModelFromJson(String str) =>
    LocationModel.fromJson(json.decode(str));

String locationModelToJson(LocationModel data) => json.encode(data.toJson());

class LocationModel {
  Status? status;
  List<Datum>? data;

  LocationModel({
    this.status,
    this.data,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
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
  int? locationId;
  String? location;
  String? latitude;
  String? longitude;
  String? timezone;

  Datum({
    this.locationId,
    this.location,
    this.latitude,
    this.longitude,
    this.timezone,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        locationId: json["locationId"],
        location: json["location"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        timezone: json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "locationId": locationId,
        "location": location,
        "latitude": latitude,
        "longitude": longitude,
        "timezone": timezone,
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

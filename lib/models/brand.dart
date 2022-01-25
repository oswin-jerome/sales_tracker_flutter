// To parse this JSON data, do
//
//     final brand = brandFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

List<Brand> brandFromJson(String str) =>
    List<Brand>.from(json.decode(str).map((x) => Brand.fromJson(x)));

String brandToJson(List<Brand> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Brand {
  Brand({
    this.id,
    required this.name,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String name;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

// To parse this JSON data, do
//
//     final fieldModel = fieldModelFromJson(jsonString);

import 'dart:convert';

List<FieldModel> fieldModelFromJson(String str) => List<FieldModel>.from(json.decode(str).map((x) => FieldModel.fromJson(x)));

String fieldModelToJson(List<FieldModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FieldModel {
    int id;
    String name;
    int length;
    int width;
    String description;
    DateTime createdAt;
    DateTime updatedAt;

    FieldModel({
        required this.id,
        required this.name,
        required this.length,
        required this.width,
        required this.description,
        required this.createdAt,
        required this.updatedAt,
    });

    factory FieldModel.fromJson(Map<String, dynamic> json) => FieldModel(
        id: json["id"],
        name: json["name"],
        length: json["length"],
        width: json["width"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "length": length,
        "width": width,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

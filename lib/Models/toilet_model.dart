// To parse this JSON data, do
//
//     final toiletModel = toiletModelFromJson(jsonString);

import 'dart:convert';

List<ToiletModel> toiletModelFromJson(String str) => List<ToiletModel>.from(json.decode(str).map((x) => ToiletModel.fromJson(x)));

String toiletModelToJson(List<ToiletModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ToiletModel {
    int id;
    String name;
    int length;
    int width;
    String floorLocation;
    String description;
    DateTime createdAt;
    DateTime updatedAt;

    ToiletModel({
        required this.id,
        required this.name,
        required this.length,
        required this.width,
        required this.floorLocation,
        required this.description,
        required this.createdAt,
        required this.updatedAt,
    });

    factory ToiletModel.fromJson(Map<String, dynamic> json) => ToiletModel(
        id: json["id"],
        name: json["name"],
        length: json["length"],
        width: json["width"],
        floorLocation: json["floor_location"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "length": length,
        "width": width,
        "floor_location": floorLocation,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

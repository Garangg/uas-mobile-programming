// To parse this JSON data, do
//
//     final laboratoriumModel = laboratoriumModelFromJson(jsonString);

import 'dart:convert';

List<LaboratoriumModel> laboratoriumModelFromJson(String str) => List<LaboratoriumModel>.from(json.decode(str).map((x) => LaboratoriumModel.fromJson(x)));

String laboratoriumModelToJson(List<LaboratoriumModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LaboratoriumModel {
    int id;
    String name;
    int length;
    int width;
    String description;
    String capacity;
    String floorLocation;
    DateTime createdAt;
    DateTime updatedAt;

    LaboratoriumModel({
        required this.id,
        required this.name,
        required this.length,
        required this.width,
        required this.description,
        required this.capacity,
        required this.floorLocation,
        required this.createdAt,
        required this.updatedAt,
    });

    factory LaboratoriumModel.fromJson(Map<String, dynamic> json) => LaboratoriumModel(
        id: json["id"],
        name: json["name"],
        length: json["length"],
        width: json["width"],
        description: json["description"],
        capacity: json["capacity"],
        floorLocation: json["floor_location"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "length": length,
        "width": width,
        "description": description,
        "capacity": capacity,
        "floor_location": floorLocation,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

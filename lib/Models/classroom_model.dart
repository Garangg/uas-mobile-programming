// To parse this JSON data, do
//
//     final classroomModel = classroomModelFromJson(jsonString);

import 'dart:convert';

List<ClassroomModel> classroomModelFromJson(String str) => List<ClassroomModel>.from(json.decode(str).map((x) => ClassroomModel.fromJson(x)));

String classroomModelToJson(List<ClassroomModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClassroomModel {
    int id;
    String name;
    int length;
    int width;
    String description;
    String capacity;
    String floorLocation;
    String userRoom;
    DateTime createdAt;
    DateTime updatedAt;

    ClassroomModel({
        required this.id,
        required this.name,
        required this.length,
        required this.width,
        required this.description,
        required this.capacity,
        required this.floorLocation,
        required this.userRoom,
        required this.createdAt,
        required this.updatedAt,
    });

    factory ClassroomModel.fromJson(Map<String, dynamic> json) => ClassroomModel(
        id: json["id"],
        name: json["name"],
        length: json["length"],
        width: json["width"],
        description: json["description"],
        capacity: json["capacity"],
        floorLocation: json["floor_location"],
        userRoom: json["user_room"],
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
        "user_room": userRoom,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

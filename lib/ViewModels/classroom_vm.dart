import 'package:flutter_laravel/Models/classroom_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class classroomVM {
  static String baseUrl = 'http://10.0.2.2:8000/api/classrooms';

  static Future<List<ClassroomModel>> getClassrooms() async {
    var url = Uri.parse(baseUrl);
    var response = await http.get(url);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data
          .map((classroom) => ClassroomModel.fromJson(classroom))
          .toList();
    } else {
      throw Exception('Failed to load classrooms');
    }
  }

  static Future<ClassroomModel> getClassroom(int id) async {
    var url = Uri.parse('$baseUrl/$id');
    var response = await http.get(url);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return ClassroomModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Response body is empty');
      }
    } else {
      throw Exception('Failed to load classroom');
    }
  }

  static Future<void> createClassroom(ClassroomModel classroom) async {
    var url = Uri.parse(baseUrl);
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(classroom.toJson()),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to create classroom');
    }
  }

  static Future<void> updateClassroom(ClassroomModel classroom) async {
    var url = Uri.parse('$baseUrl/${classroom.id}');
    var response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(classroom.toJson()),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200) {
      // Throw a more detailed exception if possible
      throw Exception('Failed to update classroom: ${response.reasonPhrase}');
    }
  }

  static Future<void> deleteClassroom(int id) async {
    var url = Uri.parse('$baseUrl/$id');
    var response = await http.delete(url);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 204) {
      throw Exception('Failed to delete classroom');
    }
  }
}

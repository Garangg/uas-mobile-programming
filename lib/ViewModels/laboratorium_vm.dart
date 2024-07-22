import 'package:flutter_laravel/Models/laboratorium_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LaboratoriumVM {
  static String baseUrl = 'http://pendataan-prasarana.c1.is/api/laboratoriums';

  static Future<List<LaboratoriumModel>> getLaboratoriums() async {
    var url = Uri.parse(baseUrl);
    var response = await http.get(url);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data
          .map((laboratorium) => LaboratoriumModel.fromJson(laboratorium))
          .toList();
    } else {
      throw Exception('Failed to load laboratoriums');
    }
  }

  static Future<LaboratoriumModel> getLaboratorium(int id) async {
    var url = Uri.parse('$baseUrl/$id');
    var response = await http.get(url);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return LaboratoriumModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Response body is empty');
      }
    } else {
      throw Exception('Failed to load laboratorium');
    }
  }

  static Future<void> createLaboratorium(LaboratoriumModel laboratorium) async {
    var url = Uri.parse(baseUrl);
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(laboratorium.toJson()),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to create laboratorium');
    }
  }

  static Future<void> updateLaboratorium(LaboratoriumModel laboratorium) async {
    var url = Uri.parse('$baseUrl/${laboratorium.id}');
    var response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(laboratorium.toJson()),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to update laboratorium');
    }
  }

  static Future<void> deleteLaboratorium(int id) async {
    var url = Uri.parse('$baseUrl/$id');
    var response = await http.delete(url);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to delete laboratorium');
    }
  }
}

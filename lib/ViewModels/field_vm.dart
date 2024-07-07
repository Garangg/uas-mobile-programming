import 'package:flutter_laravel/Models/field_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FieldVM{
    static String baseUrl = 'http://10.0.2.2:8000/api/fields';

    static Future<List<FieldModel>> getFields() async {
        var url = Uri.parse(baseUrl);
        var response = await http.get(url);

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == 200) {
            List<dynamic> data = jsonDecode(response.body);
            return data
                .map((field) => FieldModel.fromJson(field))
                .toList();
        } else {
            throw Exception('Failed to load fields');
        }
    }

    static Future<FieldModel> getField(int id) async {
        var url = Uri.parse('$baseUrl/$id');
        var response = await http.get(url);

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == 200) {
            if (response.body.isNotEmpty) {
                return FieldModel.fromJson(jsonDecode(response.body));
            } else {
                throw Exception('Response body is empty');
            }
        } else {
            throw Exception('Failed to load field');
        }
    }

    static Future<void> createField(FieldModel field) async {
        var url = Uri.parse(baseUrl);
        var response = await http.post(
            url,
            headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(field.toJson()),
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode != 200) {
            throw Exception('Failed to create field');
        }
    }

    static Future<void> updateField(FieldModel field) async {
        var url = Uri.parse('$baseUrl/${field.id}');
        var response = await http.put(
            url,
            headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(field.toJson()),
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode != 200) {
            throw Exception('Failed to update field');
        }
    }

    static Future<void> deleteField(int id) async {
        var url = Uri.parse('$baseUrl/$id');
        var response = await http.delete(url);

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode != 200) {
            throw Exception('Failed to delete field');
        }
    }

}
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_laravel/Models/toilet_model.dart';

class toiletVM{
    static String baseUrl = 'http://pendataan-prasarana.c1.is/api/toilets';

    static Future<List<ToiletModel>> getToilets() async {
        var url = Uri.parse(baseUrl);
        var response = await http.get(url);

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == 200) {
            List<dynamic> data = jsonDecode(response.body);
            return data
                .map((toilet) => ToiletModel.fromJson(toilet))
                .toList();
        } else {
            throw Exception('Failed to load toilets');
        }
    }

    static Future<ToiletModel> getToilet(int id) async {
        var url = Uri.parse('$baseUrl/$id');
        var response = await http.get(url);

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == 200) {
            if (response.body.isNotEmpty) {
                return ToiletModel.fromJson(jsonDecode(response.body));
            } else {
                throw Exception('Response body is empty');
            }
        } else {
            throw Exception('Failed to load toilet');
        }
    }

    static Future<void> createToilet(ToiletModel toilet) async {
        var url = Uri.parse(baseUrl);
        var response = await http.post(
            url,
            headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(toilet.toJson()),
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode != 200) {
            throw Exception('Failed to create toilet');
        }
    }

    static Future<void> updateToilet(ToiletModel toilet) async {
        var url = Uri.parse('$baseUrl/${toilet.id}');
        var response = await http.put(
            url,
            headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(toilet.toJson()),
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode != 200) {
            throw Exception('Failed to update toilet');
        }
    }

    static Future<void> deleteToilet(int id) async {
        var url = Uri.parse('$baseUrl/$id');
        var response = await http.delete(url);

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode != 200) {
            throw Exception('Failed to delete toilet');
        }
    }
}
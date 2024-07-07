import 'package:flutter_laravel/Models/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserVM{
  final String baseurl = "http://10.0.2.2:8000/api/user";

  Future<User> fetchUser() async {
    final response = await http.get(Uri.parse('$baseurl'));
    if (response.statusCode == 200) {
      print(response.body);
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch user');
    }
  }
}
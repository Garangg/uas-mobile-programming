import 'dart:convert';
import 'package:flutter_laravel/Models/login_model.dart';
import 'package:flutter_laravel/Models/register_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthVM {
  final String baseUrl =
      "http://10.0.2.2:8000/api"; // Replace with your Laravel API URL

  Future<LoginResponse> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    print(response.body);

    if (response.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(jsonDecode(response.body));

      if (loginResponse.success && loginResponse.token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', loginResponse.token!);
        await prefs.setInt('userId', loginResponse.user!.id);
        await prefs.setString('userName', loginResponse.user!.name);
        await prefs.setString('userEmail', loginResponse.user!.email);
      }

      return loginResponse;
    } else {
      final errorResponse = jsonDecode(response.body);
      return LoginResponse(success: false, message: errorResponse['message']);
    }
  }

  Future<RegisterResponse> register(String name, String email, String password,
      String passwordConfirmation) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      }),
    );

    print(response.body);
    if (response.statusCode == 200) {
      final registerResponse =
          RegisterResponse.fromJson(jsonDecode(response.body));

      if (registerResponse.success && registerResponse.token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', registerResponse.token!);
        await prefs.setInt('userId', registerResponse.user!.id);
        await prefs.setString('userName', registerResponse.user!.name);
        await prefs.setString('userEmail', registerResponse.user!.email);
      }

      return registerResponse;
    } else {
      final errorResponse = jsonDecode(response.body);
      return RegisterResponse(
          success: false, message: errorResponse['message']);
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('userId');
    await prefs.remove('userName');
    await prefs.remove('userEmail');
  }
}

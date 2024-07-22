import 'package:flutter/material.dart';
import 'package:flutter_laravel/Pages/Auth/login_page.dart';
import 'package:flutter_laravel/Pages/home_page.dart';
import 'package:flutter_laravel/ViewModels/AuthVM.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 238, 238, 238)),
        useMaterial3: true,
      ),
      home: const CheckLogin(),
    );
  }
}

class CheckLogin extends StatelessWidget {
  const CheckLogin({super.key});

  Future<bool> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final rememberMe = prefs.getBool('rememberMe') ?? false;
    if (rememberMe) {
      final email = prefs.getString('email') ?? '';
      final password = prefs.getString('password') ?? '';
      final response = await AuthVM().login(email, password);
      return response.success;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data == true) {
          return const HomePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}

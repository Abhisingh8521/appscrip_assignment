import 'dart:async';

import 'package:appscrip_assignment/views/screens/auth/login_screen.dart';
import 'package:appscrip_assignment/views/screens/auth/register_screen.dart';
import 'package:appscrip_assignment/views/screens/view_todo_Screen.dart';
import 'package:flutter/material.dart';

import '../../services/auth_api_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: "app_logo",
          child: Image(
            image: AssetImage("assets/images/app_logo.png"),
            height: 280,
            width: 280,
          ),
        ),
      ),
    );
  }

  void checkUser() {
    Timer(const Duration(seconds: 3), () async {
      var isLogin = await AuthAPi().isLogin();
      var isRegister = await AuthAPi().isSignUp();

      if (isLogin.status) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ViewTodoScreen(),
            ));
      } else {
        if (isRegister.status) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => RegisterScreen(),
              ));
        }
      }
    });
  }
}
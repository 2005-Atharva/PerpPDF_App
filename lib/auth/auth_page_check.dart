import 'package:flutter/material.dart';
import 'package:user_auth_crudd10/auth/login_page.dart';
import 'package:user_auth_crudd10/auth/register_page.dart';

class AuthPageCheck extends StatefulWidget {
  const AuthPageCheck({super.key});

  @override
  State<AuthPageCheck> createState() => _AuthPageCheckState();
}

class _AuthPageCheckState extends State<AuthPageCheck> {
  bool showLoginPage = true;

  void toggelScreen() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(showLoginPage: toggelScreen);
    } else {
      return RegisterPage(
        showSignUpPage: toggelScreen,
      );
    }
  }
}

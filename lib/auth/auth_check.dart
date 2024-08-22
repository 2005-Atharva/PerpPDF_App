import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:user_auth_crudd10/auth/auth_page_check.dart';
import 'package:user_auth_crudd10/pages/bottom_nav.dart';

class AuthCheckMain extends StatelessWidget {
  const AuthCheckMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const BottomNavBar(); //here i will impliment the user login functionality
          } else {
            return const AuthPageCheck();
          }
        },
      ),
    );
  }
}

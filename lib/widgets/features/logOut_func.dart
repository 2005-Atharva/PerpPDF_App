import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class logOutFunc extends StatelessWidget {
  const logOutFunc({
    super.key,
    required this.auth,
  });

  final FirebaseAuth auth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
          auth.signOut();
        },
        child: Container(
          alignment: Alignment.center,
          height: 50,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.red,
              width: 0.7,
            ),
          ),
          child: const Text(
            "Logout",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}

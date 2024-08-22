import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPassPage extends StatefulWidget {
  const ForgetPassPage({super.key});

  @override
  State<ForgetPassPage> createState() => _ForgetPassPageState();
}

class _ForgetPassPageState extends State<ForgetPassPage> {
  final _emailControllerResetLink = TextEditingController();

  Future sentResetLink() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailControllerResetLink.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Password Reset Link Sent Succesfully!"),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.green[200],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(12),
            ),
          ),
        ),
      );
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message.toString(),
          ),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red[200],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(12),
            ),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailControllerResetLink.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(90, 20, 0, 0),
                  child: Image.asset('assets/images/grad2.png'),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 100, 0),
                  child: Image.asset('assets/images/grad1.png'),
                ),
                Positioned(
                  top: 70,
                  left: 150,
                  child: Image.asset('assets/images/intro_logo.png'),
                ),

                //container
                Positioned(
                  top: 130,
                  left: 10,
                  right: 10,
                  bottom: 0,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: Container(
                      height: 900,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                            child: Image.asset('assets/images/forget_pass.png'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Provide you account email \nfor which we wont to sent reset password Link!",
                            style: GoogleFonts.lato(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          //email textfield
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              controller: _emailControllerResetLink,
                              cursorColor: Colors.purpleAccent,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 0.8,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Colors.purpleAccent,
                                    width: 0.8,
                                  ),
                                ),
                                labelText: " Email ",
                                labelStyle: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 40,
                          ),

                          //login Button
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: GestureDetector(
                              onTap: sentResetLink,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset(
                                    'assets/icons/ic_button.png',
                                  ),
                                  Text(
                                    "Reset Password",
                                    style: GoogleFonts.inter(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

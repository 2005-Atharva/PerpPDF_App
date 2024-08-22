// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_auth_crudd10/services/functions/user_data_store.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showSignUpPage;
  const RegisterPage({super.key, required this.showSignUpPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isObscure = true;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _confromPasswordController = TextEditingController();
  final _yearController = TextEditingController();

  //check passoword same or not
  bool checkPassowrd() {
    if (_passwordController.text.trim() ==
        _confromPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  //method to create account
  Future signUp() async {
    try {
      if (checkPassowrd()) {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        User? user = userCredential.user;
        if (user != null) {
          await storeUserData(
            _nameController.text.trim(),
            _yearController.text.trim(),
            _emailController.text.trim(),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Password is Incorrect"),
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
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message.toString()),
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
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _confromPasswordController.dispose();
    _yearController.dispose();
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
                  top: 60,
                  left: 150,
                  child: Text(
                    'PerpPDF',
                    style: GoogleFonts.lato(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.deepPurple[500],
                    ),
                  ),
                ),

                //container
                Positioned(
                  top: 120,
                  left: 10,
                  right: 10,
                  bottom: 0,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: Container(
                      height: 1200,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Image.asset('assets/images/signup.png'),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Create an account to continue!",
                              style: GoogleFonts.lato(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                cursorColor: Colors.white,
                                controller: _nameController,
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
                                  labelText: " Full Name ",
                                  labelStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                cursorColor: Colors.white,
                                controller: _yearController,
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
                                  labelText: " Year ",
                                  labelStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            //email textfield
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                cursorColor: Colors.white,
                                controller: _emailController,
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
                              height: 20,
                            ),

                            //password textfield
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                cursorColor: Colors.white,
                                controller: _passwordController,
                                obscureText: isObscure,
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
                                  labelText: " Password ",
                                  labelStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isObscure = !isObscure;
                                      });
                                    },
                                    icon: Icon(
                                      isObscure
                                          ? Icons.lock
                                          : Icons
                                              .no_encryption_gmailerrorred_rounded,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            //password textfield
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                cursorColor: Colors.white,
                                controller: _confromPasswordController,
                                obscureText: isObscure,
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
                                  labelText: " Confirm Password ",
                                  labelStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isObscure = !isObscure;
                                      });
                                    },
                                    icon: Icon(
                                      isObscure
                                          ? Icons.lock
                                          : Icons
                                              .no_encryption_gmailerrorred_rounded,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            //login Button
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //year
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 50),
            //   child: TextField(
            //     cursorColor: Colors.white,
            //     controller: _confromPasswordController,
            //     obscureText: isObscure,
            //     decoration: InputDecoration(
            //       enabledBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(12),
            //         borderSide: const BorderSide(
            //           color: Colors.grey,
            //           width: 0.8,
            //         ),
            //       ),
            //       focusedBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(12),
            //         borderSide: const BorderSide(
            //           color: Colors.purpleAccent,
            //           width: 0.8,
            //         ),
            //       ),
            //       labelText: " Confirm Password ",
            //       labelStyle:
            //           TextStyle(color: Theme.of(context).colorScheme.secondary),
            //       suffixIcon: IconButton(
            //         onPressed: () {
            //           setState(() {
            //             isObscure = !isObscure;
            //           });
            //         },
            //         icon: Icon(
            //           isObscure
            //               ? Icons.lock
            //               : Icons.no_encryption_gmailerrorred_rounded,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: GestureDetector(
                onTap: signUp,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/ic_button.png',
                    ),
                    Text(
                      "Sign Up",
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: widget.showSignUpPage,
                  child: Text(
                    "Login",
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

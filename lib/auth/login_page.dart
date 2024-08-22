import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_auth_crudd10/auth/forget_pass_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const LoginPage({super.key, required this.showLoginPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isRember = false;

  bool isObscure = true;

  //textControllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //login logic
  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
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

  //dispose
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                  // child: Image.asset('assets/images/intro_logo.png'),
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
                      // height: MediaQuery.of(context).size.height *
                      //     0.9, //chnage old was 700

                      width: 250,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                            child: Image.asset('assets/images/login.png'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              "Enter your email and password to log in",
                              style: GoogleFonts.lato(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          //email textfield
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
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
                            padding: const EdgeInsets.symmetric(horizontal: 15),
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

                          //remember--forget row
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    setState(() {
                                      isRember = !isRember;
                                    });
                                  },
                                  icon: Icon(
                                    isRember
                                        ? Icons.check_box_outline_blank
                                        : Icons.check_box,
                                  ),
                                ),
                                const Text(
                                  'Remember me',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const ForgetPassPage(),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          "Forget Password ?",
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: GestureDetector(
                onTap: signIn,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/ic_button.png',
                    ),
                    Text(
                      "Log In",
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
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Dont have an account?',
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: widget.showLoginPage,
                  child: Text(
                    "Sign Up",
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

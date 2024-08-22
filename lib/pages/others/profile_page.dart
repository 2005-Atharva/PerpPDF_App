import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:user_auth_crudd10/pages/userProfileEdit_page.dart';
import 'package:user_auth_crudd10/services/settings/theme_provider.dart';
import 'package:user_auth_crudd10/widgets/features/logOut_func.dart';
import 'package:user_auth_crudd10/widgets/global/about_us.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final auth = FirebaseAuth.instance;
  final authData = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    User? currentUser = auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Profile Page",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 22,
          ),
        ),
        // actions: [
        //   IconButton(
        //     padding: const EdgeInsets.only(right: 22),
        //     icon: Image.asset(
        //       'assets/icons/ic_logout.png',
        //       color: const Color.fromARGB(255, 243, 75, 63),
        //     ),
        //     onPressed: () {
        //       auth.signOut();
        //     },
        //   )
        // ],
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: currentUser == null
          ? const Center(
              child: Text('No User Logged in'),
            )
          : FutureBuilder<DocumentSnapshot>(
              future: authData.collection('users').doc(currentUser.uid).get(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (userSnapshot.hasError) {
                  return const Center(
                    child: Text("Error fetching user data"),
                  );
                } else if (!userSnapshot.hasData ||
                    !userSnapshot.data!.exists) {
                  return const Center(
                    child: Text('User data not found'),
                  );
                } else {
                  var userData =
                      userSnapshot.data!.data() as Map<String, dynamic>;
                  return SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              // alignment: Alignment.centerLeft,
                              height: 140,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //userName
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 15,
                                          ),
                                          child: Text(
                                            "${userData['userName']}",
                                            style: GoogleFonts.inter(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),

                                        //email
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 15,
                                          ),
                                          child: Text(
                                            '${userData['email']}',
                                            style: GoogleFonts.inter(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        //year
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 15,
                                          ),
                                          child: Text(
                                            "Year: ${userData['year']}",
                                            style: GoogleFonts.inter(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),

                                        //edit profile page
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 15,
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserProfileEdit(),
                                                  ));
                                            },
                                            child: Text(
                                              "Edit",
                                              style: GoogleFonts.inter(
                                                fontSize: 18,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Image.asset(
                                      'assets/images/profile_person.png',
                                      scale: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          //mode section
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              height: 60,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(Icons.nights_stay_rounded),
                                    const Text(
                                      'Dark Mode',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(width: 60),
                                    Switch(
                                      value: Provider.of<ThemeProvider>(context)
                                          .isDarkMode,
                                      onChanged: (value) {
                                        Provider.of<ThemeProvider>(context,
                                                listen: false)
                                            .toggleTheme();
                                      },
                                      activeColor: Colors.blue,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          //about section
                          const aboutUs(),
                          const SizedBox(
                            height: 25,
                          ),
                          logOutFunc(auth: auth)
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
    );
  }
}

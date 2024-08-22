import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> storeUserData(String userName, String year, String email) async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    await FirebaseFirestore.instance.collection('users').doc(userName).set({
      'userName': userName,
      'year': year,
      'email': email,
    });

    // Also store the data under the user UID
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'userName': userName,
      'year': year,
      'email': email,
    });
    print('User data stored');
  }
}

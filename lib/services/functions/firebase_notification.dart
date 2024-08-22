import 'package:firebase_messaging/firebase_messaging.dart';

class FirbaseApi {
  //instance of messiging
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    final fcmtocken = await _firebaseMessaging.getToken();

    print('TOKEN:' + fcmtocken.toString());
  }
}

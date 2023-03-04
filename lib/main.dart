import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/pages/Verifypage.dart';
import 'package:flutter_application_1/pages/loginpage.dart';
import 'package:flutter_application_1/pages/errormessage.dart';

//global navigator key
final navigatorKey = GlobalKey<NavigatorState>();
//
//notification channel
Future<void> _firebaseMessageBcakgroundhandler(RemoteMessage) async {}
//

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //firebase notification
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessageBcakgroundhandler);
  //
  runApp(MaterialApp(
    scaffoldMessengerKey: messengerKey,
    navigatorKey: navigatorKey,
    home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Verifyemail();
          } else {
            return const loginpage();
          }
        }),
  ));
}

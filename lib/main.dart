import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/homepage.dart';
import 'package:flutter_application_1/pages/Verifypage.dart';
import 'package:flutter_application_1/pages/loginpage.dart';
import 'package:flutter_application_1/pages/registerpage.dart';
import 'package:flutter_application_1/pages/errormessage.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    scaffoldMessengerKey: messengerKey,
    navigatorKey: navigatorKey,
    home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Verifyemail();
          } else {
            return loginpage();
          }
        }),
  ));
}

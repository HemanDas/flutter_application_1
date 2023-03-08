import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/pages/verifypage.dart';
import 'package:flutter_application_1/pages/loginpage.dart';
import 'package:flutter_application_1/pages/errormessage.dart';

// Global navigator key
final navigatorKey = GlobalKey<NavigatorState>();

// Global messenger key
final messengerKey = GlobalKey<ScaffoldMessengerState>();

// Firebase notification background handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle the message in the background
}

Future<void> main() async {
  // Ensure that the Widgets framework is fully initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Set up Firebase messaging
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  // Run the app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: messengerKey,
      navigatorKey: navigatorKey,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator if we're waiting for the auth state to change
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Show an error message if there is an error with the auth stream
            return const ErrorMessage();
          } else if (snapshot.hasData) {
            // User is signed in, show VerifyEmail widget
            return const Verifyemail();
          } else {
            // User is not signed in, show LoginPage widget
            return const loginpage();
          }
        },
      ),
    );
  }
}

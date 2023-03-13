import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/pages/Sidebar.dart';
import 'package:flutter_application_1/pages/personalpages/tracker_homepage.dart';

import '../../homepage.dart';
import 'details/widgets/details.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  runApp(const FitnessTracker());
}

class FitnessTracker extends StatelessWidget {
  const FitnessTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Tracker',
      theme: ThemeData(
          fontFamily: 'Poppins',
          textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w900,
            ),
          )),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => TrackerHomepage(),
        '/details': (context) => DetailsPage(),
      },
      initialRoute: '/details',
    );
  }
}

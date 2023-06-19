import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/personalpages/current.dart';
import 'package:flutter_application_1/pages/personalpages/header.dart';
import 'package:flutter_application_1/pages/personalpages/activity.dart';

import 'package:flutter_application_1/widgets/bottom_navigation.dart';

class TrackerHomepage extends StatelessWidget {
  const TrackerHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const Sidebar(),
      // appBar: AppBar(
      //   title: const Text('Fitnex'),
      //   toolbarHeight: 40.0,
      //   centerTitle: true,
      //   backgroundColor: const Color(0xff5ac18e),
      //   elevation: 3.0,
      // ),
      body: Column(
        children: [
          AppHeader(),
          CurrentPrograms(),
          RecentActivities(),
          BottomNavigation(),
        ],
      ),
    );
  }
}

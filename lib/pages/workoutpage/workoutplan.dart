import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Sidebar.dart';
import 'package:flutter_application_1/pages/container.dart';
import 'package:flutter_application_1/pages/exercise/exercise.dart';
import 'package:flutter_application_1/pages/personalpages/userinfo.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

class WorkoutPlan extends StatefulWidget {
  const WorkoutPlan({Key? key}) : super(key: key);

  @override
  State<WorkoutPlan> createState() => _WorkoutPlanState();
}

class _WorkoutPlanState extends State<WorkoutPlan> {
  int currentindex = 0;
  @override
  void initState() {
    getData();
    super.initState();
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((event) {});
  }

  Future getNotification() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xff5ac18e),
              const Color(0xff63d471),
              const Color(0xff70e5a5),
            ],
          ),
        ),
        child: Center(
          child: currentindex == 0
              ? const Exercise()
              : currentindex == 1
                  ? const calculator()
                  : currentindex == 2
                      ? const schedule()
                      : WorkoutPlan(),
        ),
      ),
    );
  }
}

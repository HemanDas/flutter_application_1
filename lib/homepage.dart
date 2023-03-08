import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Sidebar.dart';
import 'package:flutter_application_1/pages/container.dart';
import 'package:flutter_application_1/pages/exercise/exercise.dart';
import 'package:flutter_application_1/pages/personalpages/userinfo.dart';
import 'package:flutter_application_1/pages/workoutpage/workoutplan.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

class Fitnex extends StatefulWidget {
  const Fitnex({Key? key}) : super(key: key);

  @override
  State<Fitnex> createState() => _FitnexState();
}

class _FitnexState extends State<Fitnex> {
  int currentindex = 0;

  @override
  void initState() {
    getData();
    super.initState();
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((event) {});
  }

  Future getNotification() async {}

  Widget _getCurrentWidget(int index) {
    switch (index) {
      case 0:
        return const Exercise();
      case 1:
        return const calculator();
      case 2:
        return const schedule();
      default:
        return WorkoutPlan();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        title: const Text('Fitnex'),
        toolbarHeight: 40.0,
        centerTitle: true,
        backgroundColor: const Color(0xff5ac18e),
        elevation: 3.0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            label: 'body',
            icon: Icon(Icons.boy_outlined),
          ),
          BottomNavigationBarItem(
            label: 'calculator',
            icon: Icon(Icons.calculate),
          ),
          BottomNavigationBarItem(
            label: 'Schedule',
            icon: Icon(Icons.calendar_month_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Workout',
            icon: Icon(Icons.fitness_center),
          ),
        ],
        currentIndex: currentindex,
        onTap: (int index) {
          setState(() {
            currentindex = index;
          });
        },
        backgroundColor: const Color(0xff5ac18e),
      ),
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
          child: _getCurrentWidget(currentindex),
        ),
      ),
    );
  }
}

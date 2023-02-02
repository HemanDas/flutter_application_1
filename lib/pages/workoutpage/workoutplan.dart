import 'package:flutter/material.dart';

class workoutplan extends StatefulWidget {
  const workoutplan({super.key});

  @override
  State<workoutplan> createState() => _workoutplanState();
}

class _workoutplanState extends State<workoutplan> {
  final Exercise = [
    "Little or no exercise",
    "Lightly active(sports 1-3 days/week)",
    "Moderate active(sports 3-5 days/week)",
    "Very active(sports 6-7 days/week)",
    "Extra active (sports & physical job)"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(),
    );
  }
}

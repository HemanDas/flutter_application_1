import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/calculator/BMI.dart';
import 'package:flutter_application_1/pages/calculator/Calorie_calculator.dart';
// import 'package:flutter_application_1/pages/loginpage.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
    );
  }
}

class calculator extends StatefulWidget {
  const calculator({super.key});

  @override
  State<calculator> createState() => _calculatorState();
}

class _calculatorState extends State<calculator> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 80,
          ),

          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.man_rounded,
                        ),
                        alignment: Alignment.topLeft,
                        color: Colors.black,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BMI(),
                            ),
                          );
                        },
                        iconSize: 80.0,
                      ),
                      const Text(
                        'BMI',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.egg_outlined,
                        ),
                        alignment: Alignment.topLeft,
                        color: Colors.black,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Caloriecalc(),
                              ));
                        },
                        iconSize: 80.0,
                      ),
                      const Text(
                        'Calorie\n intake',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.bedroom_child,
                        ),
                        alignment: Alignment.topLeft,
                        color: Colors.black,
                        onPressed: () {},
                        iconSize: 80.0,
                      ),
                      const Text(
                        'BMI',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.bedroom_child,
                        ),
                        alignment: Alignment.topLeft,
                        color: Colors.black,
                        onPressed: () {},
                        iconSize: 80.0,
                      ),
                      const Text(
                        'BMI',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          // width: double.infinity,
          // height: double.infinity,
          // color: Colors.grey,
        ));
  }
}

class schedule extends StatefulWidget {
  const schedule({super.key});

  @override
  State<schedule> createState() => _scheduleState();
}

class _scheduleState extends State<schedule> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
    );
  }
}

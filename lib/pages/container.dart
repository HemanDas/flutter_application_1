import 'package:flutter/material.dart';

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
      color: Colors.grey,
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(
                  Icons.man,
                ),
                alignment: Alignment.topLeft,
                color: Colors.black,
                onPressed: () {},
                iconSize: 80.0,
              ),
              IconButton(
                icon: Icon(
                  Icons.egg,
                ),
                alignment: Alignment.topLeft,
                color: Colors.black,
                onPressed: () {},
                iconSize: 80.0,
              ),
              IconButton(
                icon: Icon(
                  Icons.bedroom_child,
                ),
                alignment: Alignment.topLeft,
                color: Colors.black,
                onPressed: () {},
                iconSize: 80.0,
              ),
              IconButton(
                icon: Icon(
                  Icons.bedroom_child,
                ),
                alignment: Alignment.topLeft,
                color: Colors.black,
                onPressed: () {},
                iconSize: 80.0,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'BMI',
                style: TextStyle(fontSize: 20.0),
              ),
              Text(
                'Calorie\n intake',
                style: TextStyle(fontSize: 20.0),
              ),
              Text(
                'BMI',
                style: TextStyle(fontSize: 20.0),
              ),
              Text(
                'BMI',
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
        ],
      ),
      // width: double.infinity,
      // height: double.infinity,
      // color: Colors.grey,
    );
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
      color: Colors.amber,
    );
  }
}

import 'package:flutter/material.dart';

class BMI extends StatefulWidget {
  const BMI({super.key});

  @override
  State<BMI> createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  final _heightController =
      TextEditingController(); //the controller for the text field associated with height
  final _weightController =
      TextEditingController(); //the controller for the text field associated with weight
  double? _bmi;
  // the message at the beginning
  String _message = 'Please enter your height an weight';

  // This function is triggered when the user pressess the "Calculate" button
  void _calculate() {
    final double? height = double.tryParse(_heightController.value.text);
    final double? weight = double.tryParse(_weightController.value.text);

    // Check if the inputs are valid
    if (height == null || height <= 0 || weight == null || weight <= 0) {
      setState(() {
        _message = "Your height and weigh must be positive numbers";
      });
      return;
    }

    setState(() {
      _bmi = weight / (height * height);
      if (_bmi! < 18.5) {
        _message = "You are underweight";
      } else if (_bmi! < 25) {
        _message = 'You body is fine';
      } else if (_bmi! < 30) {
        _message = 'You are overweight';
      } else {
        _message = 'You are obese';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("BMI"),
          centerTitle: true,
          backgroundColor: Color(0xff5ac18e),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x665ac18e),
                  Color(0x995ac18e),
                  Color(0xcc5ac18e),
                  Color(0xff5ac18e),
                ]),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 80, 50, 50),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                TextField(
                  style: TextStyle(fontSize: 25),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                      labelText: "Height(m)", border: OutlineInputBorder()),
                  controller: _heightController,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  style: TextStyle(fontSize: 25),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                      labelText: 'Weight (kg)', border: OutlineInputBorder()),
                  controller: _weightController,
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff5ac18e),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                  onPressed: _calculate,
                  child: const Text(
                    'Calculate',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  _bmi == null ? 'No Result' : _bmi!.toStringAsFixed(2),
                  style: const TextStyle(fontSize: 50),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  _message,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
        ));
  }
}

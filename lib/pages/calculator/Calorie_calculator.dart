import 'package:flutter/material.dart';

class Caloriecalc extends StatefulWidget {
  const Caloriecalc({super.key});

  @override
  State<Caloriecalc> createState() => _CaloriecalcState();
}

class _CaloriecalcState extends State<Caloriecalc> {
  _CaloriecalcState() {
    _selectedVal = _Gender[0];
    _selectVal = _Exercise[0];
  }
  //dropdown variables for gender
  final _Gender = ["Man", "Woman"];
  String? _selectedVal = "";
  //
  //dropdown variables for gender
  final _Exercise = [
    "Little or no exercise",
    "Lightly active(sports 1-3 days/week)",
    "Moderate active(sports 3-5 days/week)",
    "Very active(sports 6-7 days/week)",
    "Extra active (sports & physical job)"
  ];
  String? _selectVal = "";
  //
  double? _calorie, _bmr;
  final _heightController =
      TextEditingController(); //the controller for the text field associated with height
  final _weightController =
      TextEditingController(); //the controller for the text field associated with weight
  final _ageController =
      TextEditingController(); //the controller for the text field associated with weight
  // the message at the beginning
  String? _message;

  // This function is triggered when the user pressess the "Calculate" button
  void _calculate() {
    final double? height = double.tryParse(_heightController.value.text);
    final double? weight = double.tryParse(_weightController.value.text);
    final double? age = double.tryParse(_ageController.value.text);

    // Check if the inputs are valid
    if (height == null ||
        height <= 0 ||
        weight == null ||
        weight <= 0 ||
        age == null ||
        age <= 0) {
      setState(() {
        _message = "Your height , weight and age must be positive numbers";
      });
      return;
    }
    if (_selectedVal == _Gender[1]) {
      setState(
        () {
          _bmr =
              655.1 + (9.563 * weight) + (1.850 * height * 100) - (4.676 * age);
        },
      );
    } else {
      setState(
        () {
          _bmr =
              66.5 + (13.75 * weight) + (5.003 * height * 100) - (6.75 * age);
        },
      );
    }
    if (_selectVal == _Exercise[0] && _bmr != null) {
      setState(() {
        _calorie = _bmr! * 1.2;
      });
    }
    if (_selectVal == _Exercise[1] && _bmr != null) {
      setState(() {
        _calorie = _bmr! * 1.375;
      });
    }
    if (_selectVal == _Exercise[2] && _bmr != null) {
      setState(() {
        _calorie = _bmr! * 1.55;
      });
    }
    if (_selectVal == _Exercise[3] && _bmr != null) {
      setState(() {
        _calorie = _bmr! * 1.725;
      });
    }
    if (_selectVal == _Exercise[4] && _bmr != null) {
      setState(() {
        _calorie = _bmr! * 1.9;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calorie Calculator"),
        centerTitle: true,
        backgroundColor: const Color(0xff5ac18e),
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
          padding: const EdgeInsets.fromLTRB(50, 30, 50, 50),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: "Gender",
                  border: OutlineInputBorder(),

                  labelStyle: TextStyle(
                    fontSize: 30,
                  ),
                  // prefixIcon: Icon(Icons.man),
                ),
                value: _selectedVal,
                items: _Gender.map((genderselect) {
                  return DropdownMenuItem(
                    child: Text(
                      genderselect,
                      style: TextStyle(fontSize: 20),
                    ),
                    value: genderselect,
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedVal = val as String;
                  });
                },
                dropdownColor: Colors.white,
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                style: const TextStyle(fontSize: 25),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                    labelText: "Height(m)", border: OutlineInputBorder()),
                controller: _heightController,
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                style: const TextStyle(fontSize: 25),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                    labelText: 'Weight (kg)', border: OutlineInputBorder()),
                controller: _weightController,
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                style: const TextStyle(fontSize: 25),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: false),
                decoration: const InputDecoration(
                    labelText: 'Age', border: OutlineInputBorder()),
                controller: _ageController,
              ),
              const SizedBox(
                height: 15,
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: "Exercise routine",
                  border: OutlineInputBorder(),

                  labelStyle: TextStyle(
                    fontSize: 30,
                  ),
                  // prefixIcon: Icon(Icons.man),
                ),
                value: _selectVal,
                items: _Exercise.map((exerciseselect) {
                  return DropdownMenuItem(
                    child: Text(
                      exerciseselect,
                      style: TextStyle(fontSize: 20),
                    ),
                    value: exerciseselect,
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    _selectVal = val as String;
                  });
                },
                dropdownColor: Colors.white,
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff5ac18e),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                ),
                onPressed: () {
                  _calculate();
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (buildContext) {
                        return FractionallySizedBox(
                          heightFactor: 0.8,
                          child: Container(
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                  Color(0x665ac18e),
                                  Color(0x995ac18e),
                                  Color(0xcc5ac18e),
                                  Color(0xff5ac18e),
                                ])),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(50, 60, 50, 20),
                              child: Column(
                                children: [
                                  const Text(
                                    "Results",
                                    style: TextStyle(
                                      fontSize: 50,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "BMR:",
                                        style: TextStyle(fontSize: 30),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        _bmr == null
                                            ? ''
                                            : _bmr!.toStringAsFixed(2),
                                        style: const TextStyle(fontSize: 30),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Calorie:",
                                        style: TextStyle(fontSize: 30),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        _calorie == null
                                            ? ''
                                            : _calorie!.toStringAsFixed(2),
                                        style: const TextStyle(fontSize: 30),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
                child: const Text(
                  'Calculate',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              // const SizedBox(
              //   height: 20,
              // ),
              // Text(
              //   _message,
              //   textAlign: TextAlign.center,
              //   style: TextStyle(fontSize: 18),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

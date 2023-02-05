import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class Firsttab extends StatefulWidget {
  const Firsttab({super.key});

  @override
  State<Firsttab> createState() => _FirsttabState();
}

class _FirsttabState extends State<Firsttab> {
  var predvalue = '';
  final week1Controller = TextEditingController();
  final week2Controller = TextEditingController();
  final week3Controller = TextEditingController();
  final week4Controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    predvalue = 'click predict button';
  }

  Widget buildweek(controllesr) {
    return TextFormField(
      controller: controllesr,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      style: const TextStyle(color: Colors.black87),
      decoration: const InputDecoration(
          labelText: "week", border: OutlineInputBorder()),
    );
  }

  Future<void> predData() async {
    final double? week1 = double.tryParse(week1Controller.value.text);
    final double? week2 = double.tryParse(week2Controller.value.text);
    final double? week3 = double.tryParse(week3Controller.value.text);
    final double? week4 = double.tryParse(week4Controller.value.text);
    final interpreter = await Interpreter.fromAsset('weightprediction.tflite');
    var input = [
      [week1, week2, week3, week4]
    ];
    var output = List.filled(1, 0).reshape([1, 1]);
    interpreter.run(input, output);
    print(output[0][0]);
    this.setState(() {
      predvalue = output[0][0].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Container(
          child: Column(
            children: [
              // buildweek1(),

              buildweek(week1Controller),
              buildweek(week2Controller),
              buildweek(week3Controller),
              buildweek(week4Controller),
              ElevatedButton(
                onPressed: () {
                  predData();
                },
                child: Text('predict'),
              ),
              Text("change the input values in code to get the prediction"),
              Text(predvalue.toString())
            ],
          ),
        ),
      ),
    );
  }
}

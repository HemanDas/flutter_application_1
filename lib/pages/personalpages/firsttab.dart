import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class Firsttab extends StatefulWidget {
  const Firsttab({super.key});

  @override
  State<Firsttab> createState() => _FirsttabState();
}

class _FirsttabState extends State<Firsttab> {
  var predvalue = '';
  @override
  void initState() {
    super.initState();
    predvalue = 'click predict button';
  }

  Future<void> predData() async {
    final interpreter = await Interpreter.fromAsset('weightprediction.tflite');
    var input = [
      [95.5, 93.0, 92.0, 90.0]
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
    return Container(
      child: Container(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
              child: ElevatedButton(
                onPressed: () {
                  predData();
                },
                child: Text('predict'),
              ),
            ),
            Text("change the input values in code to get the prediction"),
            SizedBox(
              height: 30,
            ),
            Text('$predvalue')
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:heart_bpm/chart.dart';
import 'package:heart_bpm/heart_bpm.dart';

class heartbpm extends StatefulWidget {
  const heartbpm({super.key});

  @override
  State<heartbpm> createState() => _heartbpmState();
}

class _heartbpmState extends State<heartbpm> {
  List<SensorValue> data = [];
  List<SensorValue> bpmValues = [];
  // Widget chart = BPMChart(data);

  bool isBPMEnabled = false;
  Widget? dialog;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Heart BPM Demo'),
      ),
      body: Column(
        children: [
          isBPMEnabled
              ? dialog = HeartBPMDialog(
                  alpha: 0.5,
                  context: context,
                  onRawData: (value) {
                    setState(() {
                      if (data.length >= 100) data.removeAt(0);
                      data.add(value);
                    });
                    // chart = BPMChart(data);
                  },
                  onBPM: (value) => setState(() {
                    if (bpmValues.length >= 100) bpmValues.removeAt(0);
                    bpmValues.add(SensorValue(
                        value: value.toDouble(), time: DateTime.now()));
                  }),
                  // sampleDelay: 1000 ~/ 20,
                  // child: Container(
                  //   height: 50,
                  //   width: 100,
                  //   child: BPMChart(data),
                  // ),
                )
              : SizedBox(),
          isBPMEnabled && data.isNotEmpty
              ? Container(
                  decoration: BoxDecoration(border: Border.all()),
                  height: 180,
                  width: 300,
                  child: BPMChart(data),
                )
              : SizedBox(
                  height: 10,
                ),
          isBPMEnabled && bpmValues.isNotEmpty
              ? Container(
                  decoration: BoxDecoration(border: Border.all()),
                  constraints: BoxConstraints.expand(
                    height: 180,
                    width: 300,
                  ),
                  child: BPMChart(bpmValues),
                )
              : SizedBox(),
          Center(
            child: ElevatedButton.icon(
              icon: Icon(Icons.favorite_rounded),
              label: Text(isBPMEnabled ? "Stop measurement" : "Measure BPM"),
              onPressed: () => setState(() {
                if (isBPMEnabled) {
                  isBPMEnabled = false;
                  dialog;
                } else
                  isBPMEnabled = true;
              }),
            ),
          ),
        ],
      ),
    );
  }
}

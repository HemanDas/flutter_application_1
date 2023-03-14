import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/personalpages/details/widgets/graph.dart';
import 'package:flutter_application_1/pages/personalpages/details/widgets/info.dart'
    hide Stats;
import 'package:flutter_application_1/pages/personalpages/details/widgets/stats.dart';
import 'package:flutter_application_1/pages/personalpages/details/widgets/steps.dart';

import '../../../../widgets/bottom_navigation.dart';
import '../appbar.dart';
import 'dates.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainApppBar(
        appBar: AppBar(),
      ),
      body: Column(
        children: const [
          Dates(),
          Steps(),
          Graph(),
          Info(),
          Divider(
            height: 30,
          ),
          Stats(),
          SizedBox(
            height: 30,
          ),
          BottomNavigation(),
        ],
      ),
    );
  }
}

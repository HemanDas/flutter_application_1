import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/personalpages/details/widgets/graph.dart';
import 'package:flutter_application_1/pages/personalpages/details/widgets/info.dart';
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
      appBar: MainApppBar(
        appBar: AppBar(),
      ),
      body: Column(
        children: [
          Dates(),
          Steps(),
          Graph(),
          Info(),
          Stats(),
          BottomNavigation(),
        ],
      ),
    );
  }
}

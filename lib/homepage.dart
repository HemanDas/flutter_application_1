import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Sidebar.dart';
import 'package:flutter_application_1/pages/container.dart';
import 'package:flutter_application_1/pages/personalpages/userinfo.dart';

class Fitnex extends StatefulWidget {
  const Fitnex({super.key});

  @override
  State<Fitnex> createState() => _FitnexState();
}

class _FitnexState extends State<Fitnex> {
  int currentindex = 0;
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(),
      appBar: AppBar(
        title: const Text('Fitnex'),
        toolbarHeight: 40.0,
        centerTitle: true,
        backgroundColor: const Color(0xff5ac18e),
        elevation: 3.0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            label: 'body',
            icon: Icon(Icons.boy_outlined),
          ),
          BottomNavigationBarItem(
            label: 'calculator',
            icon: Icon(Icons.calculate),
          ),
          BottomNavigationBarItem(
            label: 'Schedule',
            icon: Icon(Icons.calendar_month_outlined),
          ),
        ],
        currentIndex: currentindex,
        onTap: (int index) {
          setState(() {
            currentindex = index;
          });
        },
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
        child: Center(
          child: currentindex == 0
              ? const Body()
              : currentindex == 1
                  ? const calculator()
                  : const schedule(),
        ),
      ),
    );
  }
}

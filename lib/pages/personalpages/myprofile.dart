import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/personalpages/editprofile.dart';
import 'package:flutter_application_1/pages/personalpages/firsttab.dart';
import 'package:flutter_application_1/pages/personalpages/secondtab.dart';
import 'package:flutter_application_1/pages/personalpages/thirdtab.dart';
import 'package:flutter_application_1/pages/personalpages/userinfo.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("My Profile"),
            centerTitle: true,
            backgroundColor: Color(0xff5ac18e),
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: 8.00),
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => editprof(),
                          ),
                        );
                      },
                      icon: Icon(Icons.edit)))
            ],
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
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                          ),
                        ],
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                          child: img_url != null
                              ? Image.network(
                                  img_url.toString(),
                                  fit: BoxFit.cover,
                                )
                              : Icon(
                                  Icons.camera_enhance,
                                  size: 80,
                                ))),
                  SizedBox(
                    height: 10,
                  ),
                  Text("$firstname \t" + '$lastname'),
                  SizedBox(
                    height: 50,
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text("Weight"),
                            Text("82 kg"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text("Height"),
                            Text("1.83 m"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text("age"),
                            Text("21"),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text("BMI"),
                          Text("2034"),
                        ],
                      ),
                    ],
                  ),
                  Divider(),
                  TabBar(
                    tabs: [
                      Tab(
                        icon: Icon(Icons.favorite),
                      ),
                      Tab(
                        icon: Icon(Icons.favorite),
                      ),
                      Tab(
                        icon: Icon(Icons.favorite),
                      )
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Firsttab(),
                        Secondtab(),
                        Thirdtab(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

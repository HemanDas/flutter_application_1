import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/personalpages/myprofile.dart';
import 'package:flutter_application_1/pages/personalpages/Settings.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/pages/personalpages/userinfo.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  final user = FirebaseAuth.instance.currentUser!;

  CollectionReference User = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff5ac18e),
                Color(0xff63d471),
                Color(0xff70e5a5),
              ]),
        ),
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('$firstname\t' '$lastname'),
              accountEmail: Text('$email'),
              decoration: const BoxDecoration(color: Color(0xff5ac18e)),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: img_url != null
                      ? Image.network(
                          img_url.toString(),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: Colors.grey[300],
                          child: const Center(
                            child: Text("No Image"),
                          ),
                        ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const profile(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Plans and Packages'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Setting(),
                  ),
                );
              },
            ),
            const Divider(
              color: Colors.grey,
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () => FirebaseAuth.instance.signOut(),
            ),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('My App'),
        ),
        drawer: Sidebar(),
        body: Container(),
      ),
    );
  }
}

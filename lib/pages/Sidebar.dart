import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/container.dart';
import 'package:flutter_application_1/pages/loginpage.dart';
import 'package:flutter_application_1/pages/personalpages/myprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/pages/personalpages/userinfo.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  final user =
      FirebaseAuth.instance.currentUser!; //access users info from firebase
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
                Color(0x665ac18e),
                Color(0xff5ac18e),
              ]),
        ),
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('$firstname\t' + '$lastname'),
              accountEmail: Text('$email'), // display user email from firebase
              decoration: BoxDecoration(color: Color(0xff5ac18e)),
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
                          child: Center(
                            child: Text("No Image"),
                          ),
                        ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => profile(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('Plans and Packages'),
              onTap: () {
                print(height);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () => null,
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () => FirebaseAuth.instance.signOut(),
            ),
          ],
        ),
      ),
    );
  }
}

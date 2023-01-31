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
                      ? Image.asset(
                          '$img_url',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : Icon(
                          Icons.camera_enhance,
                          size: 50,
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
              onTap: () => null,
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

class loggedoutsidebar extends StatefulWidget {
  const loggedoutsidebar({super.key});

  @override
  State<loggedoutsidebar> createState() => _loggedoutsidebarState();
}

class _loggedoutsidebarState extends State<loggedoutsidebar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xff5ac18e),
      child: ListView(
        children: [
          ListTile(
            leading: Icon(
              Icons.calculate,
              color: Colors.white,
            ),
            title: Text(
              'Calculator',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => calculator(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.book,
              color: Colors.white,
            ),
            title: Text(
              'Plans and packages',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => calculator(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//to import data from firebase to display it in the app
final FirebaseAuth authen = FirebaseAuth.instance;
String? uid;
String? firstname;
String? lastname;
String? email;

void getData() async {
  User user = authen.currentUser!;
  uid = user.uid;
  print('${user.email}');
  final DocumentSnapshot userDocs =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
  firstname = userDocs.get('first name');
  lastname = userDocs.get('last name');
  email = userDocs.get('email');
}

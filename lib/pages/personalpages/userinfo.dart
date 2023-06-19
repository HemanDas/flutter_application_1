import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//to import data from firebase to display it in the app
final FirebaseAuth authen = FirebaseAuth.instance;
String? uid;
String? firstname;
String? lastname;
String? email;
String? age;
String? height;
String? weight;
String? img_url;
List<dynamic>? notificationdetails;

Future getData() async {
  User user = authen.currentUser!;
  uid = user.uid;
  final DocumentSnapshot userDocs = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('userdocuments')
      .doc('userinfo')
      .get();
  {
    try {
      firstname = userDocs.get('first name');
      lastname = userDocs.get('last name');
      email = userDocs.get('email');
      age = userDocs.get('age');
      weight = userDocs.get('weight');
      height = userDocs.get('height');
      userDocs.get('imageUrl');
      img_url = userDocs.get('imageUrl');
    } catch (e) {
      print('error');
    }
  }
  final DocumentSnapshot notif = await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('userdocuments')
      .doc('calenderplan')
      .collection('exerciseday')
      .doc(DateTime.now().toString().split(" ")[0])
      .get();
  {
    try {
      notificationdetails = notif.get('Title');
    } catch (e) {
      print('error');
    }
  }
}

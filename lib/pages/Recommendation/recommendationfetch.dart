import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/pages/personalpages/userinfo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<String>? recommendedExercises;
Future fetchRecommendedExercises() async {
  String exe = '';
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
      exe = userDocs.get('recom');
    } catch (e) {
      print('error');
    }
  }
  final url = 'http://10.0.2.2:5000/recommendation?recom=${exe}';

  final uri = Uri.parse(url);
  http.Response response = await http.get(uri);

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final List<String> recommendedExercises = data.keys.toList();
    return recommendedExercises;
  } else {
    throw Exception('Failed to fetch recommended exercises');
  }
}

Future fetches() async {
  fetchRecommendedExercises().then((data) async {
    recommendedExercises = data;
  }).catchError((error) {
    print(error);
  });
}

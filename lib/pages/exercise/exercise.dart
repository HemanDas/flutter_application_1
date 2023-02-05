import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/exercise/listexercise.dart';

String? Exercisename;

class Exercise extends StatefulWidget {
  const Exercise({super.key});

  @override
  State<Exercise> createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  @override
  CollectionReference exercise =
      FirebaseFirestore.instance.collection('Exercise');

  Stream<QuerySnapshot>? streamexercise;
  void initState() {
    super.initState();
    streamexercise = exercise.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: streamexercise,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return CircularProgressIndicator();
        }
        if (snapshot.connectionState == ConnectionState.active) {
          QuerySnapshot querySnapshot = snapshot.data;
          List<QueryDocumentSnapshot> listQueryDocumentSnapshot =
              querySnapshot.docs;
          return ListView.builder(
              itemCount: listQueryDocumentSnapshot.length,
              itemBuilder: (context, index) {
                QueryDocumentSnapshot document =
                    listQueryDocumentSnapshot[index];
                return InkWell(
                  onTap: (() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => listexercise(
                          value: document['name'],
                        ),
                      ),
                    );
                  }),
                  child: Container(
                    height: 60,
                    width: 30,
                    margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              document['name'],
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

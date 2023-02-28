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
      FirebaseFirestore.instance.collection('Exercises');

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

          List<String> bodyPart = querySnapshot.docs
              .map((doc) => doc['bodyPart'].toString())
              .toSet()
              .toList();
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Set the number of columns in the grid
                crossAxisSpacing: 1, // Set the spacing between columns
                mainAxisSpacing: 20, // Set the spacing between rows
                childAspectRatio: 2, // Set the aspect ratio of each item
              ),
              itemCount: bodyPart.length,
              itemBuilder: (context, index) {
                String Body = bodyPart[index];
                return InkWell(
                  onTap: (() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => listexercise(
                          value: Body,
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
                              Body,
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

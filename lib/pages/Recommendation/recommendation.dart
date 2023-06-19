import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/personalpages/userinfo.dart';
import 'recommendationfetch.dart';

class DisplayRecommendedExercises extends StatefulWidget {
  @override
  _DisplayRecommendedExercisesState createState() =>
      _DisplayRecommendedExercisesState();
}

class _DisplayRecommendedExercisesState
    extends State<DisplayRecommendedExercises> {
  List<String> exercise = [];

  @override
  void initState() {
    super.initState();

    fetch();
  }

  Future fetch() async {
    if (recommendedExercises != null) {
      for (int i = 0; i < recommendedExercises!.length; i++) {
        exercise.add(recommendedExercises![i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference listexercise =
        FirebaseFirestore.instance.collection('Exercises');

    Stream<QuerySnapshot>? streamlistexercise = recommendedExercises != null
        ? listexercise.where('name', whereIn: recommendedExercises).snapshots()
        : null;

    return StreamBuilder<QuerySnapshot>(
      stream: streamlistexercise,
      builder: (BuildContext context, AsyncSnapshot Snapshot) {
        if (Snapshot.hasError) {
          return Text('hello');
        }
        if (Snapshot.connectionState == ConnectionState.active) {
          QuerySnapshot querySnapshot = Snapshot.data;
          List<QueryDocumentSnapshot> listQueryDocumentSnapshot =
              querySnapshot.docs;
          listQueryDocumentSnapshot.sort((a, b) =>
              a['name'].toLowerCase().compareTo(b['name'].toLowerCase()));
          return ListView.builder(
              itemCount: listQueryDocumentSnapshot.length,
              itemBuilder: (context, index) {
                QueryDocumentSnapshot documents =
                    listQueryDocumentSnapshot[index];
                return Container(
                  margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              documents['name'],
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Text(
                              'Targeted muscle:\t\t' + documents['target'],
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                      Image.network(documents['gifUrl'].toString())
                    ],
                  ),
                );
              });
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

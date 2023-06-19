import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/pages/exercise/gif.dart';

class listexercise extends StatefulWidget {
  String? value;
  listexercise({Key? key, this.value}) : super(key: key);

  @override
  State<listexercise> createState() => _listexerciseState();
}

class _listexerciseState extends State<listexercise> {
  @override
  Widget build(BuildContext context) {
    CollectionReference listexercise =
        FirebaseFirestore.instance.collection('Exercises');

    Stream<QuerySnapshot> streamlistexercise =
        listexercise.where('bodyPart', isEqualTo: widget.value).snapshots();

    void initState() {
      super.initState();
      Instructions();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.value}"),
        centerTitle: true,
        backgroundColor: const Color(0xff5ac18e),
      ),
      body: Container(
        color: Colors.greenAccent,
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: streamlistexercise,
              builder: (BuildContext context, AsyncSnapshot Snapshot) {
                if (Snapshot.hasError) {
                  return Text('hello');
                }
                if (Snapshot.connectionState == ConnectionState.active) {
                  QuerySnapshot querySnapshot = Snapshot.data;

                  List<String> distinctEquipments = querySnapshot.docs
                      .map((doc) => doc['equipment'].toString())
                      .toSet()
                      .toList();
                  return Expanded(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              2, // Set the number of columns in the grid
                          crossAxisSpacing:
                              10, // Set the spacing between columns
                          mainAxisSpacing: 1, // Set the spacing between rows
                          childAspectRatio:
                              2, // Set the aspect ratio of each item
                        ),
                        itemCount: distinctEquipments.length,
                        itemBuilder: (context, index) {
                          String equipment = distinctEquipments[index];
                          return InkWell(
                            onTap: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Instructions(
                                    Instructionname: equipment,
                                    exercisename: widget.value,
                                  ),
                                ),
                              );
                            }),
                            child: Container(
                              height: 60,
                              width: 30,
                              margin: EdgeInsets.only(
                                  left: 10.0, right: 10.0, top: 20.0),
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
                                        equipment,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class listexercise extends StatefulWidget {
  String? value;
  listexercise({Key? key, this.value}) : super(key: key);

  @override
  State<listexercise> createState() => _listexerciseState();
}

class _listexerciseState extends State<listexercise> {
  @override
  Widget build(BuildContext context) {
    CollectionReference listexercise = FirebaseFirestore.instance
        .collection('Exercise')
        .doc(widget.value!)
        .collection('listexercise');

    Stream<QuerySnapshot> streamlistexercise = listexercise.snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.value}"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: streamlistexercise,
        builder: (BuildContext context, AsyncSnapshot Snapshot) {
          if (Snapshot.hasError) {
            return Text('hello');
          }
          if (Snapshot.connectionState == ConnectionState.active) {
            QuerySnapshot querySnapshot = Snapshot.data;
            List<QueryDocumentSnapshot> listQueryDocumentSnapshot =
                querySnapshot.docs;
            return ListView.builder(
                itemCount: listQueryDocumentSnapshot.length,
                itemBuilder: (context, index) {
                  QueryDocumentSnapshot documents =
                      listQueryDocumentSnapshot[index];
                  return InkWell(
                    onTap: (() {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => listexercise(
                      //       value: document['name'],
                      //     ),
                      //   ),
                      // );
                      print('document:${documents['name']}');
                    }),
                    child: Container(
                      height: 60,
                      width: 30,
                      margin:
                          EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
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
                                documents['name'],
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
      ),
    );
  }
}

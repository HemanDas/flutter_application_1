import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/pages/exercise/instruction.dart';

class Instructions extends StatefulWidget {
  String? Instructionname;
  String? exercisename;

  Instructions({Key? key, this.Instructionname, this.exercisename})
      : super(key: key);

  @override
  State<Instructions> createState() => _InstructionsState();
}

class _InstructionsState extends State<Instructions> {
  bool _ischecked1 = false;
  bool _ischecked2 = false;
  bool _ischecked3 = false;
  bool _ischeckedall = true;
  String checkedvalue = '';
  @override
  Widget build(BuildContext context) {
    CollectionReference listexercise =
        FirebaseFirestore.instance.collection('Exercises');

    // Stream<QuerySnapshot> streamlistexercise =
    //     listexercise.where('difficulty', isEqualTo: checkedvalue).snapshots();
    Stream<QuerySnapshot> streamlistexercise = listexercise
        .where('bodyPart', isEqualTo: widget.exercisename!)
        .where('equipment', isEqualTo: widget.Instructionname)
        .snapshots();

    void initState() {
      super.initState();
      Instructions();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.Instructionname}"),
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
                  List<QueryDocumentSnapshot> listQueryDocumentSnapshot =
                      querySnapshot.docs;
                  return Expanded(
                    child: ListView.builder(
                        itemCount: listQueryDocumentSnapshot.length,
                        itemBuilder: (context, index) {
                          QueryDocumentSnapshot documents =
                              listQueryDocumentSnapshot[index];
                          return Container(
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
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        documents['name'],
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 30.0),
                                      child: Text(
                                        'Targeted muscle:\t\t' +
                                            documents['target'],
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ],
                                ),
                                Image.network(documents['gifUrl'].toString())
                              ],
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

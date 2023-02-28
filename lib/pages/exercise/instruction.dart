import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_player/video_player.dart';

class Instructions extends StatefulWidget {
  String? Instructionname;
  String? exercisename;

  Instructions({Key? key, this.Instructionname, this.exercisename})
      : super(key: key);

  @override
  State<Instructions> createState() => _InstructionsState();
}

class _InstructionsState extends State<Instructions> {
  final FirebaseAuth authen = FirebaseAuth.instance;
  String name = '';
  String instructions = '';
  String url = '';
  VideoPlayerController _controller = VideoPlayerController.network('');
  List<String> lines = [];
  @override
  void initState() {
    super.initState();
    getinstructions();
    print('checl output $lines');
  }

  Future getinstructions() async {
    final DocumentSnapshot exerciseinstruction = await FirebaseFirestore
        .instance
        .collection('Exercise')
        .doc(widget.exercisename!)
        .collection('listexercise')
        .doc(widget.Instructionname!)
        .get();

    try {
      setState(() {
        name = exerciseinstruction.get('name')!;
        url = exerciseinstruction.get('url')!;
        instructions = exerciseinstruction.get('instruction');
      });
      _controller = VideoPlayerController.network(url.toString())
        ..setLooping(true)
        ..initialize().then((_) {
          setState(() {});
          _controller.play();
        });

      lines = instructions.split('.');
      print('checl output $lines');
    } catch (e) {
      print('error');
    }
  }

  Widget buildvideoplayer() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.Instructionname!),
        centerTitle: true,
        backgroundColor: const Color(0xff5ac18e),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
              child: _controller == null
                  ? CircularProgressIndicator()
                  : buildvideoplayer()),
          SizedBox(
            height: 20,
          ),
          Text(
            "Instructions",
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: lines.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: lines == null
                        ? CircularProgressIndicator()
                        : Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.lightGreen,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(
                                  lines[index],
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.left,
                                  textWidthBasis: TextWidthBasis.longestLine,
                                ),
                              ),
                            ),
                          ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

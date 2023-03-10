import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/personalpages/userinfo.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/pages/errormessage.dart';
import 'package:flutter_application_1/main.dart';

class Editprof extends StatefulWidget {
  const Editprof({super.key});

  @override
  State<Editprof> createState() => _EditprofState();
}

class _EditprofState extends State<Editprof> {
  final firstnameeditController = TextEditingController(text: firstname);
  final lastnameeditController = TextEditingController(text: lastname);
  final ageController = TextEditingController(text: age.toString());
  final heightController = TextEditingController(text: height.toString());
  final weightController = TextEditingController(text: weight.toString());

  // image access
  File? pickedImage;
  ImagePicker image = ImagePicker();
  String? url;
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future save() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child:
                  CircularProgressIndicator(), //showing loading indicator while logging in
            ));
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      final User user = auth.currentUser!;
      final uid = user.uid;
      if (pickedImage != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child("UsersImages")
            .child(firstname! + '.jpg');
        await ref.putFile(pickedImage!);
        url = await ref.getDownloadURL();
        await FirebaseFirestore.instance.collection('users')
          ..doc(uid).collection('userdocuments').doc('userinfo').update({
            'imageUrl': url,
          });
      }

      //add user details and make a database of user details with naming their own uid as file name
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('userdocuments')
          .doc('userinfo')
          .update(
        {
          'id': uid,
          'first name': firstnameeditController.text.trim(),
          'last name': lastnameeditController.text.trim(),
          'height': heightController.text.trim(),
          'weight': weightController.text.trim(),
          'age': ageController.text.trim(),
        },
      );
    } on FirebaseAuthException catch (e) {
      // print(e);

      Utils.showSnackBar(e.message, 255, 0, 0,
          100); // shows error message when account is same
    }
    navigatorKey.currentState!.popUntil((route) =>
        route.isFirst); // removes the loading indicator when logged in
  }

  Future pickImage(ImageSource imageType) async {
    try {
      final photo = await image.pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
      });
      // Get.back();
    } catch (error) {}
  }

  Widget buildfirstname() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'First Name',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ],
            ),
            alignment: Alignment.centerLeft,
            height: 60,
            child: TextFormField(
              controller: firstnameeditController,
              keyboardType: TextInputType.name,
              style: const TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.only(left: 20, top: 0, right: 40),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: '$firstname',
                  hintStyle: const TextStyle()),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildlastname() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Last Name',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ],
            ),
            alignment: Alignment.centerLeft,
            height: 60,
            child: TextFormField(
              controller: lastnameeditController,
              keyboardType: TextInputType.name,
              style: const TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.only(left: 20, top: 0, right: 40),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: '$lastname',
                  hintStyle: const TextStyle()),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildage() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Age',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ],
            ),
            alignment: Alignment.centerLeft,
            height: 60,
            child: TextFormField(
              controller: ageController,
              keyboardType:
                  const TextInputType.numberWithOptions(signed: false),
              style: const TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 0, right: 40),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: '$lastname',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildheight() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Height',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ],
            ),
            alignment: Alignment.centerLeft,
            height: 60,
            child: TextFormField(
              controller: heightController,
              keyboardType:
                  const TextInputType.numberWithOptions(signed: false),
              style: const TextStyle(color: Colors.black87),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 20, top: 0, right: 40),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: 'height in meter',
                  hintStyle: TextStyle()),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildweight() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Weight',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ],
            ),
            alignment: Alignment.centerLeft,
            height: 60,
            child: TextFormField(
              controller: weightController,
              keyboardType:
                  const TextInputType.numberWithOptions(signed: false),
              style: const TextStyle(color: Colors.black87),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 20, top: 0, right: 40),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: 'Weight in kg',
                  hintStyle: TextStyle()),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
        backgroundColor: const Color(0xff5ac18e),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 8.00),
              child: IconButton(onPressed: save, icon: const Icon(Icons.save)))
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0x665ac18e),
                Color(0x995ac18e),
                Color(0xcc5ac18e),
                Color(0xff5ac18e),
              ]),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            border: Border.all(width: 4, color: Colors.white),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                              ),
                            ],
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                              child: pickedImage != null
                                  ? Image.file(
                                      pickedImage!,
                                      fit: BoxFit.cover,
                                    )
                                  : const Icon(
                                      Icons.camera_enhance,
                                      size: 80,
                                    ))),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(width: 1.5, color: Colors.white),
                              color: const Color(0xff5ac18e),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                                size: 25,
                              ),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                          "Options",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff5ac18e)),
                                        ),
                                        content: SingleChildScrollView(
                                          child: ListBody(children: [
                                            InkWell(
                                              splashColor:
                                                  const Color(0xff5ac18e),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: IconButton(
                                                      onPressed: () {
                                                        pickImage(
                                                            ImageSource.camera);
                                                      },
                                                      icon: const Icon(
                                                        Icons.camera,
                                                        color:
                                                            Color(0xff5ac18e),
                                                      ),
                                                    ),
                                                  ),
                                                  MaterialButton(
                                                      onPressed: () {
                                                        pickImage(
                                                            ImageSource.camera);
                                                      },
                                                      child: const Text(
                                                        "Camera",
                                                      ))
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              splashColor:
                                                  const Color(0xff5ac18e),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: IconButton(
                                                      onPressed: () {
                                                        pickImage(ImageSource
                                                            .gallery);
                                                      },
                                                      icon: const Icon(
                                                        Icons.image,
                                                        color:
                                                            Color(0xff5ac18e),
                                                      ),
                                                    ),
                                                  ),
                                                  MaterialButton(
                                                    onPressed: () {
                                                      pickImage(
                                                          ImageSource.gallery);
                                                    },
                                                    child:
                                                        const Text('Gallery'),
                                                  )
                                                ],
                                              ),
                                            )
                                          ]),
                                        ),
                                      );
                                    });
                              },
                            ),
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                buildfirstname(),
                buildlastname(),
                buildage(),
                buildheight(),
                buildweight()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

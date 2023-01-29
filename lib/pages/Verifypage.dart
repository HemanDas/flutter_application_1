import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_application_1/homepage.dart';
import 'package:flutter_application_1/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_application_1/pages/errormessage.dart';

class Verifyemail extends StatefulWidget {
  const Verifyemail({super.key});

  @override
  State<Verifyemail> createState() => _VerifyemailState();
}

class _VerifyemailState extends State<Verifyemail> {
  bool isEmailVerified = false;
  Timer? timer;
  @override
  void initState() {
    super.initState();

    // to check whether the email is verified or not
    isEmailVerified = FirebaseAuth.instance.currentUser!
        .emailVerified; // flag to check email verification
    if (!isEmailVerified) {
      sendVerificationEmail();
      //setting time duration for email verification sent
      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  // to check whether the email is verified or not
  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  //to send the verification email
  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      Utils.showSnackBar(e.toString(), 0, 255, 0, 100);
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? Fitnex()
      : Scaffold(
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: GestureDetector(
              child: Stack(
                children: <Widget>[
                  Container(
                    height: double.infinity,
                    width: double.infinity,
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
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 120,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 70,
                          ),
                          const Text(
                            'Verify Email',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 70,
                          ),
                          Center(
                            child: const Text(
                              'Verification email has been sent to your Email',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
}

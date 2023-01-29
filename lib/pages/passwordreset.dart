import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/loginpage.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/pages/registerpage.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pages/errormessage.dart';

class passreset extends StatefulWidget {
  const passreset({super.key});

  @override
  State<passreset> createState() => _passresetState();
}

class _passresetState extends State<passreset> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future resetpass() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child:
                  CircularProgressIndicator(), //showing loading indicator while logging in
            ));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Utils.showSnackBar('Password Reset email Sent', 0, 255, 0, 100);
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message, 255, 0, 0, 100);
    }
    navigatorKey.currentState!.popUntil((route) =>
        route.isFirst); // removes the loading indicator when logged in
  }

  Widget buildemailreset() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: const Text(
              'Enter your Email to receive \n     Password reset Link',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ],
            ),
            height: 60,
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) => email != null &&
                      !EmailValidator.validate(
                          email) // gives a warning sign if a proper email is not given
                  ? '    Enter a valid email'
                  : null,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Colors.black87),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.black,
                ),
                hintText: 'Enter your Email address',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildresetbutton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        ),
        onPressed: resetpass,
        child: const Text(
          'Send Email',
          style: TextStyle(
            color: Color(0xff5ac18e),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        'Password Reset',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      buildemailreset(),
                      buildresetbutton()
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
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newapp/Screens/CodeVerifyScreen.dart';
import 'package:newapp/Screens/flutertoast.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading =false;
  TextEditingController emailController = TextEditingController();
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image.asset(
              //   'assets/mobile_verification_image.png',
              //   height: 200.0,
              // ),
              SizedBox(height: 48.0),
              Text(
                'Recover Password ',
                style: TextStyle(
                  fontSize: 32.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.0),
              TextFormField(
                controller: emailController,
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,

                decoration: InputDecoration(
                  labelText: 'enter email',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  // Perform mobile verification action
                  setState(() {
                    loading = true;
                  });
                  _auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value) {
                    setState(() {
                      loading = false;
                    });

                    Utlis().toastMessage("success");
                    Navigator.pop(context);

                  }).onError((error, stackTrace) {
                    Utlis().toastMessage(error.toString());

                  });



                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: loading? CircularProgressIndicator(color: Colors.white70,):Text(
                  'Recover',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
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

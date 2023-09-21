import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newapp/Screens/CodeVerifyScreen.dart';
import 'package:newapp/Screens/flutertoast.dart';

class MobileVerificationScreen extends StatefulWidget {
  @override
  State<MobileVerificationScreen> createState() => _MobileVerificationScreenState();
}

class _MobileVerificationScreenState extends State<MobileVerificationScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading =false;
  TextEditingController phonenumberController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // phonenumberController.text=+880;
  }

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
                'Mobile Verification',
                style: TextStyle(
                  fontSize: 32.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.0),
              TextFormField(
                controller: phonenumberController,
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.phone,

                decoration: InputDecoration(
                  labelText: 'Phone Number',
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
                  _auth.verifyPhoneNumber(
                    phoneNumber: phonenumberController.text,
                      verificationCompleted: (_){
                        setState(() {

                          loading = false;
                        });

                      },
                      verificationFailed: (e){
                        Utlis().toastMessage("verifaication failed");
                        setState(() {

                          loading = false;
                        });

                      },
                      codeSent: (String VerificationId ,int? token){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CodeVerifyScreen(VerificationId) ));
                        setState(() {

                          loading = false;
                        });
                      },
                      codeAutoRetrievalTimeout:(e){
                        Utlis().toastMessage("timeout");
                        setState(() {

                          loading = false;
                        });
                      });


                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: loading? CircularProgressIndicator(color: Colors.white70,):Text(
                  'Verify',
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

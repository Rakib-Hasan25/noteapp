import 'package:firebase_auth_platform_interface/src/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newapp/Screens/FinalScreen.dart';
import 'package:newapp/Screens/flutertoast.dart';

class CodeVerifyScreen extends StatefulWidget {
  final String verificationId;
  CodeVerifyScreen(this.verificationId);
  @override
  State<CodeVerifyScreen> createState() => _CodeVerifyScreenState();
}

class _CodeVerifyScreenState extends State<CodeVerifyScreen> {
  bool loading =false;

  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController codeController = TextEditingController();
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
                'Code Verification',
                style: TextStyle(
                  fontSize: 32.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.0),
              TextFormField(
                controller: codeController,
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.phone,

                decoration: InputDecoration(
                  labelText: 'Enter Code',
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
                onPressed: () async{
                  setState(() {
                    loading = true;
                  });
                  // Perform mobile verification action
                  final credential =PhoneAuthProvider.credential(verificationId:widget.verificationId ,
                      smsCode: codeController.text.toString());


                  try{
                    await _auth.signInWithCredential(credential);
                    Utlis().toastMessage("Welcome");

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>FinalScreen()));
                  }
                  catch(e){
                    setState(() {
                      loading =false;
                    });
                    Utlis().toastMessage(e.toString());
                  }


                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: loading?CircularProgressIndicator(color: Colors.white,):Text(
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

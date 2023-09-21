import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newapp/Screens/FinalScreen.dart';
import 'package:newapp/Screens/MobileVerification.dart';
import 'package:newapp/Screens/SignUp%20page.dart';
import 'package:newapp/Screens/forgetPassword.dart';
import 'package:newapp/backend/google_auth.dart';

import 'flutertoast.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loading = false;
  // Google_auth google_auth= Google_auth();
  final _formkey = GlobalKey<FormState>();
  final emailController= TextEditingController();
  final passController= TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),

              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                       Center(
                        child: Image.asset(
                            'assets/cover.png',
                        width: 200,
                          height: 250,
                ),
              ),
                    // SizedBox(height: 150.0),
                    Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 32.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40.0),
                    TextFormField(
                      controller: emailController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Email',
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
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return 'please enter email';

                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: passController,
                      style: TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
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
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return 'please enter password';

                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: () {

                        // Perform login action


                        if(_formkey.currentState!.validate()) {
                          setState(() {
                            loading=true;
                          });
                          print("ff");
                          _auth.signInWithEmailAndPassword(
                            email: emailController.text.toString(),
                            password: passController.text.toString(),).then((value){
                            setState(() {
                              loading=false;
                            });
                            Utlis().toastMessage('success');
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>FinalScreen()));

                          }
                          ).onError((error, stackTrace) {
                            setState(() {
                              loading=false;
                            });
                            Utlis().toastMessage(error.toString());
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child:loading?CircularProgressIndicator(color: Colors.black,): Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text("Don't have an account?",style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),),
                        TextButton(
                          onPressed: () {
                            // Navigate to signup screen
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,

                            ),
                          ),
                        ),

                      ],
                    )
                   ,
                    TextButton(
                      onPressed: () {
                        // Navigate to forget password screen
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPasswordScreen()));
                      },
                      child: Text(
                        'Forget Password?',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 2.0),
                    Text(
                      'Continue with',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
    //                     ElevatedButton.icon(
    //                       onPressed: () {
    //
    //                     // UserCredential? userCredential = await google_auth.signInWithGoogle();
    //                     //    if (userCredential != null) {
    //                         // User signed in successfully, you can store data in Firebase
    //                        // FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
    //                               // 'name': userCredential.user!.displayName,
    //                               //  'email': userCredential.user!.email,
    //                                 // Add additional fields as needed
    //                                 //  });
    //                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>FinalScreen()));
    //
    //                     FirebaseFirestore.instance.collection('user').doc("22333").set({
    //                       'name':'ok',
    //                             'nothing':'ffff',
    //                          });
    //                     print("Success");
    //
    //
    //                             // Navigate to the next screen or perform other actions
    // //                           }
    // //                      else {
    // //                        print("not happenn");
    // // // Sign in failed
    // //                                 }
    //                        // Continue with Google
    //                       },
    //                       style: ElevatedButton.styleFrom(
    //                         primary: Colors.red,
    //                         shape: RoundedRectangleBorder(
    //                           borderRadius: BorderRadius.circular(8.0),
    //                         ),
    //                       ),
    //                       icon: Icon(Icons.mail),
    //                       label: Text(
    //                         'Gmail',
    //                         style: TextStyle(
    //                           fontSize: 16.0,
    //                           color: Colors.white,
    //                         ),
    //                       ),
    //                     ),
                        SizedBox(width: 16.0),
                        ElevatedButton.icon(
                          onPressed: () {
                            // Continue with phone number
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>MobileVerificationScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          icon: Icon(Icons.phone),
                          label: Text(
                            'Phone Number',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

          ),
        ),
      ),
    );
  }
}

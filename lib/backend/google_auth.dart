// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
//
//
//
//
// //   GoogleSignIn googleSignIn = GoogleSignIn();
// //   final FirebaseAuth auth = FirebaseAuth.instance;
// //   CollectionReference users = FirebaseFirestore.instance.collection('users';
// //
// //
// //   Future<void>signInWithGoogle(BuildContext context)async{
// //     try{
// //
// //       final GoogleSignInAccount googleSignInAccount = await googleSignIn.sig
// //
// //     }
// //     catch(e){
// //
// // }
// //
// //
// // }
//
//
//
//
//
//
// class Google_auth {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//
//   Future<UserCredential?> signInWithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleSignInAccount = await _googleSignIn
//           .signIn();
//       final GoogleSignInAuthentication googleSignInAuthentication =
//       await googleSignInAccount!.authentication;
//
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication.accessToken,
//         idToken: googleSignInAuthentication.idToken,
//       );
//
//       final UserCredential userCredential = await _auth.signInWithCredential(
//           credential);
//       return userCredential;
//     } catch (e) {
//       print('Error signing in with Google: $e');
//       return null;
//     }
//   }
//
//   Future<void> signOut() async {
//     await _auth.signOut();
//     await _googleSignIn.signOut();
//   }
//
// }

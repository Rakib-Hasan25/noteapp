import 'package:flutter/material.dart';

import '../backend/splashScreenServices.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices=SplashServices();//splashservices class er ekti object create hoice

  void initState() {
    // TODO: implement initState
    super.initState();
    splashServices.islogin(context);
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/cover.png', // Replace with your own image path
              width: 400,
              height: 400,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'My Notes App',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
              fontFamily: 'lato'
            ),
          ),


        ],



      ),
    );
  }
}

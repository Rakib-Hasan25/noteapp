import 'package:flutter/material.dart';


class ProtfolioPage extends StatefulWidget {
  const ProtfolioPage({super.key});

  @override
  State<ProtfolioPage> createState() => _ProtfolioPageState();
}

class _ProtfolioPageState extends State<ProtfolioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        leading: BackButton(
          onPressed:(){ Navigator.pop(context);}
        ),
        title: Text('Developer Profile',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/profile_picture.png',),

            ),
            SizedBox(height: 20),
            Text(
              'Rakib Hasan',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white
                // fontFamily: 'lato'
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Email: rakibhasancuet@gmail.com',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'lato',
                  color: Colors.grey
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Computer Science & Engineering',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Chittagong University of Engineering & Technology',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey
              ),
            ),

          ],
        ),
      ),
    );

  }
}

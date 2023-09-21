import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newapp/Screens/AddNote.dart';
import 'package:newapp/Screens/Edit_Delete%20Screen.dart';
import 'package:newapp/Screens/LoginPage.dart';
import 'package:newapp/Screens/ProtfolioPage.dart';

import 'flutertoast.dart';

class FinalScreen extends StatefulWidget {
  const FinalScreen({super.key});

  @override
  State<FinalScreen> createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {
  TextEditingController searchController = TextEditingController();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String name = "";
  FirebaseAuth auth = FirebaseAuth.instance;

  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('notes');

  final List<Color> myColors = [
    Colors.redAccent,
    Colors.lightBlueAccent,
    Colors.greenAccent,
    Colors.yellow,
    Colors.orangeAccent,
    Colors.pinkAccent,
  ];
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 0.0,
          backgroundColor: Color(0xff070706),
          title: Text(
            "Notes",
            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'lato'),
          ),
        ),
        drawer: drawer(),
        floatingActionButton: floatingActionButton(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  // border: InputBorder(),

                  hintText: "search",
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                style: TextStyle(color: Colors.white70),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),

              // SizedBox(height: 50,),
              //         IconButton(onPressed: (){
              //          auth.signOut().then((value) {
              //          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
              //
              // }).onError((error, stackTrace) {
              // Utlis().toastMessage(error.toString());
              // });
              //
              // }, alignment: Alignment.topLeft,icon: Icon(Icons.login_outlined,color: Colors.white,))

              FutureBuilder<QuerySnapshot>(
                  future: ref.get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 4.00,
                        ),
                      );
                    } else if (snapshot.hasData) {
                      // print("oke done");

                      return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (context, index) {
                              Random random = new Random();
                              Color bg = myColors[random.nextInt(5)];
                              DateTime myDateTime = snapshot
                                  .data?.docs[index]['created']
                                  .toDate();
                              var dataa = snapshot.data?.docs[index].data()
                                  as Map<String, dynamic>;
                              var data = snapshot.data?.docs[index];

                              final title = snapshot.data?.docs[index]['title'];
                              final des =
                                  snapshot.data?.docs[index]['description'];

                              if (name.isEmpty) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditDeleteScreen(
                                                    title.toString(),
                                                    des.toString(),
                                                    data as DocumentSnapshot<
                                                        Object?>))).then(
                                        (value) {
                                      setState(() {});
                                    });
                                  },
                                  child: Card(
                                      elevation: 10,
                                      shadowColor: Colors.blueGrey,
                                      color: bg,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              dataa['title'],
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'lato'),
                                            ),
                                            Container(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                DateFormat.yMMMd()
                                                    .add_jm()
                                                    .format(myDateTime),
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'lato'),
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                );
                              } else if (dataa['title']
                                  .toString()
                                  .toLowerCase()
                                  .startsWith(name.toLowerCase())) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditDeleteScreen(
                                                    title.toString(),
                                                    des.toString(),
                                                    data as DocumentSnapshot<
                                                        Object?>))).then(
                                        (value) {
                                      setState(() {});
                                    });
                                  },
                                  child: Card(
                                      elevation: 10,
                                      shadowColor: Colors.blueGrey,
                                      color: bg,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              dataa['title'],
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'lato'),
                                            ),

                                            Container(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                DateFormat.yMMMd()
                                                    .add_jm()
                                                    .format(myDateTime),
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'lato'),
                                              ),
                                            )
                                            // Text(snapshot.data?.docs[index]['description'],style: TextStyle(color: Colors.white),),
                                          ],
                                        ),
                                      )),
                                );
                              } else {
                                return Container();
                              }
                            }),
                      );
                    } else {
                      return Center(
                          child: Text(
                        'No Note Available',
                        style: TextStyle(color: Colors.white70),
                      ));
                    }
                  })
            ],
          ),
        ));
  }

  FloatingActionButton floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Colors.grey[900],
      onPressed: () {
        Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddNote()))
            .then((value) {
          setState(() {});
        });
      },
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  Drawer drawer() {
    return Drawer(
      backgroundColor: Colors.grey[800],
      child: ListView(
        children: [
          Container(
              child: Image.asset(
            "assets/cover.png",
            height: 200,
          )),
          ListTile(
            title: Text(
              "My Note App",
              style: TextStyle(
                  color: Colors.white70, fontSize: 40, fontFamily: 'lato'),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.white,
          ),
          ListTile(
            title: Text(
              "Log out",
              style: TextStyle(
                  color: Colors.black, fontSize: 25, fontFamily: 'lato'),
            ),
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.white54,
            ),
            onTap: () {
              auth.signOut().then((value) {
                Utlis().toastMessage("Successfully LogOut");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              }).onError((error, stackTrace) {
                Utlis().toastMessage("Successfully LogOut");
              });
            },
          ),
          ListTile(
            title: Text(
              "Developer Profile",
              style: TextStyle(
                  color: Colors.black, fontSize: 25, fontFamily: 'lato'),
            ),
            leading: Icon(
              Icons.question_mark_sharp,
              color: Colors.white54,
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProtfolioPage()));
            },
          ),
        ],
      ),
    );
  }
}

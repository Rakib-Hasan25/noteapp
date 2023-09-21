import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newapp/Screens/flutertoast.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  String? title;
  String? description;
  TextEditingController titleEditingController= TextEditingController();
  TextEditingController desEditingController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return 
      SafeArea(child:
      Scaffold(
        backgroundColor: Colors.black87,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(

              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.grey[700])
                          )

                          ,  onPressed: (){
                              Navigator.of(context).pop();
                            }, child: Icon(Icons.arrow_back_outlined,)
                        ),
                        ElevatedButton(

                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.grey[700])
                            )

                            ,  onPressed: (){
                              add();
                        }, child: Text("Save")
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Form(
                    child: Column(children: [
                      TextFormField(
                      controller: titleEditingController,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Title',
                          hintStyle: TextStyle(color:Colors.white70),
                          fillColor: Colors.grey,


                        )

                          ,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          color: Colors.white70
                        ),
                        // onChanged: (val){
                        //   title =val;
                        // },


                      ),



                      SizedBox(height: 10,),


                      Container(
                        height: MediaQuery.of(context).size.height*.75,
                        child: TextFormField(
                          decoration: InputDecoration.collapsed(
                              hintText: 'Description',
                            hintStyle: TextStyle(color:Colors.white70),
                          ),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          // onChanged: (val){
                          //   description =val;
                          // },
                            maxLines: 20,
                            controller: desEditingController


                        ),
                      ),





                    ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )




      );
  }

  void add()async{





    CollectionReference ref = FirebaseFirestore.instance.
    collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection('notes');

    var data={
      'title': titleEditingController.text,
      'description':desEditingController.text,
      'created':DateTime.now(),
    };

    try{
    ref.add(data);
    Utlis().toastMessage('Notes Added Succefully');
  }
  catch(e){
    Utlis().toastMessage('Something wents Wrong');
    }
    // setState(() {
    //
    // });
    Navigator.pop(context);

    }
}

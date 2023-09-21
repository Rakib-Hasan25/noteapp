import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newapp/Screens/flutertoast.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? _image;//dart io file import korbo

  bool loading =false;

  var newUrl ;

  final picker = ImagePicker();


  Future getImageGallery()async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery,imageQuality: 80);
    setState(() {
      if(pickedFile!=null){
        _image=File(pickedFile.path);
      }
      else{

        print("no image picked");

      }
    });


  }



  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;



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


                      ),



                      SizedBox(height: 10,),


                      Container(
                        height: MediaQuery.of(context).size.height*.25,
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

                            maxLines: 20,
                            controller: desEditingController


                        ),
                      ),


                      InkWell(
                        onTap: (){
                          // print("rka");
                          getImageGallery();
                        },
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white
                            )

                          ),
                          child: _image!=null?Image.file(_image!.absolute): Center(child: Icon(Icons.image,color: Colors.white,),),
                        ),
                      ),
                      SizedBox(height: 20,),
                      ElevatedButton(

                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.grey[700])
                          )

                          ,  onPressed: ()async{
                            setState(() {
                              loading =true;
                            });



                            firebase_storage .Reference ref = firebase_storage.FirebaseStorage.instance.ref("/foldername"+DateTime.now().millisecondsSinceEpoch.toString());
                            firebase_storage.UploadTask uploadTask =ref.putFile(_image!.absolute);

                            Future.value(uploadTask).then((value)async{
                              newUrl =await ref.getDownloadURL();
                              setState(() {
                                loading = false;
                              });

                            }).then((value) {
                              Utlis().toastMessage("image uploaded successfully");
                              setState(() {
                                loading = false;
                              });

                            }).onError((error, stackTrace){
                              Utlis().toastMessage("somethings went wrong");
                              setState(() {
                                loading = false;
                              });

                            });

                      },
                          child:loading?CircularProgressIndicator(color: Colors.black87,): Icon(Icons.upload_file,)
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
    collection('imagenotes');

    var data={
      // 'title': titleEditingController.text,
      // 'description':desEditingController.text,
      'imageUrl': newUrl.toString(),
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

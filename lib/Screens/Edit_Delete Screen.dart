import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newapp/Screens/flutertoast.dart';

class EditDeleteScreen extends StatefulWidget {
  String title;
  String description;
  DocumentSnapshot doctoedit;
  EditDeleteScreen(this.title, this.description, this.doctoedit);

  @override
  State<EditDeleteScreen> createState() => _EditDeleteScreenState();
}

class _EditDeleteScreenState extends State<EditDeleteScreen> {
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController desEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleEditingController.text = widget.title;
    desEditingController.text = widget.description;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.grey[700])),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.arrow_back_outlined,
                          )),
                      Row(
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.grey[700])),
                              onPressed: () {
                                widget.doctoedit.reference.update({
                                  'title':
                                      titleEditingController.text.toString(),
                                  'description':
                                      desEditingController.text.toString(),
                                  'created': DateTime.now(),
                                }).then((value) {
                                  setState(() {});
                                  Navigator.pop(context);
                                  Utlis().toastMessage("Notes Edited");
                                }).onError((error, stackTrace) {
                                  Utlis().toastMessage(error.toString());
                                });
                              },
                              child: Text("Edit")),
                          SizedBox(width: 10,),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.red[700])),
                            onPressed: () {
                              widget.doctoedit.reference.delete().then((value) {
                                Navigator.pop(context);

                                Utlis().toastMessage('Notes Deleted');
                              }).onError((error, stackTrace) {
                                Utlis().toastMessage("something wents wrong");
                              });
                            },
                            child: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration.collapsed(
                          hintText: 'Title',
                          hintStyle: TextStyle(color: Colors.white70),
                          fillColor: Colors.grey,
                        ),
                        controller: titleEditingController,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            color: Colors.white70),
                        onChanged: (val) {},
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * .75,
                        child: TextFormField(
                            decoration: InputDecoration.collapsed(
                              hintText: 'Description',
                              hintStyle: TextStyle(color: Colors.white70),
                            ),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            onChanged: (val) {},
                            maxLines: 20,
                            controller: desEditingController),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

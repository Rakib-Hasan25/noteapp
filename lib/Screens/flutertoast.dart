import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utlis{

  void toastMessage(e){
    Fluttertoast.showToast(
        msg: e,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white10,
        textColor: Colors.white,
        fontSize: 16.0
    );



}
}
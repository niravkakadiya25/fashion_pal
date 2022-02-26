import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Color kactivecardcolor = Color(0xFF272B4C);
const Color kbottomcontainercolor = Colors.red;
const Color kinactivecolor = Color(0xFF111328);
double kbottomcontainerheight = 50.0;

const klabelTextstyle =TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold);
const knumberTextstyle = TextStyle(fontSize: 35,color: Colors.white,fontWeight: FontWeight.w900);
const kLargeButtonTextStyle = TextStyle(color:Colors.white,fontSize: 18, fontWeight: FontWeight.bold);

const kTitleTextStyle =TextStyle(fontSize: 20,fontWeight: FontWeight.bold);
const kresultTextStyle =TextStyle(color: Colors.green,fontSize: 22,fontWeight: FontWeight.bold,);
const kBMITextSTyle= TextStyle(color:Colors.white,fontSize: 35,fontWeight: FontWeight.bold,);
const kBodyTextStyle = TextStyle(color:Colors.white,fontSize: 22);

buildErrorDialog(
    BuildContext context, String title, String contant, VoidCallback callback) {
  Widget okButton = TextButton(
    child: Text("OK",
        style: TextStyle(
          color: Colors.black,
          decorationColor: Colors.black,
        )),
    onPressed: () {
      callback();
    },
  );

  // set up the AlertDialog

  if (Platform.isAndroid) {
    AlertDialog alert = AlertDialog(
      title: Text(title,
          style: TextStyle(
            color: Colors.black,
            decorationColor: Colors.black,
          )),
      content: Text(contant,
          style: TextStyle(
            color: Colors.black,
            decorationColor: Colors.black,
          )),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  if (Platform.isIOS) {
    CupertinoAlertDialog cupertinoAlertDialog = CupertinoAlertDialog(
      title: Text(title,
          style: TextStyle(
            color: Colors.black,
            decorationColor: Colors.black,
          )),
      content: Text(contant,
          style: TextStyle(
            color: Colors.black,
            decorationColor: Colors.black,
          )),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return cupertinoAlertDialog;
      },
    );
  }
  // show the dialog
}

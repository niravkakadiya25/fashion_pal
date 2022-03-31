import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class SendMailScreen extends StatefulWidget {

  @override
  _SendMailScreen createState() => _SendMailScreen();
}

class _SendMailScreen extends State<SendMailScreen> {
  String otp_ = "";
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(
            key: scaffoldKey,
            body:SingleChildScrollView(
              child: Container(
                  child:Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top:80,bottom: 10,right: 50,left: 50),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 30),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          child:Text( "Send Mail",
                                            style: TextStyle(  fontSize: 20, color: Colors.black),
                                          ) ,
                                        ),
                                      ],
                                    )
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 40),
                                child: DropdownSearch<String>(
                                  mode: Mode.MENU,
                                  items: ["All User","User1 ","User2"],
                                  label: "Select User",
                                  hint: "Select",
                                  // validator: (val) =>
                                  // val == null? _snackbar("Select Height Unit") : null,
                                  // onSaved: (newValue) {
                                  //   _heightUnit=newValue;
                                  // },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 15),
                                child:TextFormField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      filled: true,
                                      hintStyle: new TextStyle(color: Colors.grey),
                                      hintText: "Subject",
                                      fillColor: Colors.white),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 15),
                                child:TextFormField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      filled: true,
                                      hintStyle: new TextStyle(color: Colors.grey),
                                      hintText: "Message",
                                      fillColor: Colors.white),
                                ),
                              ),
                              Container(
                                  margin: const EdgeInsets.only(top: 40,left: 40,right: 40),
                                  child: InkWell(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: getImageAssets(),
                                    ),
                                    onTap: (){

                                    },
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            )
        )
    );
  }
}
Widget getImageAssets() {
  AssetImage assetImage = const AssetImage('images/ic_send.png');
  Image image = Image(image: assetImage, width: 100.0, height: 40.0);
  return Container(child: image);
}

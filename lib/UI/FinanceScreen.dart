import 'package:fashionpal/UI/ExpenditureScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../BouncyPageRoute.dart';
import '../colors.dart';
import 'SewingItem.dart';

class FinanceScreen extends StatefulWidget{

  _FinanceScreenState createState() => new _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:SingleChildScrollView(
          child: Container(
              child:Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top:40,bottom: 10,right: 80,left: 80),
                    child: TextFormField(
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(
                              color: appTheme,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(
                              color: appTheme,
                              width: 2.0,
                            ),
                          ),
                          hintStyle: new TextStyle(color: appTheme),
                          hintText: "  Jan 2022",
                          fillColor: Colors.white),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10,right: 5),
                        height: 100,
                          child: Image.asset("images/invoice.png",
                            fit: BoxFit.fill,
                          ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10,left: 5,right: 5),
                        height: 100,
                        child: Image.asset("images/payment.png",
                          fit: BoxFit.fill,
                          ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context,
                              BouncyPageRoute(widget: ExpenditureScreen())
                          );
                        },
                        child:  Container(
                          margin: EdgeInsets.only(top: 10,left: 5),
                          height: 100,
                          child: Image.asset("images/expediture.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      )

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10,right: 5),
                        height: 100,
                        child: Image.asset("images/full_paid.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10,left: 5,right: 5),
                        height: 100,
                        child: Image.asset("images/partial_paid.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10,left: 5),
                        height: 100,
                        child: Image.asset("images/no_payment.png",
                          fit: BoxFit.fill,
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    height: 1,
                    color: Colors.grey,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 40),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                          child: Text(
                              "c50 --",
                              style: TextStyle(fontSize: 16,color: Colors.black,

                              )
                          ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 40,top: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        child: Text(
                            "c33 --",
                            style: TextStyle(fontSize: 16,color: Colors.black,

                            )
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 40,top: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        child: Text(
                            "c16 --",
                            style: TextStyle(fontSize: 16,color: Colors.black
                            )
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 40,top: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        child: Text(
                            "c00 --",
                            style: TextStyle(fontSize: 16,color: Colors.black,
                            )
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 40,top: 20,right: 40,bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                            children: [
                              Container(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: InkWell(
                                        child: Text(
                                            "Invoice",
                                            style: TextStyle(fontSize: 16,color: Colors.black)
                                        ),
                                        onTap: (){
                                          // Navigator.push(context,
                                          //     new BouncyPageRoute(widget: Signup()));
                                        }
                                    ),
                                  )
                              ),
                              Container(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: InkWell(
                                      child: Text(
                                          "(c)",
                                          style: TextStyle(fontSize: 14)
                                      ),
                                      onTap: (){
                                        // Navigator.push(context,
                                        //     BouncyPageRoute(widget: SignUpScreen()));
                                      }
                                  ),
                                ),
                              ),
                            ]
                        ),
                        Column(
                            children: [
                              Container(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: InkWell(
                                        child: Text(
                                            "Payment",
                                            style: TextStyle(fontSize: 16,color: Colors.black)
                                        ),
                                        onTap: (){
                                          // Navigator.push(context,
                                          //     new BouncyPageRoute(widget: Signup()));
                                        }
                                    ),
                                  )
                              ),
                              Container(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: InkWell(
                                      child: Text(
                                          "(c)",
                                          style: TextStyle(fontSize: 14)
                                      ),
                                      onTap: (){
                                        // Navigator.push(context,
                                        //     BouncyPageRoute(widget: SignUpScreen()));
                                      }
                                  ),
                                ),
                              ),
                            ]
                        ),
                        Column(
                            children: [
                              Container(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: InkWell(
                                        child: Text(
                                            "Expenditure",
                                            style: TextStyle(fontSize: 16,color: Colors.black)
                                        ),
                                        onTap: (){
                                          // Navigator.push(context,
                                          //     new BouncyPageRoute(widget: Signup()));
                                        }
                                    ),
                                  )
                              ),
                              Container(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: InkWell(
                                      child: Text(
                                          "(c)",
                                          style: TextStyle(fontSize: 14)
                                      ),
                                      onTap: (){
                                        // Navigator.push(context,
                                        //     BouncyPageRoute(widget: SignUpScreen()));
                                      }
                                  ),
                                ),
                              ),
                            ]
                        ),
                      ],
                    )
                    ,
                  )
                ],
              )
          ),
        )
    );
  }

Widget getImageAssets() {
  AssetImage assetImage = AssetImage('images/logo.png');
  Image image = Image(image: assetImage, width: 100.0, height: 100.0);
  return Container(child: image);
}
}
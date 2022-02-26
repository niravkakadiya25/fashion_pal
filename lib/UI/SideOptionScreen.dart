import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class SideOptionScreen extends StatefulWidget{

  _SideOptionScreenState createState() => new _SideOptionScreenState();
}

class _SideOptionScreenState extends State<SideOptionScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:_build(context)
    );
  }


  Widget _build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 20),
          child: Form(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      Expanded(child:
                      InkWell(
                        child:  Container(
                          margin: EdgeInsets.only(top: 10,left: 2,right: 2),
                          child: Image.asset("images/home_customer.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      ),
                      SizedBox(width: 5,),
                      Expanded(child:
                      InkWell(
                        child:  Container(
                          margin: EdgeInsets.only(top: 10,left: 2,right: 2),
                          child: Image.asset("images/home_sewing.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      ),
                      SizedBox(width: 5,),
                      Expanded(child:
                      InkWell(
                        child:  Container(
                          margin: EdgeInsets.only(top: 10,left: 2,right: 2),
                          child: Image.asset("images/home_my_customer.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      Expanded(child:
                      InkWell(
                        child:  Container(
                          margin: EdgeInsets.only(top: 10,left: 2,right: 2),
                          child: Image.asset("images/home_staff.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      ),
                      SizedBox(width: 5,),
                      Expanded(child:
                      InkWell(
                        child:  Container(
                          margin: EdgeInsets.only(top: 10,left: 2,right: 2),
                          child: Image.asset("images/home_finance.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(child:
                      InkWell(
                        child:  Container(
                          margin: EdgeInsets.only(top: 10,left: 2,right: 2),
                          child: Image.asset("images/home_customer.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      Expanded(child:
                      InkWell(
                        child:  Container(
                          margin: EdgeInsets.only(top: 10,left: 2,right: 2),
                          child: Image.asset("images/home_communication.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      ),
                      SizedBox(width: 5,),
                      Expanded(child:
                      InkWell(
                        child:  Container(
                          margin: EdgeInsets.only(top: 10,left: 2,right: 2),
                          child: Image.asset("images/home_contact_us.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      ),
                      SizedBox(width: 5,),
                      Expanded(child:
                      InkWell(
                        child:  Container(
                          margin: EdgeInsets.only(top: 10,left: 2,right: 2),
                          child: Image.asset("images/home_review.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      Expanded(child:
                      InkWell(
                        child:  Container(
                          margin: EdgeInsets.only(top: 10,left: 2,right: 2),
                          child: Image.asset("images/home_my_contact.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      ),
                      SizedBox(width: 5,),
                      Expanded(child:
                      InkWell(
                        child:  Container(
                          margin: EdgeInsets.only(top: 10,left: 2,right: 2),
                          child: Image.asset("images/home_notification.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      ),
                      SizedBox(width: 5,),
                      Expanded(child:
                      InkWell(
                        child:  Container(
                          margin: EdgeInsets.only(top: 10,left: 2,right: 2),
                          child: Image.asset("images/home_setting.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

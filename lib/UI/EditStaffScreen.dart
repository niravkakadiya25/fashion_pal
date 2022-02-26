import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class EditStaffScreen extends StatefulWidget {


  @override
  _EditStaffScreenState createState() => _EditStaffScreenState();
}



class _EditStaffScreenState extends State<EditStaffScreen> {



  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: light_grey_theme,
        alignment: Alignment.center,
        child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 20,right: 20),
              height: 550,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color:Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    decoration: BoxDecoration(
                        color:Colors.blue,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 10),
                              child: Image.asset(
                                "images/back.png",
                                color: Colors.white,
                                height: 30,
                                width: 30,),
                            ),

                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Text(
                              "Edit Staff",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Image.asset("images/shop.png",
                                    height: 20,
                                    width: 20,),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Image.asset("images/shop.png",
                                    height: 20,
                                    width: 20,),
                                ),
                              ],
                            ),
                          ),
                        )



                      ],

                    ),
                  ),
                  Expanded(
                      child:Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(left: 20,right: 20),
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                "Edit Staff Details",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(top: 10),
                              height: 50,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.red),
                                          ),
                                          hintText: 'First Name',
                                        ),
                                      ),

                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(left: 10),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.red),
                                          ),
                                          hintText: 'Surname',
                                        ),
                                      ),

                                    ),
                                  )

                                ],

                              ),
                            ),

                            Container(
                              height: 50,
                              margin: EdgeInsets.only(top: 10),
                              child: TextField(
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  hintText: "Email Address",
                                ),
                              ),
                            ),

                            Container(
                              height: 50,
                              margin: EdgeInsets.only(top: 10),
                              child: TextField(
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  hintText: "Tel",
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(top: 10),
                              height: 50,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.red),
                                          ),
                                          hintText: "Date Of Birth",
                                        ),
                                      ),

                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(left: 10),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.red),
                                          ),
                                          hintText: "Sex",
                                        ),
                                      ),

                                    ),
                                  )

                                ],

                              ),
                            ),

                            Container(
                              height: 50,
                              margin: EdgeInsets.only(top: 10),
                              child: TextField(
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  hintText: "Complete Address",
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(top: 10),
                              height: 50,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.red),
                                          ),
                                          hintText: "Country",
                                        ),
                                      ),

                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(left: 10),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.red),
                                          ),
                                          hintText: "Region",
                                        ),
                                      ),

                                    ),
                                  )

                                ],

                              ),
                            ),

                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(top: 10),
                              height: 50,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.red),
                                          ),
                                          hintText: "City",
                                        ),
                                      ),

                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10),
                                      padding: EdgeInsets.only(left: 10),
                                      child: Image.asset(
                                        "images/add_staff.png",
                                        height: 40,
                                        width: 40,),
                                    ),
                                  )
                                ],

                              ),
                            ),
                          ],
                        ),
                      )

                  )
                ],
              ),
            )
        ),
      ),

    );
  }
}
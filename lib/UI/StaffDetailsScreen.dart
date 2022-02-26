import 'package:fashionpal/UI/EditStaffScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../BouncyPageRoute.dart';
import '../colors.dart';
import 'EditCustomer.dart';

class StaffDetailsScreen extends StatefulWidget {


  @override
  _StaffDetailsScreenState createState() => _StaffDetailsScreenState();
}


class _StaffDetailsScreenState extends State<StaffDetailsScreen> {


  @override
  void initState() {
    super.initState();


  }

  Future<void> getData() async {
    // Get docs from collection reference
    // Stream<QuerySnapshot<Map<String, dynamic>>> snapshot = FirebaseFirestore.instance.collection('customers').where("ownerId",isEqualTo: "qxYhuT2B0tbZ51gYOMJGtfsArt02").snapshots();
    //
    // print(snapshot);

    // final QuerySnapshot<Map<String, dynamic>> documentSnapshot = await collection.where("ownerId",isEqualTo: "qxYhuT2B0tbZ51gYOMJGtfsArt02").get();
    //
    // print(documentSnapshot.docs.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: light_grey_theme,
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.only(left: 20,right: 20),
          height: 400,
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
                          "Staff Detail",
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
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context,
                                BouncyPageRoute(widget: EditStaffScreen())
                            );
                          },
                          child: Container(
                            child: Image.asset("images/ic_edit.png",
                              color: Colors.white,
                              height: 20,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],

                ),
              ),
              Expanded(
                  child:Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(left: 20,right: 20,top: 20),
                    child: Column(
                      children: [
                        Text(
                          "Opkum",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                    "Role :",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Apprentice",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),

                                ),
                              )

                            ],

                          ),
                        ),


                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                    "Contact :",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "0123456789",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),

                                ),
                              )

                            ],

                          ),
                        ),


                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                    "Email :",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "fashion@gmail.com",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),

                                ),
                              )

                            ],

                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                    "Gender :",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Male",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),

                                ),
                              )

                            ],

                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                    "Birthday :",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "12 May 1984",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),

                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                    "City :",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "ghana",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),

                                ),
                              )

                            ],

                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                    "Stata :",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Ghana",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),

                                ),
                              )

                            ],

                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                    "Country :",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Ghana",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),

                                ),
                              )

                            ],

                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                    "Address :",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "West",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),

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
        ),
      ),

    );
  }
}
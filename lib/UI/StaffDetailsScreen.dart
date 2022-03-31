import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fashionpal/UI/EditStaffScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../BouncyPageRoute.dart';
import '../colors.dart';
import 'AddStaff.dart';
import 'EditCustomer.dart';

class StaffDetailsScreen extends StatefulWidget {
  final DocumentSnapshot? documentFields;
  final String? staffId;

  const StaffDetailsScreen({Key? key, this.documentFields, this.staffId})
      : super(key: key);

  @override
  _StaffDetailsScreenState createState() => _StaffDetailsScreenState();
}

class _StaffDetailsScreenState extends State<StaffDetailsScreen> {
  TextEditingController fname = TextEditingController();
  TextEditingController surnamename = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController telnumber = TextEditingController();
  TextEditingController DOB = TextEditingController();
  TextEditingController sex = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController region = TextEditingController();
  TextEditingController city = TextEditingController();
  DateTime selectedDOBDate = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  CollectionReference users = FirebaseFirestore.instance.collection('staff');

  @override
  void initState() {
    super.initState();
    fname = TextEditingController(
        text: (widget.documentFields?.data() as Map)['staffData']["firstName"]);
    surnamename = TextEditingController(
        text: (widget.documentFields?.data() as Map)['staffData']["lastName"]);
    email = TextEditingController(
        text: (widget.documentFields?.data() as Map)['staffData']["email"]);
    telnumber = TextEditingController(
        text: (widget.documentFields?.data() as Map)['staffData']
            ["phoneNumber"]);
    // _controllerDOB = TextEditingController(text:  widget.documentFields!["birthday"].toString());
    sex = TextEditingController(
        text: (widget.documentFields?.data() as Map)['staffData']["sex"]);
    address = TextEditingController(
        text: (widget.documentFields?.data() as Map)['staffData']["address"]);
    country = TextEditingController(
        text: (widget.documentFields?.data() as Map)['staffData']["country"]);
    region = TextEditingController(
        text: (widget.documentFields?.data() as Map)['staffData']["firstName"]);
    city = TextEditingController(
        text: (widget.documentFields?.data() as Map)['staffData']["city"]);
    DOB = TextEditingController(
        text: (widget.documentFields?.data() as Map)['staffData']["birthday"]);
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
          margin: EdgeInsets.only(left: 20, right: 20),
          height: 600,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Image.asset(
                            "images/back.png",
                            color: Colors.white,
                            height: 30,
                            width: 30,
                          ),
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
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                new BouncyPageRoute(
                                    widget: AddStaff(
                                  isEdit: true,
                                  documentFields: widget.documentFields,
                                  staffId: (widget.documentFields?.data()
                                      as Map)['staffId'],
                                )));
                          },
                          child: Container(
                            child: Image.asset(
                              "images/ic_edit.png",
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
                  child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 10),
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: TextField(
                                controller: fname,
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
                                controller: surnamename,
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
                        controller: email,
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
                        controller: telnumber,
                        keyboardType: TextInputType.phone,
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
                                controller: DOB,
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
                              child: DropdownSearch<String>(
                                mode: Mode.MENU,
                                items: ["Male", "Female", "Other"],
                                label: "Select Sex",
                                hint: "Sex",
                                selectedItem: sex.text,
                                onChanged: (value) {
                                  sex.text = value!;
                                },
                                // validator: (val) =>
                                // val == null? _snackbar("Select Height Unit") : null,
                                // onSaved: (newValue) {
                                //   _heightUnit=newValue;
                                // },
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
                        controller: address,
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
                                controller: country,
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
                                controller: region,
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
                        ],
                      ),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

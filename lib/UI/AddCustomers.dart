import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fashionpal/Utils/ProgressDialog.dart';
import 'package:fashionpal/Utils/constants.dart';
import 'package:fashionpal/Utils/sharPreference.dart';
import 'package:fashionpal/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../main.dart';

class AddCustomer extends StatefulWidget {
  final bool isEdit;
  final Map<String, dynamic>? documentFields;
  final String? customerId;

  const AddCustomer(
      {Key? key, this.isEdit = false, this.documentFields, this.customerId})
      : super(key: key);

  @override
  _AddCustomerState createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
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
  CollectionReference users =
      FirebaseFirestore.instance.collection('customers');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDOBDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDOBDate)
      setState(() {
        selectedDOBDate = picked;
        DOB.text = formatter.format(selectedDOBDate).toString();
      });
  }

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      fname = TextEditingController(text: widget.documentFields!["firstName"]);
      surnamename =
          TextEditingController(text: widget.documentFields!["lastName"]);
      email = TextEditingController(text: widget.documentFields!["email"]);
      telnumber =
          TextEditingController(text: widget.documentFields!["phoneNumber"]);
      // _controllerDOB = TextEditingController(text:  widget.documentFields!["birthday"].toString());
      sex = TextEditingController(text: widget.documentFields!["sex"]);
      address = TextEditingController(text: widget.documentFields!["address"]);
      country = TextEditingController(text: widget.documentFields!["country"]);
      region = TextEditingController(text: widget.documentFields!["firstName"]);
      city = TextEditingController(text: widget.documentFields!["city"]);
      DOB = TextEditingController(text: widget.documentFields!["birthday"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: light_grey_theme,
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          height: 550,
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
                          "${widget.isEdit ? 'Edit' : 'Add'} Customer",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Image.asset(
                                "images/shop.png",
                                height: 20,
                                width: 20,
                              ),
                            ),
                            Container(
                              child: Text(
                                "Load from contact",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        "${widget.isEdit ? 'Edit' : 'Add'} Customer's Details",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
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
                                onTap: () => _selectDate(context),
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
                                showSelectedItem: false,
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
                                controller: city,
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
                            child: GestureDetector(
                              onTap: () async {
                                if (fname.text.isEmpty) {
                                  buildErrorDialog(
                                      context, '', 'Please Enter first Name',
                                      () {
                                    Navigator.pop(context);
                                  });
                                } else {
                                  ProgressDialog.showLoaderDialog(context);

                                  var ownerId = (await getOwnerId());
                                  Map map = {
                                    'address': address.text.trim(),
                                    'birthday': DOB.text.trim(),
                                    'city': city.text.trim(),
                                    'country': country.text.trim(),
                                    'createdAt': DateTime.now(),
                                    'email': email.text.trim(),
                                    'firstName': fname.text.trim(),
                                    'lastName': surnamename.text.trim(),
                                    'phoneNumber': telnumber.text.trim(),
                                    'searchMatch': fname.text.trim(),
                                    'sex': sex.text.trim(),
                                  };

                                  DocumentReference documentReference =
                                      FirebaseFirestore.instance
                                          .collection('customers')
                                          .doc();

                                  await FirebaseFirestore.instance
                                      .collection('customers')
                                      .doc(widget.isEdit
                                          ? ownerId + '_' + widget.customerId
                                          : ownerId +
                                              '_' +
                                              documentReference.id)
                                      .set({
                                    'customerData': map,
                                    'customerId': widget.isEdit
                                        ? widget.customerId
                                        : documentReference.id,
                                    'ownerId': ownerId.toString(),
                                  }, SetOptions(merge: true));
                                  Navigator.of(context)
                                      .popUntil((route) => route.isFirst);
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                padding: EdgeInsets.only(left: 10),
                                child: Image.asset(
                                  widget.isEdit
                                      ? "images/addcustomer.png"
                                      : "images/addcustomer.png",
                                  height: 40,
                                  width: 40,
                                ),
                              ),
                            ),
                          )
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

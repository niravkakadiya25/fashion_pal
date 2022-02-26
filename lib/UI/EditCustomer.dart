import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionpal/Utils/sharPreference.dart';
import 'package:fashionpal/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditCustomer extends StatefulWidget {
  Map<String, dynamic>? documentFields;
  String? customerId;

  EditCustomer(this.documentFields, this.customerId);

  @override
  _EditCustomerState createState() => _EditCustomerState();
}

class _EditCustomerState extends State<EditCustomer> {
  TextEditingController? _controllerFirst;
  TextEditingController? _controllerLast;
  TextEditingController? _controllerEmail;
  TextEditingController? _controllerPhone;
  TextEditingController? _controllerDOB;
  TextEditingController? _controllerSex;
  TextEditingController? _controllerAddress;
  TextEditingController? _controllerCountry;
  TextEditingController? _controllerRegion;
  TextEditingController? _controllerCity;
  CollectionReference users =
      FirebaseFirestore.instance.collection('customers');

  late String _nameFirst;
  late String _nameLast;
  late String _email;
  late String _phone;
  late String _dob;
  late String _sex;
  late String _address;
  late String _country;
  late String _region;
  late String _city;
  late String _userId;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    getOwnerId().then((value) {
      _userId = value.toString();
    });
    _controllerFirst =
        TextEditingController(text: widget.documentFields!["firstName"]);
    _controllerLast =
        TextEditingController(text: widget.documentFields!["lastName"]);
    _controllerEmail =
        TextEditingController(text: widget.documentFields!["email"]);
    _controllerPhone =
        TextEditingController(text: widget.documentFields!["phoneNumber"]);
    // _controllerDOB = TextEditingController(text:  widget.documentFields!["birthday"].toString());
    _controllerSex = TextEditingController(text: widget.documentFields!["sex"]);
    _controllerAddress =
        TextEditingController(text: widget.documentFields!["address"]);
    _controllerCountry =
        TextEditingController(text: widget.documentFields!["country"]);
    _controllerRegion =
        TextEditingController(text: widget.documentFields!["firstName"]);
    _controllerCity =
        TextEditingController(text: widget.documentFields!["city"]);
    _controllerDOB =
        TextEditingController(text: widget.documentFields!["birthday"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        color: light_grey_theme,
        alignment: Alignment.center,
        child: SingleChildScrollView(
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
                          "Edit Customer",
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
                        child: Row(
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
                              margin: EdgeInsets.only(left: 20),
                              child: Image.asset(
                                "images/shop.png",
                                height: 20,
                                width: 20,
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
                child: Form(
                    key: formKey,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              "Edit Customer's Details",
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
                                    child: TextFormField(
                                      controller: _controllerFirst,
                                      decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                        ),
                                        hintText: 'First Name',
                                      ),
                                      onSaved: (val) => _nameFirst = val!,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: TextFormField(
                                      controller: _controllerLast,
                                      decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                        ),
                                        hintText: 'Surname',
                                      ),
                                      onSaved: (val) => _nameLast = val!,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            margin: EdgeInsets.only(top: 10),
                            child: TextFormField(
                              controller: _controllerEmail,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                hintText: "Email Address",
                              ),
                              onSaved: (val) => _email = val!,
                            ),
                          ),
                          Container(
                            height: 50,
                            margin: EdgeInsets.only(top: 10),
                            child: TextFormField(
                              controller: _controllerPhone,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                hintText: "Tel",
                              ),
                              onSaved: (val) => _phone = val!,
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
                                    child: TextFormField(
                                      controller: _controllerDOB,
                                      decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                        ),
                                        hintText: "Date Of Birth",
                                      ),
                                      onSaved: (val) => _dob = val!,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: TextFormField(
                                      controller: _controllerSex,
                                      decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                        ),
                                        hintText: "Sex",
                                      ),
                                      onSaved: (val) => _sex = val!,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            margin: EdgeInsets.only(top: 10),
                            child: TextFormField(
                              controller: _controllerAddress,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                hintText: "Complete Address",
                              ),
                              onSaved: (val) => _address = val!,
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
                                    child: TextFormField(
                                      controller: _controllerCountry,
                                      decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                        ),
                                        hintText: "Country",
                                      ),
                                      onSaved: (val) => _country = val!,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: TextFormField(
                                      controller: _controllerRegion,
                                      decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                        ),
                                        hintText: "Region",
                                      ),
                                      onSaved: (val) => _region = val!,
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
                                    child: TextFormField(
                                      controller: _controllerCity,
                                      decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                        ),
                                        hintText: "City",
                                      ),
                                      onSaved: (val) => _city = val!,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10),
                                      padding: EdgeInsets.only(left: 10),
                                      child: Image.asset(
                                        "images/addcustomer.png",
                                        height: 40,
                                        width: 40,
                                      ),
                                    ),
                                    onTap: () {
                                      final form = formKey.currentState;
                                      if (form!.validate()) {
                                        form.save();
                                        // signIn();
                                        addUser2();
                                        // print(_userId);

                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              )
            ],
          ),
        )),
      ),
    );
  }

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'full_name': "n", // John Doe
          'company': "company", // Stokes and Sons
          'age': "age" // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> addUser2() {
    Map map = {
      'address': _address,
      'birthday': _dob.trim(),
      'city': _city.trim(),
      'country': _country.trim(),
      'createdAt': DateTime.now(),
      'email': _email.trim(),
      'firstName': _nameFirst.trim(),
      'lastName': _nameLast.trim(),
      'phoneNumber': _phone.trim(),
      'searchMatch': _nameFirst.trim(),
      'sex': _sex.trim(),
    };

    print(widget.customerId);
    return users
        .doc(widget.customerId)
        .set({
          'customerData': map,
        }, SetOptions(merge: true))
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}

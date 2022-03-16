import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fashionpal/Utils/ProgressDialog.dart';
import 'package:fashionpal/Utils/sharPreference.dart';
import 'package:fashionpal/colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditProfileScreen extends StatefulWidget {
  final DocumentSnapshot? documentSnapshot;

  const EditProfileScreen({Key? key, this.documentSnapshot}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  DateTime selectedDate = DateTime.now();
  String? date;
  TextEditingController _dateController = TextEditingController();
  TextEditingController _companyNameController = TextEditingController();

  TextEditingController _fNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _stateController = TextEditingController();

  @override
  void initState() {
    _fNameController.text =
        (widget.documentSnapshot?.data() as Map)['firstName'] ?? '';
    _lastNameController.text =
        (widget.documentSnapshot?.data() as Map)['lastName'] ?? '';
    _emailController.text =
        (widget.documentSnapshot?.data() as Map)['email'] ?? '';
    _phoneNumberController.text =
        (widget.documentSnapshot?.data() as Map)['phoneNumber'] ?? '';
    _addressController.text =
        (widget.documentSnapshot?.data() as Map)['address'] ?? '';
    _cityController.text =
        (widget.documentSnapshot?.data() as Map)['city'] ?? '';
    _companyNameController.text =
        (widget.documentSnapshot?.data() as Map)['companyName'] ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
              centerTitle: true,
              title: Text(
                "Update Profile",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              backgroundColor: appTheme,
            )),
        body: _build(context));
  }

  // _BuildBody(BuildContext context) {
  //   return FutureBuilder<SignupDataBeanModel>(
  //       future: myFuture,
  //       builder: (context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.done) {
  //           if (snapshot.hasError) {
  //             return Center(
  //               child: Text(
  //                 snapshot.error.toString(),
  //                 textAlign: TextAlign.center,
  //                 textScaleFactor: 1.3,
  //               ),
  //             );
  //           }
  //           final data = snapshot.data;
  //           return _build(context,data);
  //         } else {
  //           return Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         }
  //       });
  // }
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: new DateTime.now().add(Duration(days: -0)),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
        date = DateFormat.yMd().format(selectedDate);
      });
  }

  Widget _build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Container(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
          child: Form(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: GestureDetector(
                    onTap: () {
                      _showChoiceDialog(context);
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: white_theme,
                      child: getImageWidget(),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      height: 50,
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        child: TextFormField(
                          controller: _companyNameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              filled: true,
                              hintStyle: new TextStyle(color: Colors.grey),
                              hintText: "Company Name",
                              fillColor: Colors.white),
                        ),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: TextFormField(
                            controller: _fNameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                filled: true,
                                hintStyle: new TextStyle(color: Colors.grey),
                                hintText: "Fist Name",
                                fillColor: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          child: TextFormField(
                            controller: _lastNameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                filled: true,
                                hintStyle: new TextStyle(color: Colors.grey),
                                hintText: "Last Name",
                                fillColor: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      height: 50,
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              filled: true,
                              hintStyle: new TextStyle(color: Colors.grey),
                              hintText: "Email Address",
                              fillColor: Colors.white),
                        ),
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      height: 50,
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        child: TextFormField(
                          controller: _phoneNumberController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              filled: true,
                              hintStyle: new TextStyle(color: Colors.grey),
                              hintText: "Phone number",
                              fillColor: Colors.white),
                        ),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 15),
                          child: TextFormField(
                            onTap: () {
                              _selectDate(context);
                            },
                            keyboardType: TextInputType.text,
                            controller: _dateController,
                            autofocus: false,
                            decoration: InputDecoration(
                                filled: true,
                                hintStyle: new TextStyle(color: Colors.grey),
                                hintText: "Date of Birth",
                                fillColor: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 15),
                          child: DropdownSearch<String>(
                            mode: Mode.MENU,
                            showSelectedItem: false,
                            items: ["Male", "Female ", "Other"],
                            label: "Select Gender",
                            hint: "Select",
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
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    margin: EdgeInsets.only(top: 15),
                    child: TextFormField(
                      controller: _addressController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          filled: true,
                          hintStyle: new TextStyle(color: Colors.grey),
                          hintText: "Complete Address",
                          fillColor: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CSCPicker(
                    stateDropdownLabel: _stateController.text.isEmpty
                        ? 'State'
                        : _stateController.text,
                    countryDropdownLabel: _countryController.text.isEmpty
                        ? 'Country'
                        : _countryController.text,
                    layout: Layout.vertical,
                    onCountryChanged: (value) {
                      setState(() {
                        // countryValue = value;
                        _countryController.text = value;
                      });
                    },
                    onStateChanged: (value) {
                      setState(() {
                        _stateController.text = value.toString();
                        // stateValue = value;
                      });
                    },
                    onCityChanged: (value) {
                      setState(() {
                        _cityController.text = value.toString();
                        // cityValue = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: appTheme,
                      height: 40,
                      child: const Text(
                        'Update',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(widget.documentSnapshot?.id)
                            .set({
                          'firstName': _fNameController.text.trim(),
                          'lastName': _lastNameController.text.trim(),
                          'phoneNumber': _phoneNumberController.text.trim(),
                          'address': _addressController.text.trim(),
                          'city': _cityController.text.trim(),
                          'country': _countryController.text.trim(),
                          'state': _stateController.text.trim(),
                          'companyName': _companyNameController.text.trim(),
                          'updateAt': DateTime.now(),
                          'dateOfBirth': date ?? '',
                          'profileImage': profileUrl ?? '',
                        }, SetOptions(merge: true));
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext contexts) {
          return AlertDialog(
            title: Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      _openGallery(context);
                    },
                    title: Text("Gallery"),
                    leading: Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);

                      _openCamera(context);
                    },
                    title: Text("Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  PickedFile? imageFile = null;

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile = pickedFile!;
    });
    if (imageFile != null) {
      ProgressDialog.showLoaderDialog(context);
      uploadImageToFirebase(context, File(imageFile!.path));
    }
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile!;
    });
    if (imageFile != null) {
      ProgressDialog.showLoaderDialog(context);
      uploadImageToFirebase(context, File(imageFile!.path));
    }
  }

  String? profileUrl;

  Future uploadImageToFirebase(BuildContext context, File _imageFile) async {
    var firebaseStorageRef = FirebaseStorage.instance.ref().child(
        'uploads/${await getOwnerId()}_${DateTime.now().microsecondsSinceEpoch.toString()}.png');

    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL().then(
      (value) {
        profileUrl = value;
        if (kDebugMode) {
          print("Done: $value");
        }
        ProgressDialog.dismissDialog(context);
      },
    ).catchError((onError) {
      ProgressDialog.dismissDialog(context);
    });
  }

  Widget getImageWidget() {
    return Image.asset('images/huser.png');
  }
}

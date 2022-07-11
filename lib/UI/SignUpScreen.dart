import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:fashionpal/UI/privacy_policy.dart';
import 'package:fashionpal/Utils/ProgressDialog.dart';
import 'package:fashionpal/Utils/constants.dart';
import 'package:fashionpal/Utils/sent-otp.dart';
import 'package:fashionpal/Utils/sharPreference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../colors.dart';

TextEditingController mobileNumberController = new TextEditingController();
TextEditingController password = TextEditingController();

class SignUpScreen extends StatefulWidget {
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  bool _obscureText = true;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController logo = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController region = TextEditingController();
  TextEditingController city = TextEditingController();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Stack(
      children: <Widget>[
        Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 30, left: 20),
                    padding: EdgeInsets.all(10.0),
                    child: InkWell(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Image.asset(
                            'images/back.png',
                            width: 30,
                            height: 30,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop(true);
                        })),
                Align(
                    alignment: Alignment.bottomCenter, child: getImageAssets()),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          InkWell(
                            child: Text(
                              "CREATE ",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                          InkWell(
                            child: Text(
                              "ACCOUNT",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )),
                ),
                Container(
                  padding:
                      EdgeInsets.only(top: 40, bottom: 10, right: 50, left: 50),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: firstName,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please Enter FirstName';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.white),
                              hintText: "First name",
                              fillColor: appTheme),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                          ),
                        ),
                        TextFormField(
                          controller: lastName,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please Enter LastName';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.white),
                              hintText: "Last name",
                              fillColor: appTheme),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please Enter Mobile Number';
                            }
                            return null;
                          },
                          controller: mobileNumberController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.white),
                              hintText: "Phone Number",
                              fillColor: appTheme),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please Enter Password';
                            }
                            return null;
                          },
                          controller: password,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    _obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.white),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.white),
                              hintText: "Password",
                              fillColor: appTheme),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                          ),
                        ),
                        TextFormField(
                          controller: confirmPassword,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please Enter Confirm Password';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    _obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.white),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              filled: true,
                              hintStyle: new TextStyle(color: Colors.white),
                              hintText: "Confirm password",
                              fillColor: appTheme),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please Enter Company Name';
                            }
                            return null;
                          },
                          controller: companyName,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.white),
                              hintText: "Company name",
                              fillColor: appTheme),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please Enter Address';
                            }
                            return null;
                          },
                          controller: address,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.white),
                              hintText: "Address",
                              fillColor: appTheme),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          onTap: () {
                            _showChoiceDialog(context);
                          },
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    Icons.upload,
                                    color: Colors.white),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                },
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.white),
                              hintText: "Upload Logo",
                              fillColor: appTheme),
                        ),
                        CSCPicker(
                          stateDropdownLabel:
                              region.text.isEmpty ? 'State' : region.text,
                          countryDropdownLabel:
                              country.text.isEmpty ? 'Country' : country.text,
                          onCountryChanged: (value) {
                            setState(() {
                              // countryValue = value;
                              country.text = value;
                            });
                          },
                          onStateChanged: (value) {
                            setState(() {
                              region.text = value.toString();
                              // stateValue = value;
                            });
                          },
                          onCityChanged: (value) {
                            setState(() {
                              city.text = value.toString();
                              // cityValue = value;
                            });
                          },
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 20, left: 20),
                            padding: EdgeInsets.all(10.0),
                            child: InkWell(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    'images/sign_up.png',
                                    width: 60,
                                    height: 60,
                                  ),
                                ),
                                onTap: () async {
                                  if (password.text.length < 6) {
                                    buildErrorDialog(context, '',
                                        'Please Add password more then 6 characters',
                                        () {
                                      Navigator.pop(context);
                                    });
                                  } else if (formKey.currentState?.validate() ??
                                      false) {
                                    if (isChecked) {
                                      ProgressDialog.showLoaderDialog(context);
                                      submitPhoneNumber(mobileNumberController,
                                          context, false, true,
                                          map: {
                                            'firstName': firstName.text.trim(),
                                            'lastName': lastName.text.trim(),
                                            'phoneNumber':
                                                mobileNumberController.text
                                                    .trim(),
                                            'companyName':
                                                companyName.text.trim(),
                                            'address': address.text.trim(),
                                            'logo': logoUrl,
                                            'isEnabled': true,
                                            'role': 'owner',
                                            'customersCount': 0,
                                            'searchMatch': companyName.text
                                                .toString()
                                                .replaceAll(' ', '')
                                                .toLowerCase()
                                                .toString(),
                                            'createdAt': DateTime.now(),
                                            'profileImage': '',
                                            'sewingsCount': 0,
                                            'totalExpenditure': 0,
                                            'staffCount': 0,
                                            'totalIncome': 0,
                                            'senderId': 'fashionspal',
                                            'city': city.text.trim(),
                                            'country': country.text.trim(),
                                            'state': region.text.trim(),
                                          });
                                      // Navigator.of(context).pop(true);
                                    } else {
                                      buildErrorDialog(context, '',
                                          'Please read and accept privacy policy',
                                          () {
                                        Navigator.pop(context);
                                      });
                                    }
                                  }
                                })),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.greenAccent,
                              activeColor: Colors.red,
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                            ),
                            Flexible(
                                child: privacyPolicyLinkAndTermsOfService()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ],
    )));
  }

  Widget privacyPolicyLinkAndTermsOfService() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Center(
          child: Text.rich(TextSpan(
              text: 'By continuing, you agree to our ',
              style: TextStyle(fontSize: 16, color: Colors.black),
              children: <TextSpan>[
            TextSpan(
                text: 'Terms of Service',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrivacyPolicy(),
                        ));
                    // code to open / launch ter  ms of service link here
                  }),
            TextSpan(
                text: ' and ',
                style: TextStyle(fontSize: 18, color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PrivacyPolicy(),
                              ));
                          // code to open / launch privacy policy link here
                        })
                ])
          ]))),
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

  String? logoUrl = '';

  Future uploadImageToFirebase(BuildContext context, File _imageFile) async {
    var firebaseStorageRef = FirebaseStorage.instance.ref().child(
        'uploads/${await getOwnerId()}_${DateTime.now().microsecondsSinceEpoch.toString()}.png');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL().then(
      (value) {
        logoUrl = value;
        if (kDebugMode) {
          print("Done: $value");
        }
        ProgressDialog.dismissDialog(context);
      },
    ).catchError((onError) {
      ProgressDialog.dismissDialog(context);
    });
  }

  Widget getImageAssets() {
    AssetImage assetImage = const AssetImage('images/logo.png');
    Image image = Image(image: assetImage, width: 120.0, height: 110.0);
    return Container(child: image);
  }
}

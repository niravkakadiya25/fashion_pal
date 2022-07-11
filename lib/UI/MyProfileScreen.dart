import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionpal/UI/EditCompanyProfileScreen.dart';
import 'package:fashionpal/UI/EditProfileScreen.dart';
import 'package:fashionpal/UI/update_password.dart';
import 'package:fashionpal/Utils/ProgressDialog.dart';
import 'package:fashionpal/Utils/sharPreference.dart';
import 'package:fashionpal/colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../BouncyPageRoute.dart';

class MyProfileScreen extends StatefulWidget {
  _MyProfileScreenState createState() => new _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  bool isLoading = true;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  DocumentSnapshot? documentSnapshot;

  getUserData() async {
    String ownerId = await getOwnerId();
    print(ownerId);
    documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(ownerId).get();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: InkWell(
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.pop(context);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context)=>EditMyProfile())
                // );
              },
            ),
          ),
          centerTitle: true,
          title: Text(
            "My Profile",
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: appTheme,
          // actions: <Widget>[
          //   Builder(
          //     builder: (context){
          //       return Padding(
          //         padding: const EdgeInsets.only(right: 20),
          //         child: InkWell(
          //           child: Icon(Icons.edit,
          //             color: Colors.white,),
          //           onTap:() {
          //             // Navigator.push(context,
          //             //     MaterialPageRoute(builder: (context)=>EditMyProfile())
          //             // );
          //           },
          //         ),
          //       );
          //     },
          //   )
          // ],
        ),
      ),
      body: isLoading ? Container() : _build(context),
    );
  }

  // _BuildBody(BuildContext context) {
  //   return FutureBuilder<ProfileBeanModel>(
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
  //           // setState(() {
  //           //   textHolder = data.data.title.toString();
  //           // });
  //           return _build(context,snapshot.data);
  //         } else {
  //           return Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         }
  //       });
  // }

  Widget _build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            // Container(
            //   alignment: Alignment.center,
            //   height: 150,
            //   color: Colors.grey[100],
            //   child:InkWell(
            //     child: CircleAvatar(
            //       radius: 60,
            //       backgroundColor: white_theme,
            //       child:getImageWidget(),
            //     ),
            //     onTap: (){
            //
            //     },
            //   ),
            // ),
            // Divider(
            //   height: 1,
            //   color: Colors.grey,
            // ),
            Container(
              alignment: Alignment.center,
              color: Colors.grey[100],
              child: Container(
                margin:
                    EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10, left: 30),
                        child: InkWell(
                          child: Text(
                            "Company Details",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: white_theme,
                              child: GestureDetector(
                                  onTap: () {
                                    _showChoiceDialog(context);
                                  },
                                  child: (documentSnapshot?.data()
                                              as Map)['profileImage'] ==
                                          null
                                      ? getImageWidget()
                                      : (documentSnapshot?.data()
                                                  as Map)['profileImage']
                                              .toString()
                                              .isNotEmpty
                                          ? Image.network(
                                              (documentSnapshot?.data()
                                                      as Map)['profileImage']
                                                  .toString())
                                          : getImageWidget()),
                            ),
                          ),
                          Divider(
                            thickness: 2,
                            color: appTheme,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    "Company Name",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    "Address",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    "Phone number",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    (documentSnapshot?.data()
                                            as Map)['companyName']
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    (documentSnapshot?.data() as Map)['address']
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    (documentSnapshot?.data()
                                            as Map)['phoneNumber']
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, left: 30),
                        child: InkWell(
                          child: Text(
                            "Owners informations",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15, left: 30, right: 30, bottom: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    "First Name",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    "Last Name",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    "Phone number",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    "Email",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    "Address",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    "Country",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    "State/Region",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    "City",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    (documentSnapshot?.data()
                                            as Map)['firstName']
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    (documentSnapshot?.data()
                                            as Map)['lastName']
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    (documentSnapshot?.data()
                                            as Map)['phoneNumber']
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    (documentSnapshot?.data() as Map)['email']
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    (documentSnapshot?.data() as Map)['address']
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    (documentSnapshot?.data() as Map)['country']
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    (documentSnapshot?.data() as Map)['state']
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    (documentSnapshot?.data() as Map)['city']
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20, right: 10),
                            height: 40,
                            child: RaisedButton(
                              child: Center(
                                child: Text(
                                  "Update Profile",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              onPressed: () async {
                                await Navigator.push(
                                    context,
                                    BouncyPageRoute(
                                        widget: EditProfileScreen(
                                      documentSnapshot: documentSnapshot,
                                    )));
                                getUserData();
                              },
                              color: appTheme,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                          // Container(
                          //   margin: EdgeInsets.only(top: 20, left: 10),
                          //   height: 40,
                          //   child: RaisedButton(
                          //     child: Center(
                          //       child: Text(
                          //         "Update Company",
                          //         style: TextStyle(
                          //             fontSize: 14,
                          //             color: Colors.white,
                          //             fontWeight: FontWeight.bold),
                          //       ),
                          //     ),
                          //     onPressed: () {
                          //       Navigator.push(
                          //           context,
                          //           BouncyPageRoute(
                          //               widget: EditCompanyProfileScreen()));
                          //     },
                          //     color: appTheme,
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(30.0),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20, right: 10),
                            height: 40,
                            child: RaisedButton(
                              child: Center(
                                child: Text(
                                  "Update Password",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              onPressed: () async {
                                await Navigator.push(context,
                                    BouncyPageRoute(widget: const UpdatePassword()));
                              },
                              color: appTheme,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                          // Container(
                          //   margin: EdgeInsets.only(top: 20, left: 10),
                          //   height: 40,
                          //   child: RaisedButton(
                          //     child: Center(
                          //       child: Text(
                          //         "Update Company",
                          //         style: TextStyle(
                          //             fontSize: 14,
                          //             color: Colors.white,
                          //             fontWeight: FontWeight.bold),
                          //       ),
                          //     ),
                          //     onPressed: () {
                          //       Navigator.push(
                          //           context,
                          //           BouncyPageRoute(
                          //               widget: EditCompanyProfileScreen()));
                          //     },
                          //     color: appTheme,
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(30.0),
                          //     ),
                          //   ),
                          // ),
                        ],
                      )
                    ]),
              ),
            ),
          ],
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

  String? logoUrl;

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

  Widget getImageWidget() {
    return Image.asset('images/huser.png');
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionpal/UI/EditCompanyProfileScreen.dart';
import 'package:fashionpal/UI/EditProfileScreen.dart';
import 'package:fashionpal/Utils/sharPreference.dart';
import 'package:fashionpal/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            centerTitle: true,
            title: Text(
              "My Profile",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
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
          )),
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
            Container(
              padding:
                  EdgeInsets.only(top: 30, bottom: 30, left: 40, right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: white_theme,
                      child: (documentSnapshot?.data()
                                  as Map)['profileImage'] ==
                              null
                          ? getImageWidget()
                          : (documentSnapshot?.data() as Map)['profileImage']
                                  .toString()
                                  .isNotEmpty
                              ? Image.network((documentSnapshot?.data()
                                      as Map)['profileImage']
                                  .toString())
                              : getImageWidget(),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: appTheme,
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
                            "Email",
                            style: TextStyle(
                                color: appTheme,
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 3),
                          child: Text(
                            "Website",
                            style: TextStyle(
                                fontSize: 14,
                                color: appTheme,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 3),
                          child: Text(
                            "Contact",
                            style: TextStyle(
                                color: appTheme,
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 3),
                          child: Text(
                            "City",
                            style: TextStyle(
                                color: appTheme,
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 3),
                          child: Text(
                            "Region",
                            style: TextStyle(
                                fontSize: 14,
                                color: appTheme,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 3),
                          child: Text(
                            "Country",
                            style: TextStyle(
                                color: appTheme,
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
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
                              child: getImageWidget(),
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
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    "Company Name",
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
                                    "Lorem Ipsum",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    "Lorem Ipsum",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    "Lorem Ipsum ",
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
                          Container(
                            margin: EdgeInsets.only(top: 20, left: 10),
                            height: 40,
                            child: RaisedButton(
                              child: Center(
                                child: Text(
                                  "Update Company",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    BouncyPageRoute(
                                        widget: EditCompanyProfileScreen()));
                              },
                              color: appTheme,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
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

  Widget getImageWidget() {
    return Image.asset('images/huser.png');
  }
}

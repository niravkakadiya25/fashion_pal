import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionpal/UI/SewingDetailsScreen.dart';
import 'package:fashionpal/UI/SewingScreen.dart';
import 'package:fashionpal/UI/StaffItem.dart';
import 'package:fashionpal/Utils/sharPreference.dart';
import 'package:fashionpal/colors.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../BouncyPageRoute.dart';
import 'AddCustomers.dart';
import 'AddSewingNewScreen.dart';
import 'CustomerDetails.dart';
import 'EditCustomer.dart';
import 'EditSewingScreen.dart';

class MyContactScreen extends StatefulWidget {
  _MyContactScreenState createState() => new _MyContactScreenState();
}

class _MyContactScreenState extends State<MyContactScreen> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var collection = FirebaseFirestore.instance.collection('customers');
  dynamic userId;

  late String customerId;

  @override
  void initState() {
    getData();
    super.initState();
  }

  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('customers');

  Future<void> getData() async {
    userId = await getOwnerId();
    setState(() {});
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    // final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    //
    // print(allData);
    //
    //
    // var docSnapshot = await collection.doc('44XrFFlAe0bGiWX7Tki0RpXVU8R2').get();
    //
    // // collection.doc('44XrFFlAe0bGiWX7Tki0RpXVU8R2').get().then((value) {
    // //
    // // });
    //
    // final DocumentSnapshot documentSnapshot = await collection.doc('44XrFFlAe0bGiWX7Tki0RpXVU8R2').get();
    //
    // print(documentSnapshot.data());

    // print('data3');
    //
    // FirebaseFirestore.instance
    //     .collection('customers')
    //     .where("city",isNotEqualTo: userId)
    //     .get().then((value) {
    //       print("doc");
    //       print(value.size);
    // }
    // );
    // print(doc);

    // FirebaseFirestore.instance
    //     .collection('customers')
    //     .doc()
    //     .get()
    //     .then((DocumentSnapshot documentSnapshot) {
    //   print(documentSnapshot.data());
    //   dynamic nested = documentSnapshot.get(['email','']);
    //   print(nested);
    //   // if (documentSnapshot.exists) {
    //   //   print('Document exists on the database');
    //   //
    //   //
    //   // }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _build(context));
  }

  Widget _build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('customers')
                    .where("ownerId", isEqualTo: userId)
                    .snapshots(),
                // stream: FirebaseFirestore.instance.collection('customers').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      child: GridView.builder(
                        itemCount: snapshot.data!.docs.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 5,
                            childAspectRatio: 1.15),
                        itemBuilder: (BuildContext context, int index) {
                          Map<String, dynamic> documentFields =
                              snapshot.data!.docs[index].get("customerData");
                          return Container(
                            child: Card(
                              color: plancolor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Stack(children: <Widget>[
                                Column(children: <Widget>[
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    elevation: 0.0,
                                    color: white_theme,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 10,
                                              bottom: 10,
                                              left: 5,
                                              right: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              InkWell(
                                                // onTap: (){
                                                //   Navigator.push(context,
                                                //       new BouncyPageRoute(widget: CustomerDetails(documentFields))
                                                //   );
                                                // },
                                                child: Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      InkWell(
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                          child: Image.asset(
                                                            "images/logo.png",
                                                            fit: BoxFit.fill,
                                                            height: 20.0,
                                                            width: 20.0,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 5),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  documentFields[
                                                                      "firstName"],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          11,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center),
                                                              Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              10,
                                                                          right:
                                                                              10),
                                                                  color: Colors
                                                                      .black,
                                                                  height: 1),
                                                              Text(
                                                                  documentFields[
                                                                      "phoneNumber"],
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center),
                                                            ],
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          InkWell(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, left: 10),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    "images/ic_sewing.png",
                                                    fit: BoxFit.fill,
                                                    height: 25.0,
                                                    width: 25.0,
                                                  ),
                                                  Text('Sew'),
                                                ],
                                              ),
                                            ),
                                            onTap: () async {
                                              Navigator.push(
                                                  context,
                                                  new BouncyPageRoute(
                                                      widget:
                                                          AddSewingNewScreen(
                                                    isFromCustomerScreen: true,
                                                    customerDocumentSnapshot:
                                                        snapshot
                                                            .data!.docs[index],
                                                  )));
                                            },
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, bottom: 5),
                                            color: Colors.white,
                                            width: 1,
                                            height: 25,
                                          ),
                                          InkWell(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, right: 10),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    "images/ic_menu.png",
                                                    fit: BoxFit.fill,
                                                    height: 25.0,
                                                    width: 25.0,
                                                  ),
                                                  Text('Details'),
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              customerId = snapshot
                                                  .data!.docs[index]
                                                  .get("customerId");
                                              Navigator.push(
                                                  context,
                                                  new BouncyPageRoute(
                                                      widget: CustomerDetails(
                                                          documentFields,
                                                          customerId)));
                                            },
                                          )
                                        ],
                                      ))
                                ])
                              ]),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (!snapshot.hasData) {
                    return Center(
                      child: Text('No Customer'),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                  height: 100,
                  width: 200,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context, new BouncyPageRoute(widget: AddCustomer()));
                    },
                    child: Container(
                        padding: EdgeInsets.only(top: 10, right: 10),
                        alignment: Alignment.bottomRight,
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: getImageAssets())),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget getImageAssets() {
    AssetImage assetImage = AssetImage('images/addcustomer.png');
    Image image = Image(image: assetImage, width: 180.0, height: 100.0);
    return Container(child: image);
  }
}

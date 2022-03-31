import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionpal/SplashScreen.dart';
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
import 'HomeScreen.dart';

class MyContactScreen extends StatefulWidget {
  final bool isSearching;
  final String? query;

  const MyContactScreen({Key? key, this.isSearching = false, this.query})
      : super(key: key);

  @override
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

  List<QueryDocumentSnapshot>? customerSnapshot;
  List<QueryDocumentSnapshot>? searchCustomerSnapshot;

  Future<void> getData() async {
    userId = await getOwnerId();
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('customers')
        .where("ownerId", isEqualTo: userId)
        .get();
    if (snapshot.docs.isEmpty) {
      customerSnapshot = [];
    } else {
      customerSnapshot = [];
      customerSnapshot?.addAll(snapshot.docs);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _build(context));
  }

  Widget getSearchData() {
    searchCustomerSnapshot = [];
    customerSnapshot?.forEach((element) {
      if (((element.data() as Map)['customerData']['firstName'])
              .toString()
              .toLowerCase()
              .contains((widget.query ?? '').toString().toLowerCase()) ||
          ((element.data() as Map)['customerData']['lastName'])
              .toString()
              .toLowerCase()
              .contains((widget.query ?? '').toLowerCase()) ||
          ((element.data() as Map)['customerData']['phoneNumber'])
              .toString()
              .toLowerCase()
              .contains((widget.query ?? '').toLowerCase())) {
        searchCustomerSnapshot?.add(element);
      }
    });
    return item(searchCustomerSnapshot);
  }

  Widget _build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            widget.isSearching
                ? getSearchData()
                : customerSnapshot == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : (customerSnapshot?.isEmpty ?? true)
                        ? Center(
                            child: Text('No Customer'),
                          )
                        : Container(
                            child: GridView.builder(
                              itemCount: customerSnapshot?.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 1,
                                      mainAxisSpacing: 5,
                                      childAspectRatio: 1.15),
                              itemBuilder: (BuildContext context, int index) {
                                Map<String, dynamic> documentFields =
                                    customerSnapshot?[index]
                                        .get("customerData");
                                return Container(
                                  child: Card(
                                    color: plancolor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
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
                                                                child:
                                                                    Image.asset(
                                                                  "images/logo.png",
                                                                  fit: BoxFit
                                                                      .fill,
                                                                  height: 20.0,
                                                                  width: 20.0,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            5),
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
                                                                            fontWeight: FontWeight
                                                                                .bold),
                                                                        textAlign:
                                                                            TextAlign.center),
                                                                    Container(
                                                                        margin: EdgeInsets.only(
                                                                            left:
                                                                                10,
                                                                            right:
                                                                                10),
                                                                        color: Colors
                                                                            .black,
                                                                        height:
                                                                            1),
                                                                    isStaffUser
                                                                        ? (permissionList[0].isGranted ??
                                                                                false)
                                                                            ? Container(
                                                                                alignment: Alignment.centerRight,
                                                                                padding: EdgeInsets.only(right: 20),
                                                                                child: Text(documentFields["phoneNumber"],
                                                                                    style: TextStyle(
                                                                                      fontSize: 12,
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                    textAlign: TextAlign.center))
                                                                            : Container()
                                                                        : Text(documentFields["phoneNumber"],
                                                                            style: TextStyle(
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                            textAlign: TextAlign.center),
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                    await Navigator.push(
                                                        context,
                                                        new BouncyPageRoute(
                                                            widget:
                                                                AddSewingNewScreen(
                                                          isFromCustomerScreen:
                                                              true,
                                                          customerDocumentSnapshot:
                                                              customerSnapshot![
                                                                  index],
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
                                                  onTap: () async {
                                                    customerId =
                                                        customerSnapshot![index]
                                                            .get("customerId");
                                                    await Navigator.push(
                                                        context,
                                                        new BouncyPageRoute(
                                                            widget: CustomerDetails(
                                                                documentFields,
                                                                customerId)));
                                                    getData();
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
                          ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                  height: 100,
                  width: 200,
                  child: InkWell(
                    onTap: () async {
                      await Navigator.push(
                          context, new BouncyPageRoute(widget: AddCustomer()));
                      getData();
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

  Widget item(List<QueryDocumentSnapshot>? snapshots) {
    return GridView.builder(
      itemCount: snapshots?.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 1,
          mainAxisSpacing: 5,
          childAspectRatio: 1.15),
      itemBuilder: (BuildContext context, int index) {
        Map<String, dynamic> documentFields =
            snapshots?[index].get("customerData");
        return Container(
          child: Card(
            color: plancolor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Stack(children: <Widget>[
              Column(children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  elevation: 0.0,
                  color: white_theme,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 5, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                            BorderRadius.circular(20.0),
                                        child: Image.asset(
                                          "images/logo.png",
                                          fit: BoxFit.fill,
                                          height: 20.0,
                                          width: 20.0,
                                        ),
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(left: 5),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(documentFields["firstName"],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.center),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    left: 10, right: 10),
                                                color: Colors.black,
                                                height: 1),
                                            Text(documentFields["phoneNumber"],
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          child: Container(
                            margin: EdgeInsets.only(top: 5, left: 10),
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
                                    widget: AddSewingNewScreen(
                                  isFromCustomerScreen: true,
                                  customerDocumentSnapshot: snapshots![index],
                                )));
                          },
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          color: Colors.white,
                          width: 1,
                          height: 25,
                        ),
                        InkWell(
                          child: Container(
                            margin: EdgeInsets.only(top: 5, right: 10),
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
                            customerId = snapshots![index].get("customerId");
                            Navigator.push(
                                context,
                                new BouncyPageRoute(
                                    widget: CustomerDetails(
                                        documentFields, customerId)));
                          },
                        )
                      ],
                    ))
              ])
            ]),
          ),
        );
      },
    );
  }

  Widget getImageAssets() {
    AssetImage assetImage = AssetImage('images/addcustomer.png');
    Image image = Image(image: assetImage, width: 180.0, height: 100.0);
    return Container(child: image);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fashionpal/Utils/sharPreference.dart';
import 'package:fashionpal/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../BouncyPageRoute.dart';
import 'AddSewingNewScreen.dart';

class EditSewingScreen extends StatefulWidget {
  final DocumentSnapshot? documentFields;
  final QueryDocumentSnapshot? customerDocumentSnapshot;

  const EditSewingScreen(
      {Key? key, this.customerDocumentSnapshot, this.documentFields})
      : super(key: key);

  @override
  _EditSewingScreenState createState() => _EditSewingScreenState();
}

class _EditSewingScreenState extends State<EditSewingScreen> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  QuerySnapshot? snapshot;
  Map<dynamic, dynamic> maps = Map();

  getData() async {
    snapshot = await FirebaseFirestore.instance
        .collection('customer')
        .where('ownerId', isEqualTo: await getOwnerId())
        .get();

    DocumentSnapshot snapshot1 = await FirebaseFirestore.instance
        .collection('sewings')
        .doc(widget.documentFields?.id)
        .get();
    if (snapshot1.exists) {
      List list = [];
      Map<String, dynamic> mesurement =
          (snapshot1.data() as Map)['sewingData']['measurement'];
      mesurement.forEach((key, value) {
        list = value;
      });
      for (var element in list) {
        maps.addAll(element);
      }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50, bottom: 20),
        color: light_grey_theme,
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15),
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
                        alignment: Alignment.center,
                        child: Text(
                          "Edit Sewings",
                          textAlign: TextAlign.left,
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
                        child: Container(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  new BouncyPageRoute(
                                      widget: AddSewingNewScreen(
                                    isFromEdit: true,
                                    sewDetails: widget.documentFields,
                                    customerDocumentSnapshot:
                                        widget.customerDocumentSnapshot,
                                    isFromCustomerScreen: true,
                                  )));
                            },
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
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 20, bottom: 20),
                    child: Form(
                      child: Column(
                        children: [
                          Column(children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Container(
                                height: 20,
                                child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Edit Sewing Details",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                      width: MediaQuery.of(context).size.width -
                                          210,
                                      padding:
                                          EdgeInsets.only(top: 10, bottom: 5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 2, top: 3),
                                            child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  (widget.documentFields?.data()
                                                              as Map)[
                                                          'sewingData']['title']
                                                      .toString(),
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 2, top: 5),
                                            child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "Duration:",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                )),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 2, top: 5, right: 2),
                                              child: Container(
                                                height: 20,
                                                child: Container(
                                                  child: Text(
                                                      "${(widget.documentFields?.data() as Map)['sewingData']['duration'].toString()} days"),
                                                ),
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 2, top: 5),
                                            child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "Date Started:",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                )),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 2, top: 5, right: 2),
                                              child: Container(
                                                height: 20,
                                                child: Container(
                                                  child: Text(
                                                    ((widget.documentFields
                                                                        ?.data()
                                                                    as Map)[
                                                                'sewingData']
                                                            ['createdAt'])
                                                        .toDate()
                                                        .toString(),
                                                  ),
                                                ),
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 2, top: 5),
                                            child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "Date Collected:",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                )),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 2, top: 5, right: 2),
                                              child: Container(
                                                height: 20,
                                                child: Container(
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                        filled: true,
                                                        hintStyle: TextStyle(
                                                            color: Colors
                                                                .grey[800]),
                                                        fillColor:
                                                            light_grey_theme),
                                                  ),
                                                ),
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 2, top: 5),
                                            child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "Select Staff:",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 2, top: 5, right: 2),
                                              child: Container(
                                                height: 20,
                                                child: Container(
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                        filled: true,
                                                        hintStyle: TextStyle(
                                                            color: Colors
                                                                .grey[800]),
                                                        fillColor:
                                                            light_grey_theme),
                                                  ),
                                                ),
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 2, top: 5),
                                            child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "Measurement:",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                )),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 2, right: 2),
                                              child: Container(
                                                height: 150,
                                                child: Container(
                                                    child: ListView(
                                                  children: maps.entries
                                                      .map((e) => Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(e.key),
                                                              Text(e.value),
                                                            ],
                                                          ))
                                                      .toList(),
                                                )),
                                              )),
                                          Container(
                                              padding: EdgeInsets.only(
                                                  top: 10,
                                                  bottom: 5,
                                                  left: 10,
                                                  right: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "Style",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                Colors.black),
                                                      )),
                                                  Container(
                                                      width: 100,
                                                      height: 50,
                                                      margin: EdgeInsets.only(
                                                        top: 10,
                                                      ),
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount: (widget
                                                                    .documentFields
                                                                    ?.data()
                                                                as Map)['styles']
                                                            .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Image.network((widget
                                                                  .documentFields
                                                                  ?.data() as Map)[
                                                              'styles'][index]);
                                                        },
                                                      )),
                                                ],
                                              )),
                                          Container(
                                              padding: EdgeInsets.only(
                                                  top: 10,
                                                  bottom: 5,
                                                  left: 10,
                                                  right: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "Fabric",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                Colors.black),
                                                      )),
                                                  Container(
                                                      width: 100,
                                                      height: 50,
                                                      margin: EdgeInsets.only(
                                                        top: 10,
                                                      ),
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount: (widget.documentFields
                                                                            ?.data()
                                                                        as Map)[
                                                                    'fabrics'] ==
                                                                null
                                                            ? 0
                                                            : (widget.documentFields
                                                                            ?.data()
                                                                        as Map)[
                                                                    'fabrics']
                                                                .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Image.network((widget
                                                                  .documentFields
                                                                  ?.data() as Map)[
                                                              'fabrics  '][index]);
                                                        },
                                                      )),
                                                ],
                                              ))
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

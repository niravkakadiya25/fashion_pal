import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fashionpal/Database/init_dtabse.dart';
import 'package:fashionpal/Database/sewing_data.dart';
import 'package:fashionpal/SplashScreen.dart';
import 'package:fashionpal/Utils/constants.dart';
import 'package:fashionpal/Utils/sharPreference.dart';
import 'package:fashionpal/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../BouncyPageRoute.dart';
import 'AddSewingNewScreen.dart';
import 'image.dart';

class EditSewingScreen extends StatefulWidget {
  final DocumentSnapshot? documentFields;
  final QueryDocumentSnapshot? customerDocumentSnapshot;
  final QueryDocumentSnapshot? staffDocumentSnapshot;
  final Function celebrityCallback;

  const EditSewingScreen({Key? key,
    this.customerDocumentSnapshot,
    this.documentFields,
    this.staffDocumentSnapshot, required this.celebrityCallback})
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


  TextEditingController staffNameController = TextEditingController();
  String staffName = '';

  getData() async {
    if (kDebugMode) {
      print(widget.documentFields?.id);
      print(await getOwnerId());
    }
    snapshot = await FirebaseFirestore.instance
        .collection('customer')
        .where('ownerId', isEqualTo: await getOwnerId())
        .get();

    DocumentSnapshot snapshot1 = await FirebaseFirestore.instance
        .collection('sewings')
        .doc(widget.documentFields?.id)
        .get();
    if (snapshot1.exists) {
      var staffData =
      (snapshot1.data() as Map)['sewingData']['staffData'];

      if (staffData != null) {
        try {
          staffName = staffData['firstName'] + ' ' + staffData['lastName'];
        } catch (e) {
          staffName = 'admin';
        }
      } else {
        staffName = 'admin';
      }
      staffNameController.text = staffName;
      var mesurement =
      (snapshot1.data() as Map)['sewingData']['measurements'];
      if (mesurement != null) {
        if (mesurement.isNotEmpty) {
          mesurement.forEach((key, value) {
            List<Map<String, dynamic>> list1 = [];
            for (var element in (value as List)) {
              list1.add((element as Map<String, dynamic>));
            }
            print(key);
            sewmap[key] = list1;
          });
        }
      }

      print(sewmap.toString());
      setState(() {});
    }
  }

  Map<String?, List<Map<String, dynamic>>> sewmap = new Map();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 50, bottom: 20),
            color: light_grey_theme,
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
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
                          child: isStaffUser
                              ? (permissionList[0].isGranted ?? false)
                              ? Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                child: InkWell(
                                  onTap: () async {
                                    await FirebaseFirestore.instance
                                        .collection('sewings')
                                        .doc(widget.documentFields?.id)
                                        .delete();
                                    Navigator.pop(context);
                                    widget.celebrityCallback();

                                  },
                                  child: Icon(Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 20,),
                              Container(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        new BouncyPageRoute(
                                            widget: AddSewingNewScreen(
                                              isFromEdit: true,
                                              sewDetails: widget
                                                  .documentFields,
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
                            ],
                          )
                              : Container()
                              : Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  child: InkWell(
                                    onTap: () async {
                                      await FirebaseFirestore.instance
                                          .collection('sewings')
                                          .doc(widget.documentFields?.id)
                                          .delete();
                                      Navigator.pop(context);
                                      widget.celebrityCallback();
                                    },
                                    child: Icon(Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20,),
                                Container(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          new BouncyPageRoute(
                                              widget: AddSewingNewScreen(
                                                isFromEdit: true,
                                                sewDetails: widget
                                                    .documentFields,
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
                              ],
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
                          child: Column(children: <Widget>[
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
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: Container(
                                  width:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .width - 210,
                                  padding: EdgeInsets.only(top: 10, bottom: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                              as Map)['sewingData']
                                              ['title']
                                                  .toString(),
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
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
                                                  fontWeight: FontWeight.bold,
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
                                                  "${(widget.documentFields
                                                      ?.data() as Map)['sewingData']['duration']
                                                      .toString()} days"),
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
                                                  fontWeight: FontWeight.bold,
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
                                                ((widget.documentFields?.data()
                                                as Map)[
                                                'sewingData']
                                                ['createdAt'])
                                                    .toDate()
                                                    .toString(),
                                              ),
                                            ),
                                          )),
                                      /*  Padding(
                                        padding: const EdgeInsets.only(
                                            left: 2, top: 5),
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Date Collected:",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
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
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                    ),
                                                    filled: true,
                                                    hintStyle: TextStyle(
                                                        color:
                                                        Colors.grey[800]),
                                                    fillColor:
                                                    light_grey_theme),
                                              ),
                                            ),
                                          )),*/
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 2, top: 5),
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                              "Select Staff:",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 2, top: 5, right: 2),
                                          child: Container(
                                            height: 20,
                                            child: Container(
                                              child: TextField(
                                                controller: staffNameController,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                    ),
                                                    filled: true,
                                                    hintStyle: TextStyle(
                                                        color:
                                                        Colors.grey[800]),
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
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            )),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 2, right: 2),
                                          child: Container(
                                            height: 150,
                                            width: 500,
                                            child: Container(
                                                child: ListView(
                                                  children: sewmap.entries
                                                      .map((e) =>
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .start,
                                                        mainAxisSize: MainAxisSize
                                                            .min,

                                                        children: [
                                                          Text(e.key ?? '',
                                                            style: const TextStyle(
                                                              fontSize: 15,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                            ),),
                                                          // Text(e.value),


                                                          Flexible(
                                                            child: ListView
                                                                .builder(
                                                              physics: NeverScrollableScrollPhysics(),
                                                              shrinkWrap: true,
                                                              itemCount: e.value
                                                                  .length,
                                                              itemBuilder: (
                                                                  context,
                                                                  index) {
                                                                return Container(
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment
                                                                        .spaceBetween,
                                                                    children: [
                                                                      Text(e
                                                                          .value[index]
                                                                          .entries
                                                                          .first
                                                                          .key),
                                                                      Text(e
                                                                          .value[index]
                                                                          .entries
                                                                          .first
                                                                          .value),
                                                                    ],
                                                                  ),
                                                                );
                                                              },),
                                                          )

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
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "Fabric",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                        FontWeight.normal,
                                                        color: Colors.black),
                                                  )),
                                              Container(
                                                  width: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width,
                                                  height: 70,

                                                  margin: EdgeInsets.only(
                                                    top: 10,
                                                  ),
                                                  child: ListView.builder(
                                                    scrollDirection: Axis
                                                        .horizontal,
                                                    shrinkWrap: true,
                                                    itemCount: (widget
                                                        .documentFields
                                                        ?.data()
                                                    as Map)['sewingData'][
                                                    'fabrics'] ==
                                                        null
                                                        ? 0
                                                        : (widget.documentFields
                                                        ?.data()
                                                    as Map)['sewingData'][
                                                    'fabrics']
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return GestureDetector(
                                                        onTap:
                                                            () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (
                                                                    context) =>
                                                                    FullImage(
                                                                        imageUrl: (widget
                                                                            .documentFields
                                                                            ?.data()
                                                                        as Map)['sewingData'][
                                                                        'fabrics'][index]),
                                                              ));
                                                        },
                                                        child: Image.network(
                                                          (widget.documentFields
                                                              ?.data()
                                                          as Map)['sewingData'][
                                                          'fabrics'][index],
                                                          height:
                                                          120,
                                                          width:
                                                          100,
                                                          fit: BoxFit.contain,),
                                                      );
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
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "Style",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                        FontWeight.normal,
                                                        color: Colors.black),
                                                  )),
                                              Container(
                                                  width: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width,
                                                  height: 70,
                                                  margin: EdgeInsets.only(
                                                    top: 10,
                                                  ),
                                                  child: ListView.builder(
                                                    scrollDirection: Axis
                                                        .horizontal,
                                                    shrinkWrap: true,
                                                    itemCount: (widget
                                                        .documentFields
                                                        ?.data()
                                                    as Map)['sewingData']['styles']
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return GestureDetector(
                                                        onTap:
                                                            () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (
                                                                    context) =>
                                                                    FullImage(
                                                                        imageUrl: (widget
                                                                            .documentFields
                                                                            ?.data()
                                                                        as Map)['sewingData'][
                                                                        'styles'][index]),
                                                              ));
                                                        },
                                                        child: Image.network(
                                                          (widget.documentFields
                                                              ?.data()
                                                          as Map)['sewingData'][
                                                          'styles'][index],
                                                          height:
                                                          120,
                                                          width:
                                                          100,
                                                          fit: BoxFit.contain,),
                                                      );
                                                    },
                                                  )),
                                            ],
                                          )),
                                      paymentDialog(
                                          'Total Cost', ((widget.documentFields
                                          ?.data() as Map)['sewingData']['cost']
                                          .toString()
                                          .isEmpty
                                          ? 0
                                          : (int.parse(
                                          ((widget.documentFields?.data()
                                          as Map)['sewingData']['cost'] ??
                                              0)
                                              .toString()))).toString()),
                                      paymentDialog(
                                          'Amount Paid',
                                          ((widget.documentFields?.data()
                                          as Map)['sewingData']['amountPaid']
                                              .toString()
                                              .isEmpty
                                              ? 0
                                              : (int.parse(
                                              ((widget.documentFields?.data()
                                              as Map)['sewingData']
                                              ['amountPaid'] ??
                                                  0)
                                                  .toString()))).toString()),
                                      paymentDialog('Amount Remaining',
                                          (((widget.documentFields
                                              ?.data() as Map)['sewingData']
                                          ['cost']
                                              .toString()
                                              .isEmpty
                                              ? 0
                                              : (int.parse(
                                              ((widget.documentFields?.data()
                                              as Map)['sewingData']['cost'] ??
                                                  0)
                                                  .toString()))) -
                                              ((widget.documentFields
                                                  ?.data() as Map)['sewingData']['amountPaid']
                                                  .toString()
                                                  .isEmpty
                                                  ? 0
                                                  : (int.parse(
                                                  ((widget.documentFields
                                                      ?.data()
                                                  as Map)['sewingData']['amountPaid'] ??
                                                      0)
                                                      .toString()))))
                                              .toString()),
                                    ],
                                  )),
                            ),

                          ]),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: (((widget.documentFields?.data() as Map)['sewingData']
            ['amountPaid']
                .toString()
                .isEmpty
                ? 0
                : (int.parse(((widget.documentFields?.data()
            as Map)['sewingData']['amountPaid'] ??
                0)
                .toString()))) <
                ((widget.documentFields?.data() as Map)['sewingData']['cost']
                    .toString()
                    .isEmpty
                    ? 0
                    : (int.parse(((widget.documentFields?.data()
                as Map)['sewingData']['cost'] ??
                    0)
                    .toString()))))
                ? SizedBox(
                height: 100,
                width: 200,
                child: InkWell(
                  onTap: () async {
                    buildPaymentDialog();
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 10, right: 10),
                    alignment: Alignment.bottomRight,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: 100,
                        height: 35,
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        margin: EdgeInsets.only(bottom: 10),
                        child: Center(child: Text('Pay Now')),
                      ),),),
                ))
                : Container(),
          )
        ],
      ),
    );
  }

  buildPaymentDialog() {
    controller.clear();
    Widget okButton = TextButton(
      child: Text("pay",
          style: TextStyle(
            color: Colors.black,
            decorationColor: Colors.black,
          )),
      onPressed: () async {
        Navigator.pop(context);
        if (controller.text
            .trim()
            .isNotEmpty) {
          await FirebaseFirestore.instance
              .collection('sewings')
              .doc(widget.documentFields?.id)
              .update(
            {
              'sewingData.amountPaid': (((widget.documentFields?.data()
              as Map)['sewingData']['amountPaid']
                  .toString()
                  .isEmpty
                  ? 0
                  : (int.parse(((widget.documentFields?.data()
              as Map)['sewingData']['amountPaid'] ??
                  0)
                  .toString()))) +
                  int.parse(controller.text))
                  .toString()
            },
          );
          Navigator.of(context)
              .popUntil((route) => route.isFirst);
        }
      },
    );
    Widget cancelButton = TextButton(
      child: Text("Cancel",
          style: TextStyle(
            color: Colors.black,
            decorationColor: Colors.black,
          )),
      onPressed: () {
        Navigator.pop(context);
        controller.clear();
      },
    );

    // set up the AlertDialog

    if (Platform.isAndroid) {
      AlertDialog alert = AlertDialog(
        title: Text('Add Payment',
            style: TextStyle(
              color: Colors.black,
              decorationColor: Colors.black,
            )),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                paymentDialog(
                    'Cost of Sewing:',
                    ((widget.documentFields?.data() as Map)['sewingData']
                    ['cost']
                        .toString()
                        .isEmpty
                        ? 0
                        : (int.parse(((widget.documentFields?.data()
                    as Map)['sewingData']['cost'] ??
                        0)
                        .toString())))
                        .toString()),
                paymentDialog(
                    'Amount Paid:',
                    ((widget.documentFields?.data() as Map)['sewingData']
                    ['amountPaid']
                        .toString()
                        .isEmpty
                        ? 0
                        : (int.parse(((widget.documentFields?.data()
                    as Map)['sewingData']['amountPaid'] ??
                        0)
                        .toString())))
                        .toString()),
                paymentDialog(
                    'Amount Remaining:',
                    (((widget.documentFields?.data() as Map)['sewingData']
                    ['cost']
                        .toString()
                        .isEmpty
                        ? 0
                        : (int.parse(((widget.documentFields?.data()
                    as Map)['sewingData']['cost'] ??
                        0)
                        .toString()))) -
                        ((widget.documentFields?.data() as Map)['sewingData']
                        ['amountPaid']
                            .toString()
                            .isEmpty
                            ? 0
                            : (int.parse(((widget.documentFields?.data()
                        as Map)['sewingData']
                        ['amountPaid'] ??
                            0)
                            .toString()))))
                        .toString()),
                GestureDetector(
                  onTap: () async {
                    await buildAddPaymentDialog();
                    setState(() {});
                    print('dfwef');
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      child: Text(
                        '+ ${controller.text.isNotEmpty
                            ? 'Edit'
                            : 'Add'} Payment',
                        textAlign: TextAlign.end,
                        style: TextStyle(color: Colors.blue),
                      ),
                      margin: EdgeInsets.only(top: 10),
                    ),
                  ),
                ),
                Text(controller.text,
                    style: TextStyle(
                      color: Colors.black,
                      decorationColor: Colors.black,
                    ))
              ],
            );
          },
        ),
        actions: [
          okButton,
          cancelButton,
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
    if (Platform.isIOS) {
      CupertinoAlertDialog cupertinoAlertDialog = CupertinoAlertDialog(
        title: Text('Add Payment',
            style: TextStyle(
              color: Colors.black,
              decorationColor: Colors.black,
            )),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                paymentDialog(
                    'Cost of Sewing:',
                    ((widget.documentFields?.data() as Map)['sewingData']
                    ['cost']
                        .toString()
                        .isEmpty
                        ? 0
                        : (int.parse(((widget.documentFields?.data()
                    as Map)['sewingData']['cost'] ??
                        0)
                        .toString())))
                        .toString()),
                paymentDialog(
                    'Amount Paid:',
                    ((widget.documentFields?.data() as Map)['sewingData']
                    ['amountPaid']
                        .toString()
                        .isEmpty
                        ? 0
                        : (int.parse(((widget.documentFields?.data()
                    as Map)['sewingData']['amountPaid'] ??
                        0)
                        .toString())))
                        .toString()),
                paymentDialog(
                    'Amount Remaining:',
                    (((widget.documentFields?.data() as Map)['sewingData']
                    ['cost']
                        .toString()
                        .isEmpty
                        ? 0
                        : (int.parse(((widget.documentFields?.data()
                    as Map)['sewingData']['cost'] ??
                        0)
                        .toString()))) -
                        ((widget.documentFields?.data() as Map)['sewingData']
                        ['amountPaid']
                            .toString()
                            .isEmpty
                            ? 0
                            : (int.parse(((widget.documentFields?.data()
                        as Map)['sewingData']
                        ['amountPaid'] ??
                            0)
                            .toString()))))
                        .toString()),
                GestureDetector(
                  onTap: () async {
                    await buildAddPaymentDialog();
                    setState(() {});
                    print('dfwef');
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      child: Text(
                        '+ ${controller.text.isNotEmpty
                            ? 'Edit'
                            : 'Add'} Payment',
                        textAlign: TextAlign.end,
                        style: TextStyle(color: Colors.blue),
                      ),
                      margin: EdgeInsets.only(top: 10),
                    ),
                  ),
                ),
                Text(controller.text,
                    style: TextStyle(
                      color: Colors.black,
                      decorationColor: Colors.black,
                    ))
              ],
            );
          },
        ),
        actions: [
          okButton,
          cancelButton,
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return cupertinoAlertDialog;
        },
      );
    }
    // show the dialog
  }

  TextEditingController controller = TextEditingController();

  buildAddPaymentDialog() async {
    Widget okButton = TextButton(
      child: Text("OK",
          style: TextStyle(
            color: Colors.black,
            decorationColor: Colors.black,
          )),
      onPressed: () {
        Navigator.pop(context);
        setState(() {});
      },
    );
    Widget cancelButton = TextButton(
      child: Text("Cancel",
          style: TextStyle(
            color: Colors.black,
            decorationColor: Colors.black,
          )),
      onPressed: () {
        Navigator.pop(context);
        controller.clear();
      },
    );
    // set up the AlertDialog
    if (Platform.isAndroid) {
      AlertDialog alert = AlertDialog(
        title: Text('Add Payment',
            style: TextStyle(
              color: Colors.black,
              decorationColor: Colors.black,
            )),
        content: Container(
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Enter Amount'),
          ),
        ),
        actions: [
          okButton,
          cancelButton,
        ],
      );
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
    if (Platform.isIOS) {
      CupertinoAlertDialog cupertinoAlertDialog = CupertinoAlertDialog(
        title: Text('Add Payment',
            style: TextStyle(
              color: Colors.black,
              decorationColor: Colors.black,
            )),
        content: Container(
          child: TextFormField(
            controller: controller,
          ),
        ),
        actions: [
          okButton,
          cancelButton,
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return cupertinoAlertDialog;
        },
      );
    }
    // show the dialog
  }

  Widget paymentDialog(title, amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(amount),
      ],
    );
  }
}

Widget getImageAssets() {
  AssetImage assetImage = const AssetImage('images/ic_send.png');
  Image image = Image(image: assetImage, width: 100.0, height: 40.0);
  return Container(child: image);
}

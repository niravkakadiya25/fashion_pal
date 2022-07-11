import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fashionpal/Database/customer_data.dart';
import 'package:fashionpal/Database/init_dtabse.dart';
import 'package:fashionpal/Database/measurements.dart';
import 'package:fashionpal/Database/sewing_data.dart';
import 'package:fashionpal/UI/image.dart';
import 'package:fashionpal/Utils/ProgressDialog.dart';
import 'package:fashionpal/Utils/constants.dart';
import 'package:fashionpal/Utils/sharPreference.dart';
import 'package:fashionpal/colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddSewingNewScreen extends StatefulWidget {
  final bool? isFromEdit, isFromCustomerScreen;
  final DocumentSnapshot? sewDetails;
  final QueryDocumentSnapshot? customerDocumentSnapshot;
  final QueryDocumentSnapshot? staffDocumentSnapshot;

  const AddSewingNewScreen(
      {Key? key,
      this.isFromEdit = false,
      this.sewDetails,
      this.isFromCustomerScreen,
      this.customerDocumentSnapshot,
      this.staffDocumentSnapshot})
      : super(key: key);

  @override
  _AddSewingNewScreenState createState() => _AddSewingNewScreenState();
}

typedef OnPickImageCallback = void Function();

class _AddSewingNewScreenState extends State<AddSewingNewScreen> {
  TextEditingController sewTitle = TextEditingController();
  TextEditingController sewNumber = TextEditingController();
  TextEditingController sewDescription = TextEditingController();
  TextEditingController duration = TextEditingController();
  TextEditingController cost = TextEditingController();
  TextEditingController order = TextEditingController(text: 'ordered');
  TextEditingController payment = TextEditingController();
  TextEditingController paymentStatus = TextEditingController();
  TextEditingController reminder = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  dynamic ownerId;

  @override
  void initState() {
    getData();
    super.initState();
  }

  QuerySnapshot? snapshot;
  QuerySnapshot? staffSnapshot;
  QueryDocumentSnapshot? selectedStaffSnapshot;
  QueryDocumentSnapshot? selectedSnapshot;

  getData() async {
    ownerId = await getOwnerId();

    snapshot = await FirebaseFirestore.instance
        .collection('customers')
        .where('ownerId', isEqualTo: await getOwnerId())
        .get();

    staffSnapshot = await FirebaseFirestore.instance
        .collection('staff')
        .where('ownerId', isEqualTo: await getOwnerId())
        .get();

    if (widget.isFromCustomerScreen ?? false) {
      selectedSnapshot = widget.customerDocumentSnapshot;
      selectedStaffSnapshot = widget.staffDocumentSnapshot;
      sewNumber.text = (widget.customerDocumentSnapshot?.data() as Map) == null
          ? ''
          : (widget.customerDocumentSnapshot?.data() as Map)['customerData']
                  ['phoneNumber']
              .toString();
    }
    if (widget.isFromEdit ?? false) {
      await FirebaseFirestore.instance
          .collection('customers')
          .where('customerId',
              isEqualTo: (widget.sewDetails?.data() as Map)['customerId'] ?? '')
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) selectedSnapshot = value.docs.first;
      });

      await FirebaseFirestore.instance
          .collection('staff')
          .where('staffId',
              isEqualTo: (widget.sewDetails?.data() as Map)['staffId'] ?? '')
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) selectedStaffSnapshot = value.docs.first;
      });

      sewTitle.text =
          (widget.sewDetails?.data() as Map)['sewingData']['title'] ?? '';
      sewDescription.text =
          (widget.sewDetails?.data() as Map)['sewingData']['description'] ?? '';
      duration.text =
          (widget.sewDetails?.data() as Map)['sewingData']['duration'] ?? '';
      cost.text =
          (widget.sewDetails?.data() as Map)['sewingData']['cost'].toString();
      order.text =
          (widget.sewDetails?.data() as Map)['sewingData']['status'] ?? '';
      payment.text =
          (widget.sewDetails?.data() as Map)['sewingData']['payment'] ?? '';
      reminder.text =
          (widget.sewDetails?.data() as Map)['sewingData']['reminder'] ?? '';
      styles = (widget.sewDetails?.data() as Map)['sewingData']['styles'] ?? [];
      fabrics =
          (widget.sewDetails?.data() as Map)['sewingData']['fabrics'] ?? [];

      payment.text =
          (widget.sewDetails?.data() as Map)['sewingData']['amountPaid'] ?? [];

      sewNumber.text = (widget.sewDetails?.data() as Map) == null
          ? ''
          : (widget.sewDetails?.data() as Map)['sewingData']['customerData']
                  ['phoneNumber']
              .toString();
    }
    setState(() {});
  }

  Map<String, TextEditingController> _controllerMap = Map();
  List fabrics = [];
  List styles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 50, bottom: 20),
        color: light_grey_theme,
        alignment: Alignment.center,
        child: Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                decoration: const BoxDecoration(
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
                          padding: const EdgeInsets.only(left: 10),
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
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "Add Sewing",
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
                        padding: const EdgeInsets.only(),
                        child: Container(
                          child: InkWell(
                            // onTap: () {
                            //   Navigator.push(context,
                            //       new BouncyPageRoute(widget: EditSewingScreen())
                            //   );
                            // },
                            child: Image.asset(
                              "images/ic_edit.png",
                              color: Colors.blue,
                              height: 10,
                              width: 10,
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
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              height: 30,
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    "Add Sewings Details",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              margin: const EdgeInsets.only(top: 15),
                              child: DropdownSearch<QueryDocumentSnapshot>(
                                mode: Mode.MENU,
                                items: snapshot?.docs,
                                label: "Select User",
                                hint: "Select",
                                enabled: (widget.isFromCustomerScreen ?? false)
                                    ? false
                                    : true,
                                selectedItem: selectedSnapshot,
                                itemAsString: (item) {
                                  return (item?.data() as Map)['customerData']
                                          ['firstName'] +
                                      ' ' +
                                      (item?.data() as Map)['customerData']
                                          ['lastName'];
                                },
                                onChanged: (QueryDocumentSnapshot? value) {
                                  selectedSnapshot = value;

                                  setState(() {});
                                },
                                // validator: (val) =>
                                // val == null? _snackbar("Select Height Unit") : null,
                                // onSaved: (newValue) {
                                //   _heightUnit=newValue;
                                // },
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                height: 40,
                                child: Container(
                                  margin: const EdgeInsets.only(top: 15),
                                  child: TextField(
                                    controller: sewTitle,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                      ),
                                      hintText: 'Sew Title',
                                    ),
                                  ),
                                ),
                              )),
                          Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                height: 40,
                                child: Container(
                                  margin: const EdgeInsets.only(top: 15),
                                  child: TextField(
                                    controller: sewDescription,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                      ),
                                      hintText: 'Description',
                                    ),
                                  ),
                                ),
                              )),
                          Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                height: 40,
                                child: Container(
                                  margin: const EdgeInsets.only(top: 15),
                                  child: TextField(
                                    controller: sewNumber,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                      ),
                                      hintText: 'Contact Number',
                                    ),
                                  ),
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              margin: const EdgeInsets.only(top: 15),
                              child: DropdownSearch<QueryDocumentSnapshot>(
                                mode: Mode.MENU,
                                items: staffSnapshot?.docs,
                                label: selectedStaffSnapshot == null
                                    ? 'Admin'
                                    : "Select Staff",
                                hint: selectedStaffSnapshot == null
                                    ? 'Admin'
                                    : "Select Staff",

                                selectedItem: selectedStaffSnapshot,
                                itemAsString: (item) {
                                  return (item?.data() as Map)['staffData']
                                          ['firstName'] +
                                      ' ' +
                                      (item?.data() as Map)['staffData']
                                          ['lastName'];
                                },
                                onChanged: (QueryDocumentSnapshot? value) {
                                  selectedStaffSnapshot = value;

                                  setState(() {});
                                },
                                // validator: (val) =>
                                // val == null? _snackbar("Select Height Unit") : null,
                                // onSaved: (newValue) {
                                //   _heightUnit=newValue;
                                // },
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    elevation: 0.0,
                                    color: light_grey_theme,
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
                                              child: Container(
                                                height: 20,
                                                child: Container(
                                                    child: const Text(
                                                  "Measurement",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                )),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                QuerySnapshot<
                                                        Map<String, dynamic>>
                                                    snapshot =
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('sewings')
                                                        .get();
                                                if (snapshot.docs.isNotEmpty) {
                                                  for (int i = 0;
                                                      i < snapshot.docs.length;
                                                      i++) {
                                                    if (snapshot.docs[i].data()[
                                                            'customerId'] ==
                                                        (selectedSnapshot
                                                                    ?.data()
                                                                as Map)[
                                                            'customerId']) {
                                                      print('load');
                                                      loadPreviousMeasurement =
                                                          true;
                                                      snapshots =
                                                          snapshot.docs[i];
                                                      setState(() {});
                                                      break;
                                                    }
                                                  }
                                                }
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: Container(
                                                  height: 20,
                                                  child: Container(
                                                      child: const Text(
                                                    "Load Previous",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  )),
                                                ),
                                              ),
                                            ),
                                          ],
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                        ),
                                        FutureBuilder<
                                                QuerySnapshot<
                                                    Map<String, dynamic>>>(
                                            future: FirebaseFirestore.instance
                                                .collection(
                                                    'measurementsParent')
                                                .where('isActive',
                                                    isEqualTo: true)
                                                .where('sex',
                                                    isEqualTo: selectedSnapshot == null ? '':((selectedSnapshot
                                                        ?.data() as Map)['customerData']['sex']).toString().toLowerCase())
                                                .get(),
                                            builder: (context,
                                                AsyncSnapshot<
                                                        QuerySnapshot<
                                                            Map<String,
                                                                dynamic>>>
                                                    snapshot) {
                                              if (!snapshot.hasData) {
                                                return Container();
                                              }

                                              return Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    150,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10,
                                                          bottom: 5,
                                                          left: 10,
                                                          right: 10),
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    reverse: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (context, index) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          showDialogWithFields(
                                                              snapshot.data
                                                                      ?.docs[index]
                                                                      .data()[
                                                                  'parentTitle'],
                                                              snapshot
                                                                  .data
                                                                  ?.docs[index]
                                                                  .id);
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(top: 5),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                snapshot
                                                                        .data
                                                                        ?.docs[
                                                                            index]
                                                                        .data()[
                                                                    'parentTitle'],
                                                                style: TextStyle(
                                                                    fontSize: 18,
                                                                    fontWeight: FontWeight.w500,
                                                                    color: loadPreviousMeasurement
                                                                        ? snapshots == null
                                                                            ? Colors.black
                                                                            : ((snapshots?.data() as Map)['sewingData']['measurements']) == null
                                                                                ? Colors.red
                                                                                : (((snapshots?.data() as Map)['sewingData']['measurements'] as Map).keys.contains(snapshot.data?.docs[index].data()['parentTitle']) ? Colors.green : Colors.black)
                                                                        : (widget.sewDetails?.data() as Map) == null
                                                                            ? Colors.black
                                                                            : ((widget.sewDetails?.data() as Map)['sewingData']['measurements']) == null
                                                                                ? Colors.red
                                                                                : (((widget.sewDetails?.data() as Map)['sewingData']['measurements'] as Map).keys.contains(snapshot.data?.docs[index].data()['parentTitle']) ? Colors.green : Colors.black)),
                                                              ),
                                                              Container(
                                                                child: Icon(
                                                                    Icons.add,
                                                                    color: loadPreviousMeasurement
                                                                        ? snapshots == null
                                                                            ? Colors.black
                                                                            : ((snapshots?.data() as Map)['sewingData']['measurements']) == null
                                                                                ? Colors.red
                                                                                : (((snapshots?.data() as Map)['sewingData']['measurements'] as Map).keys.contains(snapshot.data?.docs[index].data()['parentTitle']) ? Colors.green : Colors.black)
                                                                        : (widget.sewDetails?.data() as Map) == null
                                                                            ? Colors.black
                                                                            : ((widget.sewDetails?.data() as Map)['sewingData']['measurements']) == null
                                                                                ? Colors.red
                                                                                : (((widget.sewDetails?.data() as Map)['sewingData']['measurements'] as Map).keys.contains(snapshot.data?.docs[index].data()['parentTitle']) ? Colors.green : Colors.black)),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    itemCount: snapshot.data
                                                            ?.docs.length ??
                                                        0,
                                                  ),
                                                ),
                                              );
                                            }),
                                        // Container(
                                        //     width: MediaQuery.of(context)
                                        //             .size
                                        //             .width -
                                        //         150,
                                        //     padding: EdgeInsets.only(
                                        //         top: 10,
                                        //         bottom: 5,
                                        //         left: 10,
                                        //         right: 10),
                                        //     child: Column(
                                        //       mainAxisAlignment:
                                        //           MainAxisAlignment.center,
                                        //       crossAxisAlignment:
                                        //           CrossAxisAlignment.center,
                                        //       children: [
                                        //         Padding(
                                        //           padding:
                                        //               const EdgeInsets.only(
                                        //                   top: 5),
                                        //           child: Container(
                                        //             height: 20,
                                        //             child: Container(
                                        //                 child: Text(
                                        //               "Measurement",
                                        //               textAlign:
                                        //                   TextAlign.left,
                                        //               style: TextStyle(
                                        //                   fontSize: 18,
                                        //                   fontWeight:
                                        //                       FontWeight.bold,
                                        //                   color:
                                        //                       Colors.black),
                                        //             )),
                                        //           ),
                                        //         ),
                                        //         Padding(
                                        //             padding:
                                        //                 const EdgeInsets.only(
                                        //                     left: 2, top: 10),
                                        //             child: Container(
                                        //               height: 30,
                                        //               child: Container(
                                        //                 child: TextField(
                                        //                   controller:
                                        //                       shirttype,
                                        //                   keyboardType:
                                        //                       TextInputType
                                        //                           .text,
                                        //                   decoration:
                                        //                       InputDecoration(
                                        //                     suffixIcon:
                                        //                         Container(
                                        //                       padding:
                                        //                           EdgeInsets
                                        //                               .all(
                                        //                                   6.0),
                                        //                       child:
                                        //                           Image.asset(
                                        //                         'images/equal.png',
                                        //                         width: 10,
                                        //                         height: 10,
                                        //                       ),
                                        //                     ),
                                        //                     focusedBorder:
                                        //                         UnderlineInputBorder(
                                        //                       borderSide:
                                        //                           BorderSide(
                                        //                               color: Colors
                                        //                                   .red),
                                        //                     ),
                                        //                     hintText:
                                        //                         'Shirt: Long/Short',
                                        //                   ),
                                        //                 ),
                                        //               ),
                                        //             )),
                                        //         Padding(
                                        //             padding:
                                        //                 const EdgeInsets.only(
                                        //                     left: 2, top: 10),
                                        //             child: Container(
                                        //               height: 30,
                                        //               child: Container(
                                        //                 child: TextFormField(
                                        //                   controller:
                                        //                       kabaslit,
                                        //                   keyboardType:
                                        //                       TextInputType
                                        //                           .text,
                                        //                   decoration:
                                        //                       InputDecoration(
                                        //                     suffixIcon:
                                        //                         Container(
                                        //                       padding:
                                        //                           EdgeInsets
                                        //                               .all(
                                        //                                   6.0),
                                        //                       child:
                                        //                           Image.asset(
                                        //                         'images/equal.png',
                                        //                         width: 10,
                                        //                         height: 10,
                                        //                       ),
                                        //                     ),
                                        //                     focusedBorder:
                                        //                         UnderlineInputBorder(
                                        //                       borderSide:
                                        //                           BorderSide(
                                        //                               color: Colors
                                        //                                   .red),
                                        //                     ),
                                        //                     hintText:
                                        //                         'Kaba and Slit',
                                        //                   ),
                                        //                 ),
                                        //               ),
                                        //             )),
                                        //         Padding(
                                        //             padding:
                                        //                 const EdgeInsets.only(
                                        //                     left: 2, top: 10),
                                        //             child: Container(
                                        //               height: 30,
                                        //               child: Container(
                                        //                 child: TextFormField(
                                        //                   controller:
                                        //                       skirtblouse,
                                        //                   keyboardType:
                                        //                       TextInputType
                                        //                           .text,
                                        //                   decoration:
                                        //                       InputDecoration(
                                        //                     suffixIcon:
                                        //                         Container(
                                        //                       padding:
                                        //                           EdgeInsets
                                        //                               .all(
                                        //                                   6.0),
                                        //                       child:
                                        //                           Image.asset(
                                        //                         'images/equal.png',
                                        //                         width: 10,
                                        //                         height: 10,
                                        //                       ),
                                        //                     ),
                                        //                     focusedBorder:
                                        //                         UnderlineInputBorder(
                                        //                       borderSide:
                                        //                           BorderSide(
                                        //                               color: Colors
                                        //                                   .red),
                                        //                     ),
                                        //                     hintText:
                                        //                         'Dress Skirt and Blouse',
                                        //                   ),
                                        //                 ),
                                        //               ),
                                        //             )),
                                        //         Padding(
                                        //             padding:
                                        //                 const EdgeInsets.only(
                                        //                     left: 2, top: 10),
                                        //             child: Container(
                                        //               height: 30,
                                        //               child: Container(
                                        //                 child: TextFormField(
                                        //                   controller:
                                        //                       trousersshorts,
                                        //                   keyboardType:
                                        //                       TextInputType
                                        //                           .text,
                                        //                   decoration:
                                        //                       InputDecoration(
                                        //                     suffixIcon:
                                        //                         Container(
                                        //                       padding:
                                        //                           EdgeInsets
                                        //                               .all(
                                        //                                   6.0),
                                        //                       child:
                                        //                           Image.asset(
                                        //                         'images/equal.png',
                                        //                         width: 10,
                                        //                         height: 10,
                                        //                       ),
                                        //                     ),
                                        //                     focusedBorder:
                                        //                         UnderlineInputBorder(
                                        //                       borderSide:
                                        //                           BorderSide(
                                        //                               color: Colors
                                        //                                   .red),
                                        //                     ),
                                        //                     hintText:
                                        //                         'Trousers and Shorts',
                                        //                   ),
                                        //                 ),
                                        //               ),
                                        //             )),
                                        //         Padding(
                                        //             padding:
                                        //                 const EdgeInsets.only(
                                        //                     left: 2, top: 10),
                                        //             child: Container(
                                        //               height: 30,
                                        //               child: Container(
                                        //                 child: TextFormField(
                                        //                   controller: kaftan,
                                        //                   keyboardType:
                                        //                       TextInputType
                                        //                           .text,
                                        //                   decoration:
                                        //                       InputDecoration(
                                        //                     suffixIcon:
                                        //                         Container(
                                        //                       padding:
                                        //                           EdgeInsets
                                        //                               .all(
                                        //                                   6.0),
                                        //                       child:
                                        //                           Image.asset(
                                        //                         'images/equal.png',
                                        //                         width: 10,
                                        //                         height: 10,
                                        //                       ),
                                        //                     ),
                                        //                     focusedBorder:
                                        //                         UnderlineInputBorder(
                                        //                       borderSide:
                                        //                           BorderSide(
                                        //                               color: Colors
                                        //                                   .red),
                                        //                     ),
                                        //                     hintText:
                                        //                         'Kaftan Top',
                                        //                   ),
                                        //                 ),
                                        //               ),
                                        //             )),
                                        //         Padding(
                                        //             padding:
                                        //                 const EdgeInsets.only(
                                        //                     left: 2, top: 10),
                                        //             child: Container(
                                        //               height: 30,
                                        //               child: Container(
                                        //                 child: TextFormField(
                                        //                   controller: formale,
                                        //                   keyboardType:
                                        //                       TextInputType
                                        //                           .text,
                                        //                   decoration:
                                        //                       InputDecoration(
                                        //                     suffixIcon:
                                        //                         Container(
                                        //                       padding:
                                        //                           EdgeInsets
                                        //                               .all(
                                        //                                   6.0),
                                        //                       child:
                                        //                           Image.asset(
                                        //                         'images/equal.png',
                                        //                         width: 10,
                                        //                         height: 10,
                                        //                       ),
                                        //                     ),
                                        //                     focusedBorder:
                                        //                         UnderlineInputBorder(
                                        //                       borderSide:
                                        //                           BorderSide(
                                        //                               color: Colors
                                        //                                   .red),
                                        //                     ),
                                        //                     hintText:
                                        //                         'Complete For Male',
                                        //                   ),
                                        //                 ),
                                        //               ),
                                        //             )),
                                        //         Padding(
                                        //             padding:
                                        //                 const EdgeInsets.only(
                                        //                     left: 2, top: 10),
                                        //             child: Container(
                                        //               height: 30,
                                        //               child: Container(
                                        //                 child: TextFormField(
                                        //                   controller:
                                        //                       forfemale,
                                        //                   keyboardType:
                                        //                       TextInputType
                                        //                           .text,
                                        //                   decoration:
                                        //                       InputDecoration(
                                        //                     suffixIcon:
                                        //                         Container(
                                        //                       padding:
                                        //                           EdgeInsets
                                        //                               .all(
                                        //                                   6.0),
                                        //                       child:
                                        //                           Image.asset(
                                        //                         'images/equal.png',
                                        //                         width: 10,
                                        //                         height: 10,
                                        //                       ),
                                        //                     ),
                                        //                     focusedBorder:
                                        //                         UnderlineInputBorder(
                                        //                       borderSide:
                                        //                           BorderSide(
                                        //                               color: Colors
                                        //                                   .red),
                                        //                     ),
                                        //                     hintText:
                                        //                         'Complete For Female',
                                        //                   ),
                                        //                 ),
                                        //               ),
                                        //             )),
                                        //       ],
                                        //     )),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          padding: const EdgeInsets.only(
                                              top: 10,
                                              bottom: 5,
                                              left: 10,
                                              right: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  const Text('Fabric'),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                      top: 10,
                                                    ),
                                                    child: fabrics.isEmpty
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              _showChoiceDialog(
                                                                  context,
                                                                  true);
                                                            },
                                                            child: Image.asset(
                                                              'images/ic_style.png',
                                                              width: 120,
                                                              height: 120,
                                                            ),
                                                          )
                                                        : Container(
                                                            height: 120,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            child: Row(
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    _showChoiceDialog(
                                                                        context,
                                                                        true);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    height: 120,
                                                                    width: 100,
                                                                    color: Colors
                                                                        .black,
                                                                    child:
                                                                        const Icon(
                                                                      Icons.add,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 20,
                                                                ),
                                                                ListView
                                                                    .builder(
                                                                  physics:
                                                                      const NeverScrollableScrollPhysics(),
                                                                  itemCount:
                                                                      fabrics
                                                                          .length,
                                                                  shrinkWrap:
                                                                      true,
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return Stack(
                                                                      children: [
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                  builder: (context) => FullImage(imageUrl: fabrics[index]),
                                                                                ));
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                120,
                                                                            width:
                                                                                100,
                                                                            child:
                                                                                Image.network(
                                                                              fabrics[index],
                                                                              fit: BoxFit.contain,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Positioned(
                                                                          right:
                                                                              0,
                                                                          child:
                                                                              GestureDetector(
                                                                            child:
                                                                                Container(
                                                                              color: Colors.black,
                                                                              child: const Icon(
                                                                                Icons.close,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                            onTap:
                                                                                () {
                                                                              fabrics.removeAt(index);
                                                                              setState(() {});
                                                                            },
                                                                          ),
                                                                        )
                                                                      ],
                                                                    );
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  const Text('Style'),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                      top: 10,
                                                    ),
                                                    child: styles.isEmpty
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              _showChoiceDialog(
                                                                  context,
                                                                  false);
                                                            },
                                                            child: Image.asset(
                                                              'images/ic_style.png',
                                                              width: 120,
                                                              height: 120,
                                                            ),
                                                          )
                                                        : Container(
                                                            height: 120,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            child: Row(
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    _showChoiceDialog(
                                                                        context,
                                                                        false);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    height: 120,
                                                                    width: 100,
                                                                    color: Colors
                                                                        .black,
                                                                    child:
                                                                        const Icon(
                                                                      Icons.add,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 20,
                                                                ),
                                                                ListView
                                                                    .builder(
                                                                  itemCount:
                                                                      styles
                                                                          .length,
                                                                  shrinkWrap:
                                                                      true,
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return Stack(
                                                                      children: [
                                                                        GestureDetector(
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                120,
                                                                            width:
                                                                                100,
                                                                            child:
                                                                                Image.network(
                                                                              styles[index],
                                                                              fit: BoxFit.contain,
                                                                            ),
                                                                          ),
                                                                          onTap:
                                                                              () {
                                                                            Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                  builder: (context) => FullImage(imageUrl: styles[index]),
                                                                                ));
                                                                          },
                                                                        ),
                                                                        Positioned(
                                                                          right:
                                                                              0,
                                                                          child:
                                                                              GestureDetector(
                                                                            child:
                                                                                Container(
                                                                              color: Colors.black,
                                                                              child: const Icon(
                                                                                Icons.close,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                            onTap:
                                                                                () {
                                                                              styles.removeAt(index);
                                                                              setState(() {});
                                                                            },
                                                                          ),
                                                                        )
                                                                      ],
                                                                    );
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                    ],
                                  )
                                ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 2, top: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 15),
                                    child: TextFormField(
                                      controller: duration,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      decoration: const InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                        ),
                                        hintText: 'Duration (In days)',
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 15),
                                    child: TextFormField(
                                      controller: cost,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                        ),
                                        hintText: 'Cost',
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 2, top: 10),
                            child: Container(
                              margin: const EdgeInsets.only(top: 15),
                              child: TextFormField(
                                onChanged: (value) {
                                  if (cost.text.trim().isEmpty) {
                                    paymentStatus.text = 'No payment';
                                  } else {
                                    if (value.isEmpty) {
                                      paymentStatus.text = 'No payment';
                                    } else if (int.parse(value.trim()) <
                                        int.parse(cost.text.trim())) {
                                      paymentStatus.text = 'partially paid';
                                    } else {
                                      paymentStatus.text = 'fully paid';
                                    }
                                  }
                                  setState(() {});
                                },
                                controller: payment,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  hintText: 'Payment',
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 2, top: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 15),
                                    child: DropdownSearch<String>(
                                      mode: Mode.MENU,
                                      items: [
                                        "order",
                                        "cutting",
                                        "sewing",
                                        'completed',
                                        'delivered'
                                      ],
                                      label: "Select Status",
                                      hint: "Status",
                                      selectedItem: order.text,
                                      onChanged: (value) {
                                        order.text = value!;
                                      },
                                      // validator: (val) =>
                                      // val == null? _snackbar("Select Height Unit") : null,
                                      // onSaved: (newValue) {
                                      //   _heightUnit=newValue;
                                      // },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 15),
                                    child: DropdownSearch<String>(
                                      mode: Mode.MENU,
                                      enabled: false,
                                      items: [
                                        "partially paid",
                                        "No payment",
                                        "fully paid",
                                      ],
                                      label: "Select Payment Status",
                                      hint: "Payment Status",
                                      selectedItem: paymentStatus.text,
                                      onChanged: (value) {
                                        paymentStatus.text = value!;
                                        setState(() {});
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
                          Padding(
                            padding: const EdgeInsets.only(left: 2, top: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 15),
                                    child: TextFormField(
                                      controller: reminder,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      decoration: const InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                        ),
                                        hintText: 'Reminder',
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (sewTitle.text.trim().isEmpty) {
                                        buildErrorDialog(
                                            context, '', 'Please Enter Title',
                                            () {
                                          Navigator.pop(context);
                                        });
                                      } else {
                                        ProgressDialog.showLoaderDialog(
                                            context);

                                        Map map;
                                        if (widget.isFromEdit ?? false) {
                                          if (sewmap.isEmpty) {
                                            map = {
                                              'cost': cost.text.isEmpty
                                                  ? 0
                                                  : int.parse(cost.text),
                                              'createdAt': DateTime.now(),
                                              'duration': duration.text,
                                              'description':
                                                  sewDescription.text,
                                              'status': order.text,
                                              'title': sewTitle.text,
                                              'amountPaid': payment.text.isEmpty
                                                  ? 0
                                                  : int.parse(payment.text),
                                              'paymentStatus':
                                                  paymentStatus.text,
                                              'reminder': reminder.text,
                                              'phoneNumber': sewNumber.text,
                                              'staffData':
                                                  selectedStaffSnapshot == null
                                                      ? {}
                                                      : (selectedStaffSnapshot
                                                              ?.data()
                                                          as Map)['staffData'],
                                              'customerData':
                                                  (selectedSnapshot?.data()
                                                      as Map)['customerData'],
                                              'customerName': (selectedSnapshot
                                                          ?.data()
                                                      as Map)['customerData']
                                                  ['firstName'],
                                              'fabrics': fabrics,
                                              'styles': styles,
                                            };
                                            uploadData(map);
                                            return;
                                          } else {
                                            map = {
                                              'cost': cost.text.isEmpty
                                                  ? 0
                                                  : int.parse(cost.text),
                                              'createdAt': DateTime.now(),
                                              'duration': duration.text,
                                              'description':
                                                  sewDescription.text,
                                              'status': order.text,
                                              'title': sewTitle.text,
                                              'measurements': sewmap,
                                              'amountPaid': payment.text.isEmpty
                                                  ? 0
                                                  : int.parse(payment.text),
                                              'paymentStatus':
                                                  paymentStatus.text,
                                              'reminder': reminder.text,
                                              'phoneNumber': sewNumber.text,
                                              'staffData':
                                                  selectedStaffSnapshot == null
                                                      ? {}
                                                      : (selectedStaffSnapshot
                                                              ?.data()
                                                          as Map)['staffData'],
                                              'customerData':
                                                  (selectedSnapshot?.data()
                                                      as Map)['customerData'],
                                              'customerName': (selectedSnapshot
                                                          ?.data()
                                                      as Map)['customerData']
                                                  ['firstName'],
                                              'fabrics': fabrics,
                                              'styles': styles,
                                            };
                                            uploadData(map);
                                            return;
                                          }
                                        } else {
                                          if (sewmap.isNotEmpty) {
                                            map = {
                                              'cost': cost.text.isEmpty
                                                  ? 0
                                                  : int.parse(cost.text),
                                              'createdAt': DateTime.now(),
                                              'duration': duration.text,
                                              'description':
                                                  sewDescription.text,
                                              'status': order.text,
                                              'title': sewTitle.text,
                                              'measurements': sewmap,
                                              'amountPaid': payment.text.isEmpty
                                                  ? 0
                                                  : int.parse(payment.text),
                                              'paymentStatus':
                                                  paymentStatus.text,
                                              'reminder': reminder.text,
                                              'phoneNumber': sewNumber.text,
                                              'staffData':
                                                  selectedStaffSnapshot == null
                                                      ? {}
                                                      : (selectedStaffSnapshot
                                                              ?.data()
                                                          as Map)['staffData'],
                                              'customerData':
                                                  (selectedSnapshot?.data()
                                                      as Map)['customerData'],
                                              'customerName': (selectedSnapshot
                                                          ?.data()
                                                      as Map)['customerData']
                                                  ['firstName'],
                                              'fabrics': fabrics,
                                              'styles': styles,
                                            };
                                            uploadData(map);
                                            return;
                                          } else {
                                            ProgressDialog.dismissDialog(
                                                context);
                                            map = {};
                                            buildErrorDialog(context, '',
                                                'Please Select atleast one measurement',
                                                () {
                                              Navigator.pop(context);
                                            });
                                            return;
                                          }
                                        }
                                      }
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 15),
                                      child: Image.asset(
                                        "images/save_sewing.png",
                                        fit: BoxFit.fill,
                                        height: 45.0,
                                        width: 25.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
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

  uploadData(map) async {
    var ownerId = (await getOwnerId());

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('sewings').doc();

    await FirebaseFirestore.instance
        .collection('sewings')
        .doc((widget.isFromEdit ?? false)
            ? widget.sewDetails?.id
            : documentReference.id)
        .set({
      'deletedForCustomer': false,
      'deletedForOwner': false,
      'customerId': (selectedSnapshot?.data() as Map)['customerId'],
      'staffId': selectedStaffSnapshot == null
          ? ''
          : (selectedStaffSnapshot?.data() as Map)['staffId'],
      'staffData': selectedStaffSnapshot == null
          ? {}
          : (selectedStaffSnapshot?.data() as Map)['staffData'],
      'sewingId': documentReference.id,
      'ownerId': ownerId.toString(),
      'sewingData': map,
    }, SetOptions(merge: true));
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Map<String?, List<Map<String, String>>> sewmap = new Map();

  bool loadPreviousMeasurement = false;
  DocumentSnapshot? loadPreviousSweDeails;

  DocumentSnapshot? snapshots;

  showDialogWithFields(parentname, parentId) async {
    bool isDataSorted = await checkDataSorted(parentId);
    _controllerMap.clear();
    if (loadPreviousMeasurement) {
      if (snapshots?.exists ?? false) {
        List list = (snapshots?.data() as Map)['sewingData']['measurements']
            [parentname];
        for (int i = 0; i < list.length; i++) {
          Map element = list[i];
          element.forEach((key, value) {
            var textEditor = TextEditingController(text: value);
            _controllerMap[key] = textEditor;
          });
        }
        List<Map<String, String>> list1 = [];
        _controllerMap.forEach((key, controller) {
          list1.add({key: controller.text});
        });

        sewmap[parentname] = list1;
      }
    }
    if ((widget.isFromEdit ?? false)) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('sewings')
          .doc(widget.sewDetails?.id)
          .get();
      if (snapshot.exists) {
        List? list =
            (snapshot.data() as Map)['sewingData']['measurements'][parentname];

        if (list != null) {
          for (int i = 0; i < list.length; i++) {
            var element = list[i];
            element.forEach((key, value) {
              var textEditor = TextEditingController(text: value);
              _controllerMap[key] = textEditor;
            });
          }
        } else {
          if (sewmap.isNotEmpty) {
            if (sewmap[parentname] != null) {
              sewmap[parentname]?.forEach((element) {
                element.forEach((key, value) {
                  var textEditor = TextEditingController(text: value);
                  _controllerMap[key] = textEditor;
                });
              });
            }
          }
        }
      }
    }
    Widget _okButton() {
      return ElevatedButton(
        onPressed: () async {
          if (isDataSorted) {
            List<Map<String, String>> list1 = [];
            _controllerMap.forEach((key, controller) {
              list1.add({key: controller.text});
            });

            sewmap[parentname] = list1;
          } else {
            DocumentReference doc_ref = FirebaseFirestore.instance
                .collection('measurementsRecord')
                .doc();
            print(ownerId);
            doc_ref.set({
              'id': doc_ref.id,
              'ownerId': ownerId,
              'parentId': parentId,
              'measurements': list
                  .map((e) =>
                      Reviews(name: e.data()['name'], value: '').toJson())
                  .toList()
            });
          }

          Navigator.pop(context);
        },
        child: const Text("OK"),
      );
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return AlertDialog(
            title: Text(parentname),
            content: Container(
                height: 500,
                width: 200,
                child: isDataSorted
                    ? _futureBuilder(parentname, parentId)
                    : _futureSortingBuilder(parentname, parentId, setState)),
            actions: [
              _okButton(),
            ],
          );
        });
      },
    );
  }

  Future<bool> checkDataSorted(parentId) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('measurementsRecord')
        .where('ownerId', isEqualTo: ownerId)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      bool isContain = querySnapshot.docs
          .where((element) => element.data()['parentId'] == parentId)
          .isNotEmpty;
      return isContain;
    }
    return false;
  }

  Widget _futureBuilder(parentname, parentId) {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance
          .collection('measurementsRecord')
          .where('parentId', isEqualTo: parentId)
          .get(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (!snapshot.hasData) {
          return const Align(
            alignment: Alignment.topCenter,
            child: Text("No item"),
          );
        }

        final data = snapshot.data!.docs;
        if (data.isNotEmpty) {
          List<dynamic> list = data.first.data()['measurements'];

          return ListView.builder(
            itemCount: list.length,
            shrinkWrap: true,
            padding: const EdgeInsets.all(5),
            itemBuilder: (BuildContext context, int index) {
              final controller = _getControllerOf(
                  parentname, (list[index] as Map).keys.first.toString());
              final textField = TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "${(list[index] as Map).keys.first.toString()}",
                  hintText: "${(list[index] as Map).keys.first.toString()}",
                ),
              );
              return Container(
                child: textField,
                padding: const EdgeInsets.only(bottom: 10),
              );
            },
          );
        } else {
          return const Align(
            alignment: Alignment.topCenter,
            child: Text("No item"),
          );
        }
      },
    );
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> list = [];

  Widget _futureSortingBuilder(parentname, parentId, setState) {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance
          .collection('measurementsList')
          .where('parentId', isEqualTo: parentId)
          .orderBy('createdAt', descending: false)
          .get(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (!snapshot.hasData) {
          return const Align(
            alignment: Alignment.topCenter,
            child: Text("No item"),
          );
        }
        list = snapshot.data?.docs ?? [];

        return StatefulBuilder(
            builder: (BuildContext context, StateSetter alertState) {
          return ReorderableListView(
            children: list
                .map((item) => ListTile(
                      key: Key("${item.data()['name']}"),
                      title: Text("${item.data()['name']}"),
                      trailing: const Icon(Icons.menu),
                    ))
                .toList(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(5),
            onReorder: (int oldIndex, int newIndex) {
              // dragging from top to bottom
              if (newIndex > list.length) {
                newIndex = list.length;
              }
              if (oldIndex < newIndex) newIndex -= 1;
              alertState(() {
                if (newIndex > oldIndex) {
                  newIndex -= 1;
                }
                final item = list.removeAt(oldIndex);
                list.insert(newIndex, item);
              });
            },
          );
        });
      },
    );
  }

  TextEditingController _getControllerOf(parentname, String name) {
    var country = _controllerMap[name];

    if (country == null) {
      country = TextEditingController(text: '');
      _controllerMap[name] = country;
    }
    return country;
  }

  Future<void> _showChoiceDialog(BuildContext context, isFabric) {
    return showDialog(
        context: context,
        builder: (BuildContext contexts) {
          return AlertDialog(
            title: const Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      _openGallery(context, isFabric);
                    },
                    title: const Text("Gallery"),
                    leading: const Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);

                      _openCamera(context, isFabric);
                    },
                    title: const Text("Camera"),
                    leading: const Icon(
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

  void _openGallery(BuildContext context, isFabric) async {
    final pickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      imageFile = pickedFile!;
    });
    if (imageFile != null) {
      File? file = await _cropImage();
      if (file != null) {
        if ((formatMB(await File(file.path).length())) < 3.0) {
          ProgressDialog.showLoaderDialog(context);
          uploadImageToFirebase(context, File(file.path), isFabric);
        } else {
          buildErrorDialog(context, '', 'Please select less than 3 MB Image',
              () {
            Navigator.pop(context);
          });
        }
      }
    }
  }

  void _openCamera(BuildContext context, isFabric) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );
    setState(() {
      imageFile = pickedFile!;
    });
    if (imageFile != null) {
      File? file = await _cropImage();
      if (file != null) {
        if ((formatMB(await File(file.path).length())) < 3.0) {
          ProgressDialog.showLoaderDialog(context);
          uploadImageToFirebase(context, File(file.path), isFabric);
        } else {
          buildErrorDialog(context, '', 'Please select less than 3 MB Image',
              () {
            Navigator.pop(context);
          });
        }
      }
    }
  }

  Future<File?> _cropImage() async {
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile!.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'Image Resize',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(
          title: 'Image Resize',
        ));
    return croppedFile;
  }

  double formatMB(bytes) {
    var marker = 1024; // Change to 1000 if required
    var decimal = 3; // Change as required
    var megaBytes = marker * marker; // One MB is 1024 KB

    print(((bytes / megaBytes) as double).toStringAsFixed(decimal));
    return double.parse(
        ((bytes / megaBytes) as double).toStringAsFixed(decimal));
  }

  Future uploadImageToFirebase(
      BuildContext context, File _imageFile, isFabric) async {
    var firebaseStorageRef = FirebaseStorage.instance.ref().child(
        'uploads/${await getOwnerId()}_${DateTime.now().microsecondsSinceEpoch.toString()}_${isFabric ? 'Fabric' : 'Style'}.png');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL().then(
      (value) {
        if (isFabric) {
          fabrics.add(value.toString());
        } else {
          styles.add(value.toString());
        }
        if (kDebugMode) {
          print("Done: $value");
        }

        setState(() {});
        ProgressDialog.dismissDialog(context);
      },
    ).catchError((onError) {
      ProgressDialog.dismissDialog(context);
    });
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('snapshots', snapshots));
  }
}

class Reviews {
  Reviews({
    required this.name,
    required this.value,
  });

  String name;
  String value;

  Map<String, dynamic> toJson() => {name: value};
}

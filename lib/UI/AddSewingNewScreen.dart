import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fashionpal/Utils/ProgressDialog.dart';
import 'package:fashionpal/Utils/sharPreference.dart';
import 'package:fashionpal/colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddSewingNewScreen extends StatefulWidget {
  final bool? isFromEdit, isFromCustomerScreen;
  final DocumentSnapshot? sewDetails;
  final QueryDocumentSnapshot? customerDocumentSnapshot;

  const AddSewingNewScreen(
      {Key? key,
      this.isFromEdit = false,
      this.sewDetails,
      this.isFromCustomerScreen,
      this.customerDocumentSnapshot})
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

  @override
  void initState() {
    getData();
    super.initState();
  }

  QuerySnapshot? snapshot;
  QueryDocumentSnapshot? selectedSnapshot;

  getData() async {
    snapshot = await FirebaseFirestore.instance
        .collection('customers')
        .where('ownerId', isEqualTo: await getOwnerId())
        .get();

    print(snapshot?.docs.length);
    if (widget.isFromCustomerScreen ?? false) {
      selectedSnapshot = widget.customerDocumentSnapshot;
    }
    if (widget.isFromEdit ?? false) {
      await FirebaseFirestore.instance
          .collection('customers')
          .where('customerId',
              isEqualTo: (widget.sewDetails?.data() as Map)['customerId'] ?? '')
          .get()
          .then((value) {
        print(value.docs.length);
        selectedSnapshot = value.docs.first;
      });

      sewTitle.text =
          (widget.sewDetails?.data() as Map)['sewingData']['title'] ?? '';
      sewDescription.text =
          (widget.sewDetails?.data() as Map)['sewingData']['description'] ?? '';
      duration.text =
          (widget.sewDetails?.data() as Map)['sewingData']['duration'] ?? '';
      cost.text =
          (widget.sewDetails?.data() as Map)['sewingData']['cost'] ?? '';
      order.text =
          (widget.sewDetails?.data() as Map)['sewingData']['status'] ?? '';
      payment.text =
          (widget.sewDetails?.data() as Map)['sewingData']['payment'] ?? '';
      reminder.text =
          (widget.sewDetails?.data() as Map)['sewingData']['reminder'] ?? '';
    }
    setState(() {});
  }

  Map<String, TextEditingController> _controllerMap = Map();
  List<String> fabrics = [];
  List<String> styles = [];

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
                        alignment: Alignment.centerLeft,
                        child: Text(
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
                        padding: EdgeInsets.only(),
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
                                  child: Text(
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
                              margin: EdgeInsets.only(top: 15),
                              child: DropdownSearch<QueryDocumentSnapshot>(
                                mode: Mode.MENU,
                                showSelectedItem: false,
                                items: snapshot?.docs,
                                label: "Select User",
                                hint: "Select",
                                enabled: (widget.isFromCustomerScreen ?? false)
                                    ? false
                                    : true,
                                selectedItem: selectedSnapshot,
                                itemAsString: (item) {
                                  return (item.data() as Map)['customerData']
                                          ['firstName'] +
                                      ' ' +
                                      (item.data() as Map)['customerData']
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
                                  margin: EdgeInsets.only(top: 15),
                                  child: TextField(
                                    controller: sewTitle,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
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
                                  margin: EdgeInsets.only(top: 15),
                                  child: TextField(
                                    controller: sewDescription,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
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
                                  margin: EdgeInsets.only(top: 15),
                                  child: TextField(
                                    controller: sewNumber,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
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
                              margin: EdgeInsets.only(top: 15),
                              child: DropdownSearch<String>(
                                mode: Mode.MENU,
                                showSelectedItem: false,
                                items: ["Staff1", "Staff2", "Staff3"],
                                label: "Select Staff",
                                hint: "Select",
                                // validator: (val) =>
                                // val == null? _snackbar("Select Height Unit") : null,
                                // onSaved: (newValue) {
                                //   _heightUnit=newValue;
                                // },
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
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
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Container(
                                            height: 20,
                                            child: Container(
                                                child: Text(
                                              "Measurement",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            )),
                                          ),
                                        ),
                                        FutureBuilder<
                                                QuerySnapshot<
                                                    Map<String, dynamic>>>(
                                            future: FirebaseFirestore.instance
                                                .collection(
                                                    'measurementsParent')
                                                .where('isActive',
                                                    isEqualTo: true)
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
                                              print(
                                                  snapshot.data?.docs.length ??
                                                      0);
                                              return Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    150,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10,
                                                      bottom: 5,
                                                      left: 10,
                                                      right: 10),
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    reverse: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Container(
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
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  showDialogWithFields(
                                                                      snapshot.data?.docs[index]
                                                                              .data()[
                                                                          'parentTitle'],
                                                                      snapshot
                                                                          .data
                                                                          ?.docs[
                                                                              index]
                                                                          .id);
                                                                },
                                                                child:
                                                                    Container(
                                                                  child: Icon(
                                                                      Icons
                                                                          .add),
                                                                ),
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
                                              Column(
                                                children: [
                                                  Text('Febric'),
                                                  GestureDetector(
                                                    onTap: () {
                                                      _showChoiceDialog(
                                                          context, true);
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                        top: 10,
                                                      ),
                                                      child: fabrics.isEmpty
                                                          ? Image.asset(
                                                              'images/ic_style.png',
                                                              width: 120,
                                                              height: 120,
                                                            )
                                                          : Container(
                                                              height: 120,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              child: ListView
                                                                  .builder(
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
                                                                  return Container(
                                                                    child: Image
                                                                        .network(
                                                                            fabrics[index]),
                                                                  );
                                                                },
                                                              ),
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
                                                  Text('Style'),
                                                  GestureDetector(
                                                    onTap: () {
                                                      _showChoiceDialog(
                                                          context, false);
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                        top: 10,
                                                      ),
                                                      child: styles.isEmpty
                                                          ? Image.asset(
                                                              'images/ic_style.png',
                                                              width: 120,
                                                              height: 120,
                                                            )
                                                          : Container(
                                                              height: 120,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              child: ListView
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
                                                                  return Container(
                                                                    child: Image
                                                                        .network(
                                                                            styles[index]),
                                                                  );
                                                                },
                                                              ),
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
                                    margin: EdgeInsets.only(top: 15),
                                    child: TextFormField(
                                      controller: duration,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                        ),
                                        hintText: 'Duration (In days)',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 15),
                                    child: TextFormField(
                                      controller: cost,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      decoration: InputDecoration(
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
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 15),
                                    child: DropdownSearch<String>(
                                      mode: Mode.MENU,
                                      showSelectedItem: false,
                                      items: [
                                        "ordered",
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
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 15),
                                    child: DropdownSearch<String>(
                                      mode: Mode.MENU,
                                      showSelectedItem: false,
                                      items: [
                                        "Partially payment",
                                        "No payment",
                                        "Full payment",
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
                          paymentStatus.text != 'Partially payment'
                              ? Container()
                              : Padding(
                                  padding:
                                      const EdgeInsets.only(left: 2, top: 10),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 15),
                                    child: TextFormField(
                                      controller: payment,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
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
                                    margin: EdgeInsets.only(top: 15),
                                    child: TextFormField(
                                      controller: reminder,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                        ),
                                        hintText: 'Reminder',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      ProgressDialog.showLoaderDialog(context);

                                      var ownerId = (await getOwnerId());

                                      Map map = {
                                        'cost': cost.text,
                                        'createdAt': DateTime.now(),
                                        'duration': duration.text,
                                        'description': sewDescription.text,
                                        'status': order.text,
                                        'title': sewTitle.text,
                                        'measurement': sewmap,
                                        'amountPaid': payment.text,
                                        'paymentStatus': paymentStatus.text,
                                        'reminder': reminder.text,
                                        'phoneNumber': sewNumber.text,
                                        'customerData': (selectedSnapshot
                                            ?.data() as Map)['customerData'],
                                      };

                                      DocumentReference documentReference =
                                          FirebaseFirestore.instance
                                              .collection('sewings')
                                              .doc();

                                      await FirebaseFirestore.instance
                                          .collection('sewings')
                                          .doc((widget.isFromEdit ?? false)
                                              ? widget.sewDetails?.id
                                              : documentReference.id)
                                          .set({
                                        'deletedForCustomer': false,
                                        'customerId': (selectedSnapshot?.data()
                                            as Map)['customerId'],
                                        'sewingId': documentReference.id,
                                        'ownerId': ownerId.toString(),
                                        'sewingData': map,
                                        'fabrics': fabrics,
                                        'styles': styles,
                                      }, SetOptions(merge: true));

                                      Navigator.of(context)
                                          .popUntil((route) => route.isFirst);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 15),
                                      child: Image.asset(
                                        "images/add_sewing.png",
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

  Map<String?, List<Map<String, String>>> sewmap = new Map();

  showDialogWithFields(parentname, parentId) async {
    if (widget.isFromEdit ?? false) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('sewings')
          .doc(widget.sewDetails?.id)
          .get();
      if (snapshot.exists) {
        List list =
            (snapshot.data() as Map)['sewingData']['measurement'][parentname];
        if (list != null) {
          for (int i = 0; i < list.length; i++) {
            var element = list[i];
            print('gets ' + element.values.length.toString());
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
    }
    Widget _okButton() {
      return ElevatedButton(
        onPressed: () async {
          List<Map<String, String>> list1 = [];
          _controllerMap.forEach((key, controller) {
            list1.add({key: controller.text});
          });

          sewmap[parentname] = list1;

          Navigator.pop(context);
        },
        child: Text("OK"),
      );
    }

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(parentname),
      content: Container(
          height: 500, width: 200, child: _futureBuilder(parentname, parentId)),
      actions: [
        _okButton(),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget _futureBuilder(parentname, parentId) {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance
          .collection('measurementsList')
          .where('parentId', isEqualTo: parentId)
          .get(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (!snapshot.hasData) {
          return Align(
            alignment: Alignment.topCenter,
            child: Text("No item"),
          );
        }

        final data = snapshot.data!;
        return ListView.builder(
          itemCount: data.docs.length,
          shrinkWrap: true,
          padding: EdgeInsets.all(5),
          itemBuilder: (BuildContext context, int index) {
            final controller =
                _getControllerOf(parentname, data.docs[index]['name']);
            final textField = TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "${data.docs[index]['name']}",
                hintText: "${data.docs[index]['name']}",
              ),
            );
            return Container(
              child: textField,
              padding: EdgeInsets.only(bottom: 10),
            );
          },
        );
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
                      _openGallery(context, isFabric);
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

                      _openCamera(context, isFabric);
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

  void _openGallery(BuildContext context, isFabric) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile = pickedFile!;
    });
    if (imageFile != null) {
      ProgressDialog.showLoaderDialog(context);
      uploadImageToFirebase(context, File(imageFile!.path), isFabric);
    }
  }

  void _openCamera(BuildContext context, isFabric) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile!;
    });
    if (imageFile != null) {
      ProgressDialog.showLoaderDialog(context);
      uploadImageToFirebase(context, File(imageFile!.path), isFabric);
    }
  }

  Future uploadImageToFirebase(
      BuildContext context, File _imageFile, isFabric) async {
    var firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads');
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
}

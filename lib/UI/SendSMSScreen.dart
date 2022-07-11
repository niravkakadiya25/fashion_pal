import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fashionpal/Utils/sharPreference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';

import '../colors.dart';

class SendSMSScreen extends StatefulWidget {
  @override
  _SendSMSScreen createState() => _SendSMSScreen();
}

class _SendSMSScreen extends State<SendSMSScreen> {
  String otp_ = "";
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  TextEditingController msgController = TextEditingController();
  QuerySnapshot? customersSnapshot;
  List<DocumentSnapshot> selectedCustomersSnapshot = [];

  @override
  void initState() {
    getCustomer();
    super.initState();
  }

  getCustomer() async {
    customersSnapshot = await FirebaseFirestore.instance
        .collection('customers')
        .where('ownerId', isEqualTo: await getOwnerId())
        .get();
    setState(() {});
  }

  final _multiKey = GlobalKey<DropdownSearchState<String>>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            key: scaffoldKey,
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
                  "Send SMS",
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                backgroundColor: appTheme,
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                  child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        top: 80, bottom: 10, right: 50, left: 50),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 30),
                            child: Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      child: Text(
                                        "Send SMS",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 40),
                            child: (customersSnapshot?.docs.isEmpty ?? true)
                                ? Container()
                                : DropdownSearch<
                                    DocumentSnapshot>.multiSelection(
                                    key: _multiKey,
                                    validator: (List<DocumentSnapshot>? v) {
                                      return v == null || v.isEmpty
                                          ? "required field"
                                          : null;
                                    },
                                    dropdownBuilder: (context, selectedItems) {
                                      Widget item(String i) => Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 2, vertical: 7),
                                            padding: EdgeInsets.only(left: 10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Theme.of(context)
                                                    .primaryColorLight),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  i,
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2,
                                                ),
                                                MaterialButton(
                                                  height: 5,
                                                  shape: const CircleBorder(),
                                                  focusColor: Colors.red[200],
                                                  hoverColor: Colors.red[200],
                                                  padding: EdgeInsets.all(0),
                                                  minWidth: 20,
                                                  onPressed: () {
                                                    _multiKey.currentState
                                                        ?.removeItem(i);
                                                  },
                                                  child: Icon(
                                                    Icons.close_outlined,
                                                    size: 20,
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                      return Wrap(
                                        children: selectedItems
                                            .map((e) => item((e.data()
                                                    as Map)['customerData']
                                                ['firstName']))
                                            .toList(),
                                      );
                                    },
                                    popupCustomMultiSelectionWidget:
                                        (context, list) {
                                      return Flexible(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            OutlinedButton(
                                              onPressed: () {
                                                // How should I unselect all items in the list?
                                                _multiKey.currentState
                                                    ?.closeDropDownSearch();
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                            OutlinedButton(
                                              onPressed: () {
                                                // How should I select all items in the list?
                                                _multiKey.currentState
                                                    ?.popupSelectAllItems();
                                              },
                                              child: const Text('All'),
                                            ),
                                            OutlinedButton(
                                              onPressed: () {
                                                // How should I unselect all items in the list?
                                                _multiKey.currentState
                                                    ?.popupDeselectAllItems();
                                              },
                                              child: const Text('None'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    dropdownSearchDecoration: InputDecoration(
                                      hintText: "Customer Selection",
                                      labelText: "Customer Selection",
                                      contentPadding:
                                          EdgeInsets.fromLTRB(12, 12, 0, 0),
                                      border: OutlineInputBorder(),
                                    ),
                                    mode: Mode.MENU,
                                    items: customersSnapshot?.docs,
                                    itemAsString: (item) {
                                      return ((item?.data()
                                          as Map)['customerData']['firstName']);
                                    },
                                    showClearButton: true,
                                    onChanged: (value) {
                                      selectedCustomersSnapshot = value;
                                    },
                                    popupSelectionWidget: (cnt,
                                        DocumentSnapshot item,
                                        bool isSelected) {
                                      return isSelected
                                          ? Icon(
                                              Icons.check_circle,
                                              color: Colors.green[500],
                                            )
                                          : Container();
                                    },
                                    clearButtonSplashRadius: 20,
                                  ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: TextFormField(
                              controller: msgController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  filled: true,
                                  hintStyle: new TextStyle(color: Colors.grey),
                                  hintText: "Message",
                                  fillColor: Colors.white),
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(
                                  top: 40, left: 40, right: 40),
                              child: InkWell(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: getImageAssets(),
                                ),
                                onTap: () {
                                  List<String> numbers = [];
                                  for (var element
                                      in selectedCustomersSnapshot) {
                                    numbers.add((element.data()
                                        as Map)['customerData']['phoneNumber']);
                                  }

                                  _sendSMS(msgController.text, numbers);
                                },
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
            )));
  }

  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }
}

Widget getImageAssets() {
  AssetImage assetImage = const AssetImage('images/ic_send.png');
  Image image = Image(image: assetImage, width: 100.0, height: 40.0);
  return Container(child: image);
}

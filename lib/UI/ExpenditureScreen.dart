import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fashionpal/Utils/constants.dart';
import 'package:fashionpal/Utils/sharPreference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../colors.dart';

class ExpenditureScreen extends StatefulWidget {
  _ExpenditureScreenState createState() => new _ExpenditureScreenState();
}

class _ExpenditureScreenState extends State<ExpenditureScreen> {
  @override
  void initState() {
    getCategories();
    super.initState();
  }

  double expenditures = 0;

  bool isLoading = true;
  List expenseCategories = [];
  QuerySnapshot<Map<String, dynamic>>? expenseDocumentSnapshot;

  getCategories() async {
    expenseDocumentSnapshot = await FirebaseFirestore.instance
        .collection('expenditures')
        .where('ownerId', isEqualTo: await getOwnerId())
        .get();
    if (expenseDocumentSnapshot?.docs.isNotEmpty ?? false) {
      for (var element in expenseDocumentSnapshot!.docs) {
        if (kDebugMode) {
          print(element.data());
        }
        expenditures =
            expenditures + int.parse(element.data()['amount'].toString());
      }
    }

    QuerySnapshot<Map<String, dynamic>> expenseCategoriesDocumentSnapshot =
        await FirebaseFirestore.instance
            .collection('expenditureCategories')
            .where('isActive', isEqualTo: true)
            .get();

    if (expenseCategoriesDocumentSnapshot.docs.isNotEmpty) {
      for (var element in expenseCategoriesDocumentSnapshot.docs) {
        expenseCategories.add((element.data())['categoryName']);
        isLoading = false;
        setState(() {});
      }
    }
    isLoading = false;
  }

  TextEditingController amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              iconTheme: IconThemeData(
                color: Colors.white, //change your color here
              ),
              centerTitle: true,
              title: Text(
                "Expenditure",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              backgroundColor: Colors.blue,
            )),
        body: isLoading
            ? Container(
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : _build(context));
  }

  var expenditureType = '';
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  Widget _build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 40),
                child: DropdownSearch<dynamic>(
                  mode: Mode.MENU,
                  showSelectedItem: false,
                  items: expenseCategories,
                  label: "Select Expenditure",
                  hint: "Select Type",
                  selectedItem: expenditureType,
                  onChanged: (value) {
                    expenditureType = value;
                    setState(() {});
                  },
                  // validator: (val) =>
                  // val == null? _snackbar("Select Height Unit") : null,
                  // onSaved: (newValue) {
                  //   _heightUnit=newValue;
                  // },
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: TextField(
                  controller: amount,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    hintText: 'Amount',
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (expenditureType.isNotEmpty) {
                    DocumentReference<Map<String, dynamic>> ref =
                        FirebaseFirestore.instance
                            .collection('expenditures')
                            .doc();
                    await ref.set({
                      'amount': amount.text.trim().toString(),
                      'category': expenditureType,
                      'createdAt': DateTime.now(),
                      'ownerId': await getOwnerId(),
                      'searchMatch': expenditureType.toLowerCase(),
                      'id': ref.id,
                    }, SetOptions(merge: true));
                    Navigator.pop(context);
                  } else {
                    buildErrorDialog(
                        context, '', 'PLease Select Expenditure category', () {
                      Navigator.pop(context);
                    });
                  }
                },
                child: Container(
                  width: 100,
                  height: 35,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin: EdgeInsets.only(bottom: 10, top: 10),
                  child: Center(
                    child: Text(
                      'Add Expenditure',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              expenseDocumentSnapshot?.docs.length == 0
                  ? Container()
                  : Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(''),
                              Text('category'),
                              Text('Date'),
                              Text('Amount'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Visibility(
                            visible: false,
                            child: Row(
                              children: [
                                Icon(Icons.edit),
                                Icon(Icons.delete),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: expenseDocumentSnapshot?.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Timestamp timeStamp =
                      expenseDocumentSnapshot?.docs[index].data()['createdAt'];
                  return Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text((index + 1).toString()),
                              Text(expenseDocumentSnapshot?.docs[index]
                                      .data()['category']
                                      .toString() ??
                                  ''),
                              Text(formatter
                                  .format(DateTime.fromMicrosecondsSinceEpoch(
                                      timeStamp.microsecondsSinceEpoch))
                                  .toString()),
                              Text(expenseDocumentSnapshot?.docs[index]
                                      .data()['amount']
                                      .toString() ??
                                  ''),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              GestureDetector(
                                child: Icon(Icons.edit),
                                onTap: () {
                                  var expenditureType1 = expenseDocumentSnapshot
                                      ?.docs[index]
                                      .data()['category'];
                                  TextEditingController amount1 =
                                      TextEditingController(
                                          text: expenseDocumentSnapshot
                                              ?.docs[index]
                                              .data()['amount']);

                                  Widget okButton = TextButton(
                                    child: Text("Edit"),
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      DocumentReference<Map<String, dynamic>>
                                          ref = FirebaseFirestore.instance
                                              .collection('expenditures')
                                              .doc(expenseDocumentSnapshot
                                                  ?.docs[index].id);
                                      await ref.set({
                                        'amount':
                                            amount1.text.trim().toString(),
                                        'category': expenditureType1,
                                        'updateAt': DateTime.now(),
                                        'ownerId': await getOwnerId(),
                                        'searchMatch':
                                            expenditureType1.toLowerCase(),
                                      }, SetOptions(merge: true));

                                      isLoading = true;
                                      setState(() {});
                                      getCategories();
                                    },
                                  );
                                  Widget cancelButton = TextButton(
                                    child: Text("cancel"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  );

                                  // set up the AlertDialog
                                  AlertDialog alert = AlertDialog(
                                    title: Text("Edit"),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 40),
                                          child: DropdownSearch<dynamic>(
                                            mode: Mode.MENU,
                                            showSelectedItem: false,
                                            items: expenseCategories,
                                            label: "Select Expenditure",
                                            hint: "Select Type",
                                            selectedItem: expenditureType1,
                                            onChanged: (value) {
                                              expenditureType1 = value;
                                              setState(() {});
                                            },
                                            // validator: (val) =>
                                            // val == null? _snackbar("Select Height Unit") : null,
                                            // onSaved: (newValue) {
                                            //   _heightUnit=newValue;
                                            // },
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          child: TextField(
                                            controller: amount1,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.red),
                                              ),
                                              hintText: 'Amount',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      okButton,
                                      cancelButton,
                                    ],
                                  );

                                  // show the dialog
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return alert;
                                    },
                                  );
                                },
                              ),
                              GestureDetector(
                                  onTap: () {
                                    // set up the button
                                    Widget okButton = TextButton(
                                      child: Text("Yes"),
                                      onPressed: () async {
                                        expenseDocumentSnapshot?.docs
                                            .removeAt(index);
                                        Navigator.pop(context);
                                        await FirebaseFirestore.instance
                                            .collection('expenditures')
                                            .doc(expenseDocumentSnapshot
                                                ?.docs[index].id)
                                            .delete();
                                        isLoading = true;
                                        setState(() {});
                                        getCategories();
                                      },
                                    );
                                    Widget cancelButton = TextButton(
                                      child: Text("cancel"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    );

                                    // set up the AlertDialog
                                    AlertDialog alert = AlertDialog(
                                      title: Text(""),
                                      content: Text("Are you sure to remove?"),
                                      actions: [
                                        okButton,
                                        cancelButton,
                                      ],
                                    );

                                    // show the dialog
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return alert;
                                      },
                                    );
                                  },
                                  child: Icon(Icons.delete)),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          )),
    );
  }

  Widget getImageAssets() {
    AssetImage assetImage = AssetImage('images/add_staff.png');
    Image image = Image(image: assetImage, width: 180.0, height: 100.0);
    return Container(child: image);
  }
}

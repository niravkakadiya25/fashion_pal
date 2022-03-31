import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionpal/UI/ExpenditureScreen.dart';
import 'package:fashionpal/UI/partiallyPaymentScreen.dart';
import 'package:fashionpal/Utils/sharPreference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../BouncyPageRoute.dart';
import '../colors.dart';
import 'SewingItem.dart';

class FinanceScreen extends StatefulWidget {
  _FinanceScreenState createState() => new _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  double expenditures = 0;
  double income = 0;
  double invoice = 0;

  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  TextEditingController selectedDateController = TextEditingController();

  DateTime? startDate, endDate;

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      startDate = args.value.startDate;
      endDate = args.value.endDate;
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  QuerySnapshot<Map<String, dynamic>>? expenseDocumentSnapshot;
  QuerySnapshot<Map<String, dynamic>>? incomeDocumentSnapshot;
  QuerySnapshot? querySnapshot;

  getFinanceData() async {
    expenseDocumentSnapshot = await FirebaseFirestore.instance
        .collection('expenditures')
        .where('ownerId', isEqualTo: await getOwnerId())
        .get();

    incomeDocumentSnapshot = await FirebaseFirestore.instance
        .collection('finances')
        .where('ownerId', isEqualTo: await getOwnerId())
        .get();
    querySnapshot = await FirebaseFirestore.instance
        .collection('sewings')
        .where('ownerId', isEqualTo: await getOwnerId())
        .get();

    getSewingData();
  }

  List<QueryDocumentSnapshot> partialList = [];
  List<QueryDocumentSnapshot> noPaymentList = [];
  int noPaymentTotal = 0;
  dynamic noPaymentAmount = 0;
  dynamic partialPaymentAmount = 0;
  int partialPaymentTotal = 0;

  getSewingData() async {
    expenditures = 0;
    income = 0;
    invoice = 0;
    partialPaymentAmount = 0;
    noPaymentTotal = 0;
    partialPaymentTotal = 0;

    partialList.clear();
    noPaymentList.clear();

    if (expenseDocumentSnapshot?.docs.isNotEmpty ?? false) {
      for (var element in expenseDocumentSnapshot!.docs) {
        if (kDebugMode) {
          print(element.data());
        }
        Timestamp timeStamp = element.data()['createdAt'];

        if (startDate != null) {
          if (startDate!.isAfter(DateTime.fromMicrosecondsSinceEpoch(
              timeStamp.microsecondsSinceEpoch))) {
            if (endDate!.isBefore(DateTime.fromMicrosecondsSinceEpoch(
                timeStamp.microsecondsSinceEpoch))) {
              expenditures =
                  expenditures + int.parse(element.data()['amount'].toString());
            }
          }
        } else {
          expenditures =
              expenditures + int.parse(element.data()['amount'].toString());
        }
      }
    }
    if (incomeDocumentSnapshot?.docs.isNotEmpty ?? false) {
      for (var element in incomeDocumentSnapshot!.docs) {
        Timestamp timeStamp = element.data()['createdAt'];
        if (kDebugMode) {
          print(element.data());
        }
        (element.data()['data'] as Map).forEach((key, value) {
          if (startDate != null) {
            if (startDate!.isAfter(DateTime.fromMicrosecondsSinceEpoch(
                timeStamp.microsecondsSinceEpoch))) {
              if (endDate!.isBefore(DateTime.fromMicrosecondsSinceEpoch(
                  timeStamp.microsecondsSinceEpoch))) {
                income = income +
                    (value['income'] == null
                        ? 0
                        : int.parse(value['income'].toString()));
                invoice = invoice +
                    (value['invoice'] == null
                        ? 0
                        : int.parse(value['invoice'].toString()));
              }
            }
          } else {
            income = income +
                (value['income'] == null
                    ? 0
                    : int.parse(value['income'].toString()));
            invoice = invoice +
                (value['invoice'] == null
                    ? 0
                    : int.parse(value['invoice'].toString()));
          }
        });
      }
    }
    if (mounted) setState(() {});
    if (querySnapshot?.docs.isNotEmpty ?? false) {
      for (var element in querySnapshot!.docs) {
        if (element.exists) {
          if (element.data() != null) {
            if ((element.data() as Map)['sewingData'] != null) {
              Timestamp timeStamp =
                  (element.data() as Map)['sewingData']['createdAt'];
              if (startDate != null) {
                if (startDate!.isAfter(DateTime.fromMicrosecondsSinceEpoch(
                    timeStamp.microsecondsSinceEpoch))) {
                  if (endDate!.isBefore(DateTime.fromMicrosecondsSinceEpoch(
                      timeStamp.microsecondsSinceEpoch))) {
                    if (((element.data() as Map)['sewingData']['amountPaid']) !=
                        null) {
                      if ((element.data() as Map)['sewingData']['amountPaid']
                          .toString()
                          .isNotEmpty) {
                        if (int.parse((element.data() as Map)['sewingData']
                                    ['amountPaid']
                                .toString()) ==
                            0) {
                          noPaymentAmount = noPaymentAmount +
                              ((element.data() as Map)['sewingData']['cost']
                                  .toString());
                          noPaymentList.add(element);
                        } else {
                          if ((((element.data() as Map)['sewingData']
                                      ['amountPaid']
                                  .toString())) !=
                              ((element.data() as Map)['sewingData']['cost']
                                  .toString())) {
                            partialPaymentAmount = partialPaymentAmount +
                                (int.parse((element.data() as Map)['sewingData']
                                        ['amountPaid']
                                    .toString()));
                            partialList.add(element);
                          }
                        }
                      } else {
                        noPaymentAmount = noPaymentAmount +
                            ((element.data() as Map)['sewingData']['cost']
                                .toString());
                        noPaymentList.add(element);
                      }
                    } else {
                      noPaymentAmount = noPaymentAmount +
                          ((element.data() as Map)['sewingData']['cost']
                              .toString());
                      print('object2');
                      noPaymentList.add(element);
                    }
                  }
                }
              } else {
                if (((element.data() as Map)['sewingData']['amountPaid']) !=
                    null) {
                  print('object41');
                  if ((element.data() as Map)['sewingData']['amountPaid']
                      .toString()
                      .isNotEmpty) {
                    if (int.parse((element.data() as Map)['sewingData']
                                ['amountPaid']
                            .toString()) ==
                        0) {
                      print('object1');
                      noPaymentAmount = noPaymentAmount +
                          ((element.data() as Map)['sewingData']['cost']
                              .toString());
                      noPaymentList.add(element);
                    } else {
                      if ((((element.data() as Map)['sewingData']['amountPaid']
                              .toString())) !=
                          ((element.data() as Map)['sewingData']['cost']
                              .toString())) {
                        partialPaymentAmount = partialPaymentAmount +
                            (int.parse((element.data() as Map)['sewingData']
                                    ['amountPaid']
                                .toString()));
                        partialList.add(element);
                      }
                    }
                  } else {
                    noPaymentAmount = noPaymentAmount +
                        ((element.data() as Map)['sewingData']['cost']
                            .toString());
                    print('object4');
                    noPaymentList.add(element);
                  }
                } else {
                  noPaymentAmount = noPaymentAmount +
                      ((element.data() as Map)['sewingData']['cost']
                          .toString());
                  print('object2');
                  noPaymentList.add(element);
                }
              }
            }
          }
        }
      }
    }
    getTotal();
  }

  getTotal() {
    for (var element in noPaymentList) {
      noPaymentTotal = (element.data() as Map)[''];
    }
    noPaymentTotal = noPaymentList.length;
    partialPaymentTotal = partialList.length;
  }

  final DateFormat formatter = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    // TODO: implement initState
    selectedDateController.text = formatter.format(DateTime.now()).toString() +
        "-" +
        formatter.format(DateTime.now()).toString();
    getFinanceData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 40, bottom: 10, right: 80, left: 80),
            child: TextFormField(
              readOnly: true,
              onTap: () => showCustomDialog(context),
              controller: selectedDateController,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                      color: appTheme,
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                      color: appTheme,
                      width: 2.0,
                    ),
                  ),
                  hintStyle: new TextStyle(color: appTheme),
                  hintText: "  Jan 2022",
                  fillColor: Colors.white),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 5),
                    height: 100,
                    child: Image.asset(
                      "images/income.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 105,
                    child: Center(
                      child: Text(
                        income.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () async {
                  await Navigator.push(
                      context, BouncyPageRoute(widget: ExpenditureScreen()));
                  getFinanceData();
                },
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 5),
                      height: 100,
                      child: Image.asset(
                        "images/expediture.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 105,
                      child: Center(
                        child: Text(
                          expenditures.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PartialPaymentScreen(
                          list: partialList,
                          isPartial: true,
                        ),
                      ));
                },
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 5),
                      height: 100,
                      child: Image.asset(
                        "images/partial.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 105,
                      child: Center(
                        child: Text(
                          partialPaymentAmount.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PartialPaymentScreen(
                          list: noPaymentList,
                          isPartial: false,
                        ),
                      ));
                },
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 5),
                      height: 100,
                      child: Image.asset(
                        "images/no_payment.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 105,
                      child: Center(
                        child: Text(
                          noPaymentAmount.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.all(20),
            height: 1,
            color: Colors.grey,
          ),
          Container(
            margin: EdgeInsets.only(left: 40, top: 20, right: 40, bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(children: [
                  Container(
                    width: 80,
                    child: SfCartesianChart(
                        // Initialize category axis
                        primaryXAxis: CategoryAxis(),
                        enableAxisAnimation: false,
                        series: <StackedColumnSeries<SalesData, String>>[
                          StackedColumnSeries(
                              color: Colors.yellow,
                              dataSource: <SalesData>[
                                SalesData('', invoice),
                              ],
                              xValueMapper: (SalesData sales, _) => sales.year,
                              yValueMapper: (SalesData sales, _) =>
                                  sales.sales),
                        ]),
                  ),
                  Container(
                      child: Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                        child: Text("Invoice",
                            style:
                                TextStyle(fontSize: 16, color: Colors.black)),
                        onTap: () {
                          // Navigator.push(context,
                          //     new BouncyPageRoute(widget: Signup()));
                        }),
                  )),
                  Container(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                          child: Text("(c)", style: TextStyle(fontSize: 14)),
                          onTap: () {
                            // Navigator.push(context,
                            //     BouncyPageRoute(widget: SignUpScreen()));
                          }),
                    ),
                  ),
                ]),
                Column(children: [
                  Container(
                    width: 80,
                    child: SfCartesianChart(
                        // Initialize category axis
                        primaryXAxis: CategoryAxis(),
                        enableAxisAnimation: false,
                        series: <StackedColumnSeries<SalesData, String>>[
                          StackedColumnSeries(
                              color: Colors.green,
                              dataSource: <SalesData>[
                                SalesData('', income),
                              ],
                              xValueMapper: (SalesData sales, _) => sales.year,
                              yValueMapper: (SalesData sales, _) =>
                                  sales.sales),
                        ]),
                  ),
                  Container(
                      child: Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                        child: Text("Income",
                            style:
                                TextStyle(fontSize: 16, color: Colors.black)),
                        onTap: () {
                          // Navigator.push(context,
                          //     new BouncyPageRoute(widget: Signup()));
                        }),
                  )),
                  Container(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                          child: Text("(c)", style: TextStyle(fontSize: 14)),
                          onTap: () {
                            // Navigator.push(context,
                            //     BouncyPageRoute(widget: SignUpScreen()));
                          }),
                    ),
                  ),
                ]),
                Column(children: [
                  Container(
                    width: 80,
                    child: SfCartesianChart(
                        // Initialize category axis
                        primaryXAxis: CategoryAxis(),
                        enableAxisAnimation: false,
                        series: <StackedColumnSeries<SalesData, String>>[
                          StackedColumnSeries(
                              color: Colors.red,
                              dataSource: <SalesData>[
                                SalesData('', expenditures),
                              ],
                              xValueMapper: (SalesData sales, _) => sales.year,
                              yValueMapper: (SalesData sales, _) =>
                                  sales.sales),
                        ]),
                  ),
                  Container(
                      child: Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                        child: Text("Expenditure",
                            style:
                                TextStyle(fontSize: 16, color: Colors.black)),
                        onTap: () {
                          // Navigator.push(context,
                          //     new BouncyPageRoute(widget: Signup()));
                        }),
                  )),
                  Container(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                          child: Text("(c)", style: TextStyle(fontSize: 14)),
                          onTap: () {
                            // Navigator.push(context,
                            //     BouncyPageRoute(widget: SignUpScreen()));
                          }),
                    ),
                  ),
                ]),
              ],
            ),
          )
        ],
      )),
    ));
  }

  void showCustomDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("OK",
          style: TextStyle(
            color: Colors.black,
            decorationColor: Colors.black,
          )),
      onPressed: () {
        selectedDateController.text = _range;
        setState(() {});
        Navigator.pop(context);
      },
    );

    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            height: 450,
            child: SizedBox.expand(
                child: Column(
              children: [
                SfDateRangePicker(
                  onSelectionChanged: _onSelectionChanged,
                  selectionMode: DateRangePickerSelectionMode.range,
                  initialSelectedRange: PickerDateRange(
                      DateTime.now().subtract(const Duration(days: 4)),
                      DateTime.now().add(const Duration(days: 3))),
                ),
                okButton,
              ],
            )),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(40)),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  Widget getImageAssets() {
    AssetImage assetImage = AssetImage('images/logo.png');
    Image image = Image(image: assetImage, width: 100.0, height: 100.0);
    return Container(child: image);
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

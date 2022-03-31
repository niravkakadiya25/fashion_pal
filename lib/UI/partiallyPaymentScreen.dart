import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionpal/Utils/sharPreference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PartialPaymentScreen extends StatefulWidget {
  final List<QueryDocumentSnapshot> list;
  final bool isPartial;

  const PartialPaymentScreen(
      {Key? key, required this.list, required this.isPartial})
      : super(key: key);

  @override
  _PartialPaymentScreenState createState() => _PartialPaymentScreenState();
}

class _PartialPaymentScreenState extends State<PartialPaymentScreen> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  List<QueryDocumentSnapshot> list = [];

  bool isLoading = true;
  var totalRemaining = 0.0;

  getData() async {
    totalRemaining = 0.0;
    list.clear();
    list = widget.list;
    isLoading = false;
    print(list.length);

    if (widget.isPartial) {
      for (var document in list) {
        String value = ((((document.data() as Map)['sewingData']['cost']
                        .toString()
                        .isEmpty
                    ? 0
                    : (int.parse(
                        ((document.data() as Map)['sewingData']['cost'] ?? 0)
                            .toString()))) -
                ((document.data() as Map)['sewingData']['amountPaid']
                        .toString()
                        .isEmpty
                    ? 0
                    : (int.parse(((document.data() as Map)['sewingData']
                            ['amountPaid'] ??
                        0)))))
            .toStringAsPrecision(2));
        totalRemaining = totalRemaining + double.parse(value);
      }
    } else {
      for (var document in list) {
        String value =
            (document.data() as Map)['sewingData']['cost'].toString();
        totalRemaining = totalRemaining + double.parse(value);
      }
    }
    setState(() {});
  }

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
              widget.isPartial ? "Partially Payment" : 'No Payments',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            backgroundColor: Colors.blue,
          )),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    DataTable(
                      checkboxHorizontalMargin: 0,
                      horizontalMargin: 0,
                      sortColumnIndex: 0,
                      columns: [
                        DataColumn(
                          label: Container(
                            child: Text("NAME"),
                          ),
                          numeric: false,
                          tooltip: "Customer Name",
                        ),
                        DataColumn(
                          label: Container(
                            child: Text("Phone number"),
                          ),
                          numeric: true,
                          tooltip: "Phone number",
                        ),
                        DataColumn(
                          label: Container(child: Text("Sewing title")),
                          numeric: false,
                          tooltip: "Sewing title",
                        ),
                        DataColumn(
                          label: Text("Cost of Sewing"),
                          numeric: false,
                          tooltip: "Cost of Sewing",
                        ),
                        DataColumn(
                          label: Text("Amount Paid"),
                          numeric: false,
                          tooltip: "Amount Paid",
                        ),
                        DataColumn(
                          label: Text("Amount Remaining"),
                          numeric: false,
                          tooltip: "Amount Remaining",
                        ),
                      ],
                      rows: list
                          .map(
                            (document) => DataRow(cells: [
                              DataCell(
                                Text(((document.data() as Map)['sewingData']
                                                ['customerData']['firstName'] ??
                                            '') +
                                        (document.data() as Map)['sewingData']
                                            ['customerData']['firstName'] ??
                                    ''),
                              ),
                              DataCell(
                                Text((document.data() as Map)['sewingData']
                                        ['customerData']['phoneNumber'] ??
                                    ''),
                              ),
                              DataCell(
                                Text((document.data() as Map)['sewingData']
                                        ['title'] ??
                                    ''),
                              ),
                              DataCell(
                                Text((document.data() as Map)['sewingData']
                                        ['cost']
                                    .toString()),
                              ),
                              DataCell(
                                Text((document.data() as Map)['sewingData']
                                        ['amountPaid']
                                    .toString()),
                              ),
                              DataCell(
                                Text((((document.data() as Map)['sewingData']['cost']
                                                .toString()
                                                .isEmpty
                                            ? 0
                                            : (int.parse(
                                                ((document.data() as Map)['sewingData']['cost'] ?? 0)
                                                    .toString()))) -
                                        ((document.data() as Map)['sewingData']
                                                    ['amountPaid']
                                                .toString()
                                                .isEmpty
                                            ? 0
                                            : (int.parse(((document.data()
                                                            as Map)['sewingData']
                                                        ['amountPaid'] ??
                                                    0)
                                                .toString()))))
                                    .toString()),
                              ),
                            ]),
                          )
                          .toList(),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.only(right: 50),
                        child: Text(
                          'Total:- ' + totalRemaining.toString(),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

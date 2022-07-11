import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionpal/UI/AddSewingNewScreen.dart';
import 'package:fashionpal/UI/StaffItem.dart';
import 'package:fashionpal/Utils/sharPreference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../BouncyPageRoute.dart';
import '../colors.dart';
import 'SewingItem.dart';

class SewingScreen extends StatefulWidget {
  final bool isSearching;
  final String? query;

  const SewingScreen({Key? key, this.isSearching = false, this.query})
      : super(key: key);

  @override
  _SewingScreenState createState() => _SewingScreenState();
}

class _SewingScreenState extends State<SewingScreen> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _build(context));
  }

  dynamic userId;

  @override
  void initState() {
    getData();
    super.initState();
  }

  List<QueryDocumentSnapshot>? sewingSnapshot;
  List<QueryDocumentSnapshot>? searchSewingSnapshot;
  List<QueryDocumentSnapshot>? customerSnapshot;

  Future<void> getData() async {
    userId = await getOwnerId();
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('sewings')
        .where("ownerId", isEqualTo: userId)
        .get();
    if (snapshot.docs.isEmpty) {
      sewingSnapshot = [];
    } else {
      sewingSnapshot = [];
      sewingSnapshot?.addAll(snapshot.docs);
    }

    QuerySnapshot snapshot1 = await FirebaseFirestore.instance
        .collection('customers')
        .where("ownerId", isEqualTo: userId)
        .get();
    if (snapshot.docs.isEmpty) {
      customerSnapshot = [];
    } else {
      customerSnapshot = [];
      customerSnapshot?.addAll(snapshot1.docs);
    }

    setState(() {});
  }

  Widget getSearchData() {
    searchSewingSnapshot = [];
    sewingSnapshot?.forEach((element) {
      if (((element.data() as Map)['sewingData']['title'])
              .toString()
              .toLowerCase()
              .contains((widget.query ?? '').toString().toLowerCase()) ||
          (((element.data() as Map)['sewingData']['customerData']) == null
                  ? ''
                  : (((element.data() as Map)['sewingData']['customerData']
                          ['firstName']) ??
                      ''))
              .toString()
              .toLowerCase()
              .contains((widget.query ?? '').toString().toLowerCase()) ||
          (((element.data() as Map)['sewingData']['customerData']) == null
                  ? ''
                  : ((element.data() as Map)['sewingData']['customerData']
                              ['phoneNumber'] ??
                          '')
                      .toString())
              .toLowerCase()
              .contains((widget.query ?? '').toString().toLowerCase())) {
        searchSewingSnapshot?.add(element);
      }
    });
    return item(searchSewingSnapshot);
  }

  Widget _build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
              height: 30,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.only(right: 35),
                color: plancolor,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                        'Customers:-' +
                            (customerSnapshot?.length.toString() ?? '0'),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                        'Sewings:-' +
                            (sewingSnapshot?.length.toString() ?? '0'),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ],
                ),
              )),
        ),
        Container(
          margin: EdgeInsets.only(top: 35),
          child: widget.isSearching
              ? getSearchData()
              : sewingSnapshot == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : (sewingSnapshot?.isEmpty ?? true)
                      ? Center(
                          child: Text('No Customer'),
                        )
                      : Container(
                          child: GridView.builder(
                            itemCount: sewingSnapshot?.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 1,
                                    mainAxisSpacing: 5,
                                    childAspectRatio: 1.5),
                            itemBuilder: (BuildContext context, int index) {
                              return SewingItem(
                                  sewingSnapshot?[index], changeData);
                            },
                          ),
                        ),
        ),
      ],
    );
  }

  void changeData() {
    getData();
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
        return SewingItem(snapshots?[index],changeData);
      },
    );
  }

  Widget getImageAssets() {
    AssetImage assetImage = AssetImage('images/add_sewing.png');
    Image image = Image(image: assetImage, width: 180.0, height: 100.0);
    return Container(child: image);
  }
}

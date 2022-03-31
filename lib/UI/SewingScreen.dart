import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionpal/UI/AddSewingNewScreen.dart';
import 'package:fashionpal/UI/StaffItem.dart';
import 'package:fashionpal/Utils/sharPreference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../BouncyPageRoute.dart';
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

    setState(() {});
  }

  Widget getSearchData() {
    searchSewingSnapshot = [];
    sewingSnapshot?.forEach((element) {
      if (((element.data() as Map)['sewingData']['title'])
              .toString()
              .toLowerCase()
              .contains((widget.query ?? '').toString().toLowerCase()) ||
          ((element.data() as Map)['sewingData']['customerData']['firstName'])
              .toString()
              .toLowerCase()
              .contains((widget.query ?? '').toString().toLowerCase()) ||
          ((element.data() as Map)['sewingData']['customerData']['phoneNumber'])
              .toString()
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
        widget.isSearching
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
                                  childAspectRatio: 1.15),
                          itemBuilder: (BuildContext context, int index) {
                            return SewingItem(sewingSnapshot?[index]);
                          },
                        ),
                      ),
      ],
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
        return SewingItem(snapshots?[index]);
      },
    );
  }

  Widget getImageAssets() {
    AssetImage assetImage = AssetImage('images/add_sewing.png');
    Image image = Image(image: assetImage, width: 180.0, height: 100.0);
    return Container(child: image);
  }
}

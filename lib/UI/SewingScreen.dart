import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionpal/UI/AddSewingNewScreen.dart';
import 'package:fashionpal/UI/StaffItem.dart';
import 'package:fashionpal/Utils/sharPreference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../BouncyPageRoute.dart';
import 'SewingItem.dart';

class SewingScreen extends StatefulWidget {
  _SewingScreenState createState() => new _SewingScreenState();
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

  Future<void> getData() async {
    userId = await getOwnerId();
    setState(() {});
  }

  Widget _build(BuildContext context) {
    return Stack(
      children: [
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('sewings')
                .where("ownerId", isEqualTo: userId)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return GridView.builder(
                itemCount: snapshot.data?.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 1.40),
                itemBuilder: (BuildContext context, int index) =>
                    SewingItem(snapshot.data?.docs[index]),
              );
            }),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
              height: 100,
              width: 200,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context, new BouncyPageRoute(widget: AddSewingNewScreen()));
                },
                child: Container(
                    padding: EdgeInsets.only(top: 10, right: 10),
                    alignment: Alignment.bottomRight,
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: getImageAssets())),
              )),
        )

      ],
    );
  }
  Widget getImageAssets() {
    AssetImage assetImage = AssetImage('images/add_sewing.png');
    Image image = Image(image: assetImage, width: 180.0, height: 100.0);
    return Container(child: image);
  }
}

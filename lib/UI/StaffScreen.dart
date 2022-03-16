import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionpal/UI/AddStaff.dart';
import 'package:fashionpal/UI/StaffItem.dart';
import 'package:fashionpal/Utils/sharPreference.dart';
import 'package:fashionpal/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../BouncyPageRoute.dart';
import 'AddSewingNewScreen.dart';

class StaffScreen extends StatefulWidget {
  _StaffScreenState createState() => new _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: PreferredSize(
        //     preferredSize: Size.fromHeight(50.0),
        //     child: AppBar(
        //       iconTheme: IconThemeData(
        //         color: Colors.white, //change your color here
        //       ),
        //       centerTitle: true,
        //       title: Text(
        //         "Staff",
        //         style: TextStyle(
        //             fontSize: 15,
        //             fontWeight: FontWeight.bold,
        //             color: Colors.white),
        //       ),
        //       backgroundColor: Colors.blue,
        //     )),
        body: _build(context));
  }

  Widget _build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('staff')
                  .where("ownerId", isEqualTo: userId)
                  .snapshots(),
              // stream: FirebaseFirestore.instance.collection('customers').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    child: GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 5,
                          childAspectRatio: 1.15),
                      itemBuilder: (BuildContext context, int index) {
                        return StaffItem(snapshot.data?.docs[index]);
                      },
                    ),
                  );
                } else if (!snapshot.hasData) {
                  return Center(
                    child: Text('No Staffs'),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
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
                        context, new BouncyPageRoute(widget: AddStaff()));
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
      ),
    );
  }

  Widget getImageAssets() {
    AssetImage assetImage = AssetImage('images/add_staff.png');
    Image image = Image(image: assetImage, width: 180.0, height: 100.0);
    return Container(child: image);
  }
}

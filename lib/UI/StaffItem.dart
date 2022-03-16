import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionpal/UI/AddCustomers.dart';
import 'package:fashionpal/UI/AddStaff.dart';
import 'package:fashionpal/UI/CustomerDetails.dart';
import 'package:fashionpal/UI/EditCustomer.dart';
import 'package:fashionpal/UI/StaffDetailsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../BouncyPageRoute.dart';
import '../colors.dart';
import 'EditStaffScreen.dart';

class StaffItem extends StatelessWidget {
  DocumentSnapshot? documentSnapshot;

  StaffItem(this.documentSnapshot);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Colors.blue,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Stack(children: <Widget>[
          Column(children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 0.0,
              color: white_theme,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 5, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            // Navigator.push(context,
                            //     new BouncyPageRoute(widget: CustomerDetails())
                            // );
                          },
                          child: Container(
                            child: Row(
                              children: <Widget>[
                                InkWell(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Image.asset(
                                      "images/logo.png",
                                      fit: BoxFit.fill,
                                      height: 22.0,
                                      width: 22.0,
                                    ),
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            (documentSnapshot?.data()
                                                        as Map)['staffData']
                                                    ['firstName']
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center),
                                        Container(
                                            margin: EdgeInsets.only(
                                                left: 10, right: 10),
                                            color: Colors.black,
                                            height: 1),
                                        Text(
                                            (documentSnapshot?.data()
                                                        as Map)['staffData']
                                                    ['phoneNumber']
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            textAlign: TextAlign.center),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      child: Container(
                        margin: EdgeInsets.only(top: 5, left: 10),
                        child: Image.asset(
                          "images/ic_edit.png",
                          fit: BoxFit.fill,
                          color: Colors.white,
                          height: 25.0,
                          width: 25.0,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            new BouncyPageRoute(
                                widget: AddStaff(
                              isEdit: true,
                              documentFields: documentSnapshot!,
                              staffId:
                                  (documentSnapshot?.data() as Map)['staffId'],
                            )));
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 10),
                      color: Colors.white,
                      width: 1,
                      height: 30,
                    ),
                    InkWell(
                      child: Container(
                        margin: EdgeInsets.only(top: 5, right: 10),
                        child: Image.asset(
                          "images/ic_menu.png",
                          fit: BoxFit.fill,
                          height: 25.0,
                          width: 25.0,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            new BouncyPageRoute(
                                widget: StaffDetailsScreen(
                              documentFields: documentSnapshot!,
                              staffId:
                                  (documentSnapshot?.data() as Map)['staffId'],
                            )));
                      },
                    )
                  ],
                ))
          ])
        ]),
      ),
    );
  }
}

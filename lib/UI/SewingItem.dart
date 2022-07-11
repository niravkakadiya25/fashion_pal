import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionpal/SplashScreen.dart';
import 'package:fashionpal/UI/AddSewingScreen.dart';
import 'package:fashionpal/UI/SewingDetailsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../BouncyPageRoute.dart';
import '../colors.dart';
import 'AddSewingNewScreen.dart';
import 'EditSewingScreen.dart';

class SewingItem extends StatelessWidget {
  DocumentSnapshot? documentSnapshot;
  final Function celebrityCallback;

  SewingItem(this.documentSnapshot, this.celebrityCallback);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: Colors.red,
            width: 1.5,
          ),
        ),
        child: Stack(children: <Widget>[
          Column(children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    new BouncyPageRoute(
                        widget: EditSewingScreen(
                      documentFields: documentSnapshot,
                      celebrityCallback: celebrityCallback,
                    )));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0))),
                        elevation: 0.0,
                        color: light_grey_theme,
                        child: Container(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 5, left: 10, right: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                    (documentSnapshot?.data()
                                                as Map)['sewingData']
                                            ['customerData']['firstName']
                                        .toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center),
                                Container(
                                    margin: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    color: Colors.black,
                                    height: 1),
                                Flexible(
                                  child: isStaffUser
                                      ? (permissionList[0].isGranted ?? false)
                                          ? Container(
                                              alignment: Alignment.centerRight,
                                              padding:
                                                  EdgeInsets.only(right: 20),
                                              child: Text(
                                                  (documentSnapshot?.data()
                                                                      as Map)[
                                                                  'sewingData']
                                                              ['customerData']
                                                          ['phoneNumber']
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                  textAlign: TextAlign.center))
                                          : Container()
                                      : Text(
                                          (documentSnapshot?.data()
                                                          as Map)['sewingData']
                                                      ['customerData']
                                                  ['phoneNumber']
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          textAlign: TextAlign.center),
                                ),
                              ],
                            )),
                      ),
                      Flexible(
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0))),
                          elevation: 0.0,
                          color: getSetColor((documentSnapshot?.data()
                              as Map)['sewingData']['status']),
                          child: Column(
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.only(
                                      top: 10, bottom: 5, left: 10, right: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      isStaffUser
                                          ? (permissionList[0].isGranted ??
                                                  false)
                                              ? Text(
                                                  (documentSnapshot?.data()
                                                                      as Map)[
                                                                  'sewingData']
                                                              ['customerData']
                                                          ['phoneNumber']
                                                      .toString(),
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                  textAlign: TextAlign.center)
                                              : Container()
                                          : Text(
                                              (documentSnapshot?.data() as Map)[
                                                              'sewingData']
                                                          ['customerData']
                                                      ['phoneNumber']
                                                  .toString(),
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 11,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              textAlign: TextAlign.center),
                                      Text(
                                          (documentSnapshot?.data()
                                                  as Map)['sewingData']['title']
                                              .toString(),
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center),
                                      Container(
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10),
                                          color: Colors.white,
                                          height: 1),
                                      Text(
                                          (documentSnapshot?.data()
                                                  as Map)['sewingData']
                                              ['description'],
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      )
                    ]),
              ),
            ),

            // Card(
            //   shape:
            //   RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            //   elevation: 0.0,
            //   color: plancolor,
            //   child: Column(
            //     children: <Widget>[
            //          Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: <Widget>[
            //             Container(
            //               child:                                 Card(
            //                 shape:
            //                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            //                 elevation: 0.0,
            //                 color: Colors.grey,
            //                 child: Container(
            //                     padding: EdgeInsets.only(top: 10,bottom: 5,left: 10,right: 10),
            //                     child:Column(
            //                       mainAxisAlignment: MainAxisAlignment.center,
            //                       crossAxisAlignment: CrossAxisAlignment.center,
            //                       children: [
            //                         Text(
            //                             "Opokum",
            //                             style: TextStyle(
            //                                 color: Colors.black,
            //                                 fontSize: 12,
            //                                 fontWeight: FontWeight.bold),
            //                             textAlign: TextAlign.center
            //                         ),
            //                         Container(
            //                             margin: EdgeInsets.only(left: 10,right: 10),
            //                             color: Colors.black, height: 1),
            //                         Text(
            //                             "75001469",
            //                             style: TextStyle(
            //                               fontSize: 12,
            //                               fontWeight: FontWeight.normal,),
            //                             textAlign: TextAlign.center
            //                         ),
            //                       ],
            //                     )
            //                 ),
            //               ),
            //             ),
            //             Container(
            //               child:                                 Card(
            //                 shape:
            //                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            //                 elevation: 0.0,
            //                 color: Colors.red,
            //                 child: Container(
            //                     padding: EdgeInsets.only(top: 10,bottom: 5,left: 10,right: 10),
            //                     child:Column(
            //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         Text(
            //                             "69845984",
            //                             style: TextStyle(
            //                               fontSize: 10,
            //                               fontWeight: FontWeight.normal,),
            //                             textAlign: TextAlign.center
            //                         ),
            //                         Text(
            //                             "Title",
            //                             style: TextStyle(
            //                                 color: Colors.black,
            //                                 fontSize: 12,
            //                                 fontWeight: FontWeight.bold),
            //                             textAlign: TextAlign.center
            //                         ),
            //                         Container(
            //                             margin: EdgeInsets.only(left: 10,right: 10),
            //                             color: Colors.black, height: 1),
            //                         Text(
            //                             "The Shirt",
            //                             style: TextStyle(
            //                               fontSize: 12,
            //                               fontWeight: FontWeight.normal,),
            //                             textAlign: TextAlign.center
            //                         ),
            //                       ],
            //                     )
            //                 ),
            //               ),
            //             )
            //           ],
            //         ),
            //     ],
            //   ),
            // ),
            Container(
                margin: EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    isStaffUser
                        ? (permissionList[0].isGranted ?? false)
                            ? InkWell(
                                child: Container(
                                  margin: EdgeInsets.only(top: 5, right: 10),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        "images/ic_menu.png",
                                        fit: BoxFit.fill,
                                        height: 25.0,
                                        width: 25.0,
                                        color: Colors.black,
                                      ),
                                      Text('Details'),
                                    ],
                                  ),
                                ),
                                onTap: () async {
                                  await Navigator.push(
                                      context,
                                      new BouncyPageRoute(
                                          widget: EditSewingScreen(
                                        documentFields: documentSnapshot,
                                        celebrityCallback: celebrityCallback,
                                      )));
                                  celebrityCallback();
                                },
                              )
                            : Container()
                        : InkWell(
                            child: Container(
                              margin: EdgeInsets.only(top: 5, right: 10),
                              child: Column(
                                children: [
                                  Image.asset(
                                    "images/ic_menu.png",
                                    fit: BoxFit.fill,
                                    height: 25.0,
                                    width: 25.0,
                                    color: Colors.black,
                                  ),
                                  Text('Details'),
                                ],
                              ),
                            ),
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  new BouncyPageRoute(
                                      widget: EditSewingScreen(
                                    celebrityCallback: celebrityCallback,
                                    documentFields: documentSnapshot,
                                  )));
                            },
                          ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 10),
                      color: Colors.white,
                      width: 1,
                      height: 30,
                    ),
                    Container(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 5, left: 10, right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Status",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                            Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                color: Colors.black,
                                height: 1),
                            Text(
                                (documentSnapshot?.data() as Map)['sewingData']
                                        ['status']
                                    .toString(),
                                style: TextStyle(
                                  color: getSetColor((documentSnapshot?.data()
                                      as Map)['sewingData']['status']),
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                                textAlign: TextAlign.center),
                          ],
                        )),
                  ],
                ))
          ])
        ]),
      ),
    );
  }

  Color getSetColor(String status) {
    switch (status.toLowerCase()) {
      case 'order':
        return Colors.red;
      case 'sewing':
        return Colors.lightBlueAccent;
      case 'completed':
        return Colors.blue;
      case 'delivered':
        return Colors.green;
      case 'cutting':
        return Colors.yellow;
    }
    return Colors.black;
  }
}

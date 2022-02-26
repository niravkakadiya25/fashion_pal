import 'package:cloud_firestore/cloud_firestore.dart';
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

  SewingItem(this.documentSnapshot);

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
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0))),
                        elevation: 0.0,
                        color: light_grey_theme,
                        child: Column(
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(
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
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center),
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10),
                                        color: Colors.black,
                                        height: 1),
                                    Text(
                                        (documentSnapshot?.data()
                                                    as Map)['sewingData']
                                                ['customerData']['phoneNumber']
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        textAlign: TextAlign.center),
                                  ],
                                )),
                          ],
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0))),
                        elevation: 0.0,
                        color: Colors.red,
                        child: Column(
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 5, left: 10, right: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        (documentSnapshot?.data()
                                                    as Map)['sewingData']
                                                ['customerData']['phoneNumber']
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        textAlign: TextAlign.center),
                                    Text(
                                        (documentSnapshot?.data()
                                                as Map)['sewingData']['title']
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
                                    Text("The",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center),
                                  ],
                                )),
                          ],
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
                    InkWell(
                        child: Container(
                          margin: EdgeInsets.only(top: 5, left: 10),
                          child: Image.asset(
                            "images/ic_menu.png",
                            fit: BoxFit.fill,
                            color: Colors.grey,
                            height: 25.0,
                            width: 25.0,
                          ),
                        ),
                        onTapDown: (details) {
                          showMenu<String>(
                            context: context,
                            position: RelativeRect.fromLTRB(
                              details.globalPosition.dx,
                              details.globalPosition.dy,
                              details.globalPosition.dx,
                              details.globalPosition.dy,
                            ),
                            //position where you want to show the menu on screen
                            items: [
                              PopupMenuItem<String>(
                                  child: const Text('Edit'), value: '1'),
                              PopupMenuItem<String>(
                                  child: const Text('Delete'), value: '2'),
                            ],
                            elevation: 8.0,
                          ).then((itemSelected) async {
                            if (itemSelected == null) return;

                            if (itemSelected == "1") {
                              //code here

                              Navigator.push(
                                  context,
                                  new BouncyPageRoute(
                                      widget: EditSewingScreen(
                                    documentFields: documentSnapshot,

                                  )));


                            } else if (itemSelected == "2") {
                              //code here
                              await FirebaseFirestore.instance
                                  .collection('sewings')
                                  .doc(documentSnapshot?.id)
                                  .delete();
                            } else {
                              //code here
                            }
                          });
                        },
                        onTap: () {}),
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
                                  color: Colors.red,
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
}

import 'package:expandable_text/expandable_text.dart';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../colors.dart';

class NotificationItem extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child:InkWell(
          child:Card(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
            elevation: 4.0,
            color: white_theme,
            child: Column(
              children: <Widget>[
                Container(
                  height: 70,
                  padding: EdgeInsets.only(top: 10,left: 10,right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            InkWell(
                              child : ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: Image.asset("images/logo.png",
                                  fit: BoxFit.fill,
                                  height: 60.0,
                                  width: 60.0,),
                              ),
                              onTap: (){
                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                //     CoachDetailsPage()));
                              },
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 20),
                                child:Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Title",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Message",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                )
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}

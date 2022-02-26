import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'NotificationItem.dart';

class NotificationScreen extends StatefulWidget{


  _NotificationScreenState createState() => new _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  @override
  void initState() {
    super.initState();


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              automaticallyImplyLeading:false,
              centerTitle: true,
              title: Text("Notification",style: TextStyle(
                  fontSize: 15,fontWeight:
              FontWeight.bold,
                  color: Colors.white),),
              backgroundColor: Colors.black,
            )
        ),
        body: _build(context)
    );



  }



  Widget _build(BuildContext context) {
    return
      ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 10,
          itemBuilder: (BuildContext contex,int index) => NotificationItem()

      );
  }
}
import 'package:fashionpal/UI/AddStaff.dart';
import 'package:fashionpal/UI/StaffItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../BouncyPageRoute.dart';

class StaffScreen extends StatefulWidget{


  _StaffScreenState createState() => new _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {

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
              iconTheme: IconThemeData(
                color: Colors.white, //change your color here
              ),
              centerTitle: true,
              title: Text("Staff",style: TextStyle(
                  fontSize: 15,fontWeight:
              FontWeight.bold,
                  color: Colors.white),),
              backgroundColor: Colors.blue,
            )
        ),
        body: _build(context)
    );



  }



  Widget _build(BuildContext context) {
    return Container(
      color:Colors.white,
      child: Stack(
        children: <Widget>[
          GridView.builder(
              itemCount: 30,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing:0.5,
                  mainAxisSpacing:5,
                  childAspectRatio: 1.10
              ),
              itemBuilder: (BuildContext contex,int index) => StaffItem()),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
                height: 100,
                width: 200,
                child: InkWell(
                  onTap: (){
                    Navigator.push(context,
                        new BouncyPageRoute(widget: AddStaff())
                    );
                  },
                  child: Container(
                      padding: EdgeInsets.only(top: 10,right: 10),
                      alignment: Alignment.bottomRight,
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: getImageAssets()
                      )
                  ),
                )
            ),
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
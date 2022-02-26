
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class ExpenditureScreen extends StatefulWidget{


  _ExpenditureScreenState createState() => new _ExpenditureScreenState();
}

class _ExpenditureScreenState extends State<ExpenditureScreen> {

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
              title: Text("Expenditure",style: TextStyle(
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
    return SingleChildScrollView(
      child: Container(
          child:Column(
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20,right: 5),
                    height: 40,
                    width: 100,
                    child: Image.asset("images/power.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20,left: 5,right: 5),
                    height: 40,
                    width: 100,
                    child: Image.asset("images/fabric.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20,left: 5),
                    height: 40,
                    width: 100,
                    child: Image.asset("images/presentation.png",
                      fit: BoxFit.fill,
                    ),
                  )
                ],
              ),

              Container(
                padding: EdgeInsets.only(top:20,bottom: 10,right: 30,left: 30),
                child: TextFormField(
                  maxLines: 8,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      hintStyle: TextStyle(color: appTheme),
                      hintText: "",
                      fillColor: Colors.white),
                ),
              ),

              Align(
                alignment: Alignment.center,
                child: InkWell(
                  child: Image.asset("images/total_expenditure.png",
                    fit: BoxFit.fill,
                    height: 50,
                    width: 200,
                  ),
                ),
              ),
            ],
          )
      ),
    );


  }
  Widget getImageAssets() {
    AssetImage assetImage = AssetImage('images/add_staff.png');
    Image image = Image(image: assetImage, width: 180.0, height: 100.0);
    return Container(child: image);
  }

}
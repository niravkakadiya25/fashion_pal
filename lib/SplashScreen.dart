import 'dart:async';

import 'package:fashionpal/UI/HomeScreen.dart';
import 'package:fashionpal/UI/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Utils/Notification.dart';
import 'Utils/sharPreference.dart';
import 'colors.dart';

class SplashScreen extends StatefulWidget {

  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {



  @override
  void initState()  {
    super.initState();
    startTimer();

  }

  void startTimer() {
    Timer(Duration(seconds: 3), () {
      navigateUser(); //It will redirect  after 3 seconds
    });
  }

  Future <void> navigateUser() async {

    setupFCMListeners(context);

    if (await getLoginStatus()) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
          HomePage()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
          LoginPage()));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(image: new AssetImage('images/background.png'), fit: BoxFit.cover,),
              ),
            ),
            new Center(
                child: getImageAssets(),
            )
          ],
        )
      // body: Container(
      //   color:appTheme,
      //   child: Stack(
      //     children: <Widget>[
      //       new Positioned(
      //           child: Align(
      //               alignment: Alignment.center,
      //               child: getImageAssets()
      //           )
      //       )
      //     ],
      //   ),
      //
      // ),
    );
  }

  Widget getImageAssets() {
    AssetImage assetImage = AssetImage('images/logo.png');
    Image image = Image(image: assetImage, width: 220.0, height: 170.0);
    return Container(child: image);
  }

}
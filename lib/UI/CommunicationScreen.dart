import 'package:fashionpal/UI/SendMailScreen.dart';
import 'package:fashionpal/UI/SendSMSScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../BouncyPageRoute.dart';
import '../colors.dart';
import 'SendPushNotificationScreen.dart';
import 'SignUpScreen.dart';

class CommunicationScreen extends StatefulWidget {


  @override
  _CommunicationScreen createState() => _CommunicationScreen();
}

class _CommunicationScreen extends State<CommunicationScreen> {
  String otp_ = "";
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(
            key: scaffoldKey,
            body:SingleChildScrollView(
              child: Container(
                  child:Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top:100,bottom: 10,right: 50,left: 50),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: InkWell(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: getImageMail(),
                                    ),
                                    onTap: (){
                                      Navigator.push(context,
                                          BouncyPageRoute(widget: SendMailScreen()));
                                    },
                                  )
                              ),
                              Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: InkWell(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: getImageSMS(),
                                    ),
                                    onTap: (){
                                      Navigator.push(context,
                                          BouncyPageRoute(widget: SendSMSScreen()));
                                    },
                                  )
                              ),
                              Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: InkWell(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: getImageNotification(),
                                    ),
                                    onTap: (){
                                      Navigator.push(context,
                                          BouncyPageRoute(widget: SendPushNotificationScreen()));
                                    },
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            )
        )
    );
  }
}
Widget getImageMail() {
  AssetImage assetImage = const AssetImage('images/send_mail.png');
  Image image = Image(image: assetImage, width: 500.0, height: 60.0);
  return Container(child: image);
}
Widget getImageSMS() {
  AssetImage assetImage = const AssetImage('images/send_sms.png');
  Image image = Image(image: assetImage, width: 500.0, height: 60.0);
  return Container(child: image);
}
Widget getImageNotification() {
  AssetImage assetImage = const AssetImage('images/send_notification.png');
  Image image = Image(image: assetImage, width: 500.0, height: 60.0);
  return Container(child: image);
}

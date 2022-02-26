import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionpal/UI/HomeScreen.dart';
import 'package:fashionpal/Utils/sent-otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_timer/flutter_otp_timer.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';

import '../BouncyPageRoute.dart';
import '../colors.dart';
import 'ForgotPasswordScreen.dart';
import 'SignUpScreen.dart';

class OTPScreen extends StatefulWidget {
  final bool isFromSignUp;
  final Map<String, dynamic>? map;

  const OTPScreen({Key? key, this.isFromSignUp = false, this.map})
      : super(key: key);

  @override
  _OTPScreen createState() => _OTPScreen();
}

class _OTPScreen extends State<OTPScreen> {
  String otp_ = "";
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            key: scaffoldKey,
            body: SingleChildScrollView(
              child: Container(
                  child: Column(
                children: [
                  Container(
                      height: 180,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('images/top_back.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              child: Text(
                                "Verification",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: appTheme,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 0, bottom: 10, right: 50, left: 50),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Container(
                              margin:
                                  EdgeInsets.only(top: 10, left: 40, right: 40),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                    "Please enter the One Time Password (OTP) sent to your phone",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 13, color: appTheme)),
                              )),
                          Container(
                              margin: EdgeInsets.only(top: 20),
                              child: PinEntryTextField(
                                fields: 6,
                                showFieldAsBox: false,
                                isTextObscure: true,
                                onSubmit: (String pin) {
                                  otp_ = pin;
                                  // otp_ = pin;
                                }, // end onSubmit
                              )),
                          Center(
                            child: OtpTimer(
                              duration: 60,
                              // time till which the timer should animate
                              radius: 50,
                              // size of the circle
                              timeTextSize: 16, // time text inside the circle
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(
                                    top: 25, left: 40, right: 40),
                                height: 40,
                                child: RaisedButton(
                                  child: Center(
                                    child: Text(
                                      widget.isFromSignUp
                                          ? 'Register'
                                          : "update password",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (widget.isFromSignUp) {
                                      bool isLogin =
                                          await submitOTP(otp_, context,widget.map) ??
                                              false;
                                      if (isLogin) {

                                        Navigator.push(
                                            context,
                                            BouncyPageRoute(
                                                widget: HomePage()));
                                      }
                                    }
                                    //
                                    // final form = formKey.currentState;
                                    // if (form!.validate()) {
                                    //   form.save();
                                    //   // _signIn(_email, _password);
                                    // }
                                  },
                                  color: appTheme,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                          child: Text("Resend Code",
                              style: TextStyle(
                                fontSize: 15,
                                color: appTheme,
                                decoration: TextDecoration.underline,
                              )),
                          onTap: () {
                            Navigator.push(
                                context,
                                BouncyPageRoute(
                                    widget: ForgotPasswordScreen()));
                          }),
                    ),
                  ),
                ],
              )),
            )));
  }
// _verifyOTP(String otp) async {
//   Map<String, dynamic> user = {
//     "mobile_no": widget.data.mobileNo,
//     "verification_code": otp,
//   };
//   ProgressDialog.showLoaderDialog(context);
//   APIService apiService = new APIService();
//   apiService.otpVerify(user).then((value) {
//     ProgressDialog.dismissDialog(context);
//     if (value.status) {
//       if(value.data !=null){
//         setLoginStatus();
//         setUserId(value.data.id);
//         setUserName(value.data.name);
//         // setUserToken(value.token);
//         Future.delayed(Duration(seconds: 1), () {
//           Navigator.pushNamedAndRemoveUntil(
//               context, '/registrationpage', (Route<dynamic> route) => false);
//         });
//         // Navigator.pop(context);
//         // Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage()));
//       }
//     }else{
//       Flushbar(
//         message: value.message,
//         margin: EdgeInsets.all(8),
//         borderRadius: 8,
//         duration: Duration(seconds: 2),
//       )..show(context);
//     }
//
//   });
// }
}

Widget getImageAssets() {
  AssetImage assetImage = AssetImage('images/logo.png');
  Image image = Image(image: assetImage, width: 300.0, height: 200.0);
  return Container(child: image);
}

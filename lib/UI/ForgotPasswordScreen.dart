import 'package:email_validator/email_validator.dart';
import 'package:fashionpal/UI/OTPScreen.dart';
import 'package:fashionpal/Utils/sent-otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../BouncyPageRoute.dart';
import '../colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

TextEditingController forgotmobilenumber = TextEditingController();

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late String _email;
  late String _password;
  late String _token;

  TextEditingController newpassword = TextEditingController();
  TextEditingController confirmnewpassword = TextEditingController();

  // GoogleSignInAccount _userData;
  // GoogleSignIn _googleSignIn = GoogleSignIn();
  String _message = 'Log in/out by pressing the buttons below.';
  late String name = '', image, email;
  bool _obscureText = true;

  @override
  void initState() {
    // getFcmToken().then((value) {
    //   _token = value;
    // });
    super.initState();
  }

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
                      height: 220,
                      child: new Stack(
                        children: <Widget>[
                          new Container(
                            margin: EdgeInsets.only(bottom: 50),
                            decoration: new BoxDecoration(
                              image: new DecorationImage(
                                image: new AssetImage('images/top_back.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          new Align(
                              alignment: Alignment.bottomCenter,
                              child: getImageAssets()),
                        ],
                      )),
                  new Container(
                    margin: EdgeInsets.only(top: 30),
                    child: new Align(
                        alignment: Alignment.center,
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            new InkWell(
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: appTheme,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 40, bottom: 10, right: 50, left: 50),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: forgotmobilenumber,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please Enter Mobile Number';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                    color: appTheme,
                                    width: 2.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                    color: appTheme,
                                    width: 2.0,
                                  ),
                                ),
                                filled: true,
                                hintStyle: new TextStyle(color: appTheme),
                                hintText: "Enter Phone Number",
                                fillColor: Colors.white),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.only(top: 15),
                            ),
                          ),
                          TextFormField(
                            controller: newpassword,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please Enter new Password';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      _obscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: appTheme),
                                  onPressed: () {
                                    // Update the state i.e. toogle the state of passwordVisible variable
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                    color: appTheme,
                                    width: 2.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                    color: appTheme,
                                    width: 2.0,
                                  ),
                                ),
                                filled: true,
                                hintStyle: new TextStyle(color: appTheme),
                                hintText: "Enter new password",
                                fillColor: Colors.white),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.only(top: 15),
                            ),
                          ),
                          TextFormField(
                            controller: confirmnewpassword,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please Enter Confirm Password';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      _obscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: appTheme),
                                  onPressed: () {
                                    // Update the state i.e. toogle the state of passwordVisible variable
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                    color: appTheme,
                                    width: 2.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                    color: appTheme,
                                    width: 2.0,
                                  ),
                                ),
                                filled: true,
                                hintStyle: new TextStyle(color: appTheme),
                                hintText: "Enter confirm password",
                                fillColor: Colors.white),
                          ),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(top: 20),
                                height: 45,
                                child: RaisedButton(
                                  child: Center(
                                    child: Text(
                                      "Send OTP",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  onPressed: () {
                                    final form = formKey.currentState;
                                    if (form!.validate()) {
                                      submitPhoneNumber(
                                        forgotmobilenumber,
                                        context,
                                        true,
                                        false,
                                      );

                                      form.save();
                                      // _signIn(_email, _password);
                                    }
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
                ],
              )),
            )));
  }

  // _signIn(String email, pass) async {
  //   Map<String, dynamic> user = {
  //     "email": _email,
  //     "password": _password,
  //     "fcm_token": _token,
  //   };
  //   ProgressDialog.showLoaderDialog(context);
  //   APIService apiService = new APIService();
  //   apiService.login(user).then((value) {
  //     ProgressDialog.dismissDialog(context);
  //     if (value.status) {
  //       if(value.data !=null){
  //         setLoginStatus();
  //         setUserId(value.data.id);
  //         setUserName(value.data.name);
  //         // setUserToken(value.token);
  //         setUserImage(value.data.image);
  //         setUserEmail(value.data.email);
  //         if(value.data.profileStatus == "1"){
  //           Future.delayed(Duration(seconds: 1), () {
  //             Navigator.pushNamedAndRemoveUntil(
  //                 context, '/homepage', (Route<dynamic> route) => false);
  //           });
  //         } else {
  //           Future.delayed(Duration(seconds: 1), () {
  //             Navigator.pushNamedAndRemoveUntil(
  //                 context, '/registrationpage', (Route<dynamic> route) => false);
  //           });
  //         }
  //       }
  //     }else{
  //       Flushbar(
  //         message: value.message,
  //         margin: EdgeInsets.all(8),
  //         borderRadius: 8,
  //         duration: Duration(seconds: 2),
  //       )..show(context);
  //     }
  //   });
  // }

  // _signInGoogle(String displayName, String email, String photoUrl, String id, String s) async {
  //   Map<String, dynamic> user = {
  //     "email": email,
  //     "name": displayName,
  //     "imageUrl": photoUrl,
  //     "uid": id,
  //     "register_through" : s,
  //     "fcm_token": _token,
  //   };
  //   ProgressDialog.showLoaderDialog(context);
  //   APIService apiService = new APIService();
  //   apiService.loginGoogle(user).then((value) {
  //     ProgressDialog.dismissDialog(context);
  //     if (value.status) {
  //       if(value.data !=null){
  //         setLoginStatus();
  //         setUserId(value.data.id);
  //         setUserName(value.data.name);
  //         //setUserToken(value.token);
  //         if(value.data.profileStatus == "1"){
  //           Future.delayed(Duration(seconds: 1), () {
  //             Navigator.pushNamedAndRemoveUntil(
  //                 context, '/homepage', (Route<dynamic> route) => false);
  //           });
  //         } else{
  //           Future.delayed(Duration(seconds: 1), () {
  //             Navigator.pushNamedAndRemoveUntil(
  //                 context, '/registrationpage', (Route<dynamic> route) => false);
  //           });
  //         }
  //       }
  //     }else{
  //       Flushbar(
  //         message: value.message,
  //         margin: EdgeInsets.all(8),
  //         borderRadius: 8,
  //         duration: Duration(seconds: 2),
  //       )..show(context);
  //     }
  //   });
  // }
  void _showMessage(String message) {
    setState(() {
      _message = message;
    });
  }
// final FacebookLogin facebookSignIn = new FacebookLogin();
//
// // String _message = 'Log in/out by pressing the buttons below.';
// Future<Null> _login() async {
//   final FacebookLoginResult result =
//   await facebookSignIn.logIn(['email']);
//   switch (result.status) {
//     case FacebookLoginStatus.loggedIn:
//       final FacebookAccessToken accessToken = result.accessToken;
//       final graphResponse = await http.get(
//           'https://graph.facebook.com/v2.12/me?fields=first_name,email,picture&access_token=${accessToken.token}');
//       final profile = jsonDecode(graphResponse.body);
//       print(profile);
//       setState(() {
//         name = profile['first_name'];
//         email = profile['email'];
//         image = profile['picture']['data']['url'];
//       });
//       _signInGoogle(name,email,image,accessToken.userId,"facebook");
//       // Flushbar(
//       //   message: email,
//       //   margin: EdgeInsets.all(8),
//       //   borderRadius: 8,
//       //   duration: Duration(seconds: 2),
//       // )..show(context);
//       _showMessage('''' Logged in!
//
//   Token: ${accessToken.token}
//   User id: ${accessToken.userId}
//   Expires: ${accessToken.expires}
//   Permissions: ${accessToken.permissions}
//   Declined permissions: ${accessToken.declinedPermissions}
//   ''');
//       break;
//     case FacebookLoginStatus.cancelledByUser:
//       _showMessage('Login cancelled by the user.');
//       break;
//     case FacebookLoginStatus.error:
//       _showMessage('Something went wrong with the login process.\n'
//           'Here\'s the error Facebook gave us: ${result.errorMessage}');
//       break;
//   }
// }
}

Widget getImageAssets() {
  AssetImage assetImage = AssetImage('images/logo.png');
  Image image = Image(image: assetImage, width: 100.0, height: 100.0);
  return Container(child: image);
}

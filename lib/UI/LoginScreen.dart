import 'package:email_validator/email_validator.dart';
import 'package:fashionpal/UI/ForgotPasswordScreen.dart';
import 'package:fashionpal/UI/HomeScreen.dart';
import 'package:fashionpal/UI/SignUpScreen.dart';
import 'package:fashionpal/Utils/ProgressDialog.dart';
import 'package:fashionpal/Utils/constants.dart';
import 'package:fashionpal/Utils/sharPreference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../BouncyPageRoute.dart';
import '../colors.dart';
import '../main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late String _email;
  late String _password;
  late String _token;

  // GoogleSignInAccount _userData;
  // GoogleSignIn _googleSignIn = GoogleSignIn();
  String _message = 'Log in/out by pressing the buttons below.';
  late String name = '', image, email;
  bool _obscureText = true;
  FirebaseAuth auth = FirebaseAuth.instance;

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
                      child: Stack(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 50),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('images/top_back.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: getImageAssets()),
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
                                "Welcome to ",
                                style: TextStyle(fontSize: 16, color: appTheme),
                              ),
                            ),
                            InkWell(
                              child: Text(
                                "Fashion",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: appTheme,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            InkWell(
                              child: Text(
                                "Pal",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: plancolor,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
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
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                prefixIcon: Container(
                                  padding: EdgeInsets.all(12.0),
                                  child: Image.asset(
                                    'images/user.png',
                                    width: 10,
                                    height: 10,
                                  ),
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
                                hintStyle: new TextStyle(color: appTheme),
                                hintText: "Phone Number",
                                fillColor: Colors.white),
                            onSaved: (val) => _email = val!,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.only(top: 15),
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                prefixIcon: Container(
                                  padding: EdgeInsets.all(12.0),
                                  child: Image.asset(
                                    'images/lock.png',
                                    width: 10,
                                    height: 10,
                                  ),
                                ),
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
                                hintText: "Password",
                                fillColor: Colors.white),
                            onSaved: (val) => _password = val!,
                            obscureText: _obscureText ? false : true,
                          ),
                          new Column(
                            children: [
                              new Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(top: 20),
                                height: 45,
                                child: RaisedButton(
                                  child: Center(
                                    child: Text(
                                      "SIGN IN",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  onPressed: () {
                                    // if(email)
                                    // Navigator.push(context,
                                    //     BouncyPageRoute(widget: HomePage()));
                                    final form = formKey.currentState;
                                    if (form!.validate()) {
                                      form.save();
                                      if (_email.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Please Enter Mobile number")));
                                      } else if (_email.length < 9) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Please Valid Mobile Number")));
                                      } else if (_password.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Please Enter password")));
                                      } else if (_password.length < 4) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Please Enter Valid password")));
                                      } else {
                                        signIn();
                                      }
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
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                          child: Text("Forgot Password?",
                              style: TextStyle(fontSize: 18, color: appTheme)),
                          onTap: () {
                            Navigator.push(
                                context,
                                BouncyPageRoute(
                                    widget: ForgotPasswordScreen()));
                          }),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                            child: Text("Don't have an account yet?",
                                style: TextStyle(fontSize: 12)),
                            onTap: () {
                              // Navigator.push(context,
                              //     new BouncyPageRoute(widget: Signup()));
                            }),
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                          child: Text("Create an account",
                              style: TextStyle(fontSize: 18, color: appTheme)),
                          onTap: () {
                            Navigator.push(context,
                                BouncyPageRoute(widget: SignUpScreen()));
                          }),
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
      Flushbar(
        message: message,
        margin: EdgeInsets.all(8),
        borderRadius: 8,
        duration: Duration(seconds: 2),
      )..show(context);
      _message = message;
    });
  }

  void signIn() async {
    ProgressDialog.showLoaderDialog(context);
    await auth
        .signInWithEmailAndPassword(
            email: '+233' + _email.substring(1) + "@fashionpal.com",
            password: _password)
        .then((value) {
      ProgressDialog.dismissDialog(context);
      if (value != null) {
        if (value.additionalUserInfo != null) {
          setLoginStatus();
          setOwnerId(value.user!.uid.toString());
          setUserName(value.user!.displayName.toString());

          print(value);
          // print(value.user.toString());
          // Flushbar(
          //   message: value.user!.uid.toString(),
          //   margin: EdgeInsets.all(8),
          //   borderRadius: 8,
          //   duration: Duration(seconds: 2),
          // )..show(context);
          Future.delayed(Duration(seconds: 1), () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/homepage', (Route<dynamic> route) => false);
          });

          // setUserToken(value.token);
          // setUserImage(value.data.image);
          // setUserEmail(value.data.email);
          // if(value.data.profileStatus == "1"){
          //   Future.delayed(Duration(seconds: 1), () {
          //     Navigator.pushNamedAndRemoveUntil(
          //         context, '/homepage', (Route<dynamic> route) => false);
          //   });
          // } else {
          //   Future.delayed(Duration(seconds: 1), () {
          //     Navigator.pushNamedAndRemoveUntil(
          //         context, '/registrationpage', (Route<dynamic> route) => false);
          //   });
          // }
        }
      } else {
        Flushbar(
          message: "value.message",
          margin: EdgeInsets.all(8),
          borderRadius: 8,
          duration: Duration(seconds: 2),
        )..show(context);
      }
    }).catchError((onError) {
      print(onError);
      ProgressDialog.dismissDialog(context);
      buildErrorDialog(context, 'title', onError.toString(),(){
        Navigator.pop(context);
      });
    });

    // if (await auth!.currentUser!() != null) {
    //   // signed in
    // } else {
    //
    // }
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
// Flushbar(
//   message: email,
//   margin: EdgeInsets.all(8),
//   borderRadius: 8,
//   duration: Duration(seconds: 2),
// )..show(context);
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionpal/UI/ForgotPasswordScreen.dart';
import 'package:fashionpal/UI/OTPScreen.dart';
import 'package:fashionpal/UI/SignUpScreen.dart';
import 'package:fashionpal/Utils/sharPreference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as User;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../BouncyPageRoute.dart';
import '../main.dart';

String? _status;

AuthCredential? _phoneAuthCredential;
String? _verificationId;
int? _code;
User.User? firebaseUser;

submitPhoneNumber(
    _phoneNumberController, context, isFromForgotPassword, isFromSignUpScreen,
    {Function(int)? myNumber, Map<String, dynamic>? map}) async {
  /// NOTE: Either append your phone number country code or add in the code itself
  /// Since I'm in India we use "+233" as prefix `phoneNumber`
  String phoneNumber = "+233 " + _phoneNumberController.text.toString().trim();
  print(phoneNumber);

  /// The below functions are the callbacks, separated so as to make code more redable
  void verificationCompleted(AuthCredential phoneAuthCredential) {
    print('verificationCompleted');

    _phoneAuthCredential = phoneAuthCredential;
    print(phoneAuthCredential);
  }

  void verificationFailed(FirebaseAuthException error) {
    print('verificationFailed');
    _handleError(error, context);
  }

  Future codeSent(String verificationId, [int? code]) async {
    print('codeSent');
    _verificationId = verificationId;
    print(verificationId);
    _code = code!;
    print(code.toString());
    _status = 'Code Sent\n';
    Navigator.push(
        context,
        BouncyPageRoute(
            widget: OTPScreen(
          isFromSignUp: isFromSignUpScreen ?? false,
          map: map,
        )));
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    print('codeAutoRetrievalTimeout');
    _status = 'codeAutoRetrievalTimeout\n';
    print(verificationId);
  }

  await FirebaseAuth.instance.verifyPhoneNumber(
    /// Make sure to prefix with your country code
    phoneNumber: phoneNumber,

    /// `seconds` didn't work. The underlying implementation code only reads in `millisenconds`
    timeout: Duration(milliseconds: 120000),

    /// If the SIM (with phoneNumber) is in the current device this function is called.
    /// This function gives `AuthCredential`. Moreover `login` function can be called from this callback
    /// When this function is called there is no need to enter the OTP, you can click on Login button to sigin directly as the device is now verified
    verificationCompleted: verificationCompleted,

    /// Called when the verification is failed
    verificationFailed: verificationFailed,

    /// This is called after the OTP is sent. Gives a `verificationId` and `code`
    codeSent: (verificationId, forceResendingToken) {
      if (myNumber != null) myNumber(5);
      codeSent(verificationId, forceResendingToken);
    },

    /// After automatic code retrival `tmeout` this function is called
    codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
  ); // All the callbacks are above
}

Future<bool?> submitOTP(_otpController, context, map) async {
  /// get the `smsCode` from the user
  String smsCode = _otpController;

  /// when used different phoneNumber other than the current (running) device
  /// we need to use OTP to get `phoneAuthCredential` which is inturn used to signIn/login
  _phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: _verificationId!, smsCode: smsCode);
  return await _login(context, map);
}

Future<bool?> _login(context, map) async {
  bool ss = false;

  /// This method is used to login the user
  /// `AuthCredential`(`_phoneAuthCredential`) is needed for the signIn method
  /// After the signIn method from `AuthResult` we can get `FirebaserUser`(`_firebaseUser`)
  try {
    print(mobileNumberController.text.toString());
    print(password.text.toString());

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: '+233' +
                mobileNumberController.text.substring(1) +
                "@fashionpal.com",
            password: password.text.trim())
        .then((value) async {
      firebaseUser = value.user;
      print(firebaseUser.toString());
      ss = true;

      await setLoginStatus();
      await setOwnerId(value.user!.uid.toString());
      await setUserName(value.user!.displayName.toString());

      await FirebaseFirestore.instance
          .collection('users')
          .doc(value.user?.uid)
          .set(map ?? {}, SetOptions(merge: true));
    }).catchError((onError) async {
      if (onError is PlatformException) {
        if (onError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          /// `foo@bar.com` has alread been registered.
          /// await FirebaseAuth.instance
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: '+233' +
                      mobileNumberController.text.substring(1) +
                      "@fashionpal.com",
                  password: password.text.trim())
              .then((value) async {
            await setLoginStatus();
            await setOwnerId(value.user!.uid.toString());
            await setUserName(value.user!.displayName.toString());

            await FirebaseFirestore.instance
                .collection('users')
                .doc(value.user?.uid)
                .set(map ?? {}, SetOptions(merge: true));

            ss = true;
          });
        }
      }
      print('fwe' + onError.toString());
      ss = false;
    });

    /*  print('credentail' + (userCredential.credential?.providerId ?? 'not'));
    await FirebaseAuth.instance
        .signInWithCredential(userCredential.credential!)
        .then((UserCredential authRes) {

    }).catchError((e) {
      _handleError(e, context);
      ss = false;
    });
    */
    _status = 'Signed In\n';
  } catch (e) {
    print('fwe' + e.toString());

    ss = false;
  }
  return ss;
}

void _handleError(e, context) {
  print(e.message.toString());
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(e.message.toString())));
}

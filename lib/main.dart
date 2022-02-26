// @dart=2.9
import 'package:fashionpal/SplashScreen.dart';
import 'package:fashionpal/UI/AddCustomers.dart';
import 'package:fashionpal/UI/CustomerDetails.dart';
import 'package:fashionpal/UI/EditCompanyProfileScreen.dart';
import 'package:fashionpal/UI/EditCustomer.dart';
import 'package:fashionpal/UI/EditProfileScreen.dart';
import 'package:fashionpal/UI/HomeScreen.dart';
import 'package:fashionpal/UI/MyProfileScreen.dart';
import 'package:fashionpal/UI/OTPScreen.dart';
import 'package:fashionpal/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Utils/Notification.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFirebase();


  runApp(
       MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "FashionPal",
        home: SplashScreen(),
        routes:routes,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              color: appTheme,
              textTheme: TextTheme(
                //rgb(136,252,254)
                subtitle1: TextStyle(
                    color: appTheme,
                    fontSize: 20,
                    fontStyle: FontStyle.italic),
              ),
            ),
            primaryTextTheme: const TextTheme(
              subtitle2: TextStyle(),
              button: TextStyle(),
            ).apply(
              bodyColor: appTheme,
              displayColor: appTheme,
            )),
      )
  );
}


final routes = {
  // '/loginpage': (BuildContext context) => LoginPage(),
  '/homepage': (BuildContext context) => HomePage(),
  // '/registrationpage': (BuildContext context) => RegistrationPage(),
  // '/myProfile': (BuildContext context) => UserProfile(),
};
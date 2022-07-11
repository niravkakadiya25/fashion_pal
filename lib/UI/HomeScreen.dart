import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionpal/SplashScreen.dart';
import 'package:fashionpal/UI/CommunicationScreen.dart';
import 'package:fashionpal/UI/ContactUsScreen.dart';
import 'package:fashionpal/UI/FinanceScreen.dart';
import 'package:fashionpal/UI/MyCustomerScreen.dart';
import 'package:fashionpal/UI/MyProfileScreen.dart';
import 'package:fashionpal/UI/NotificationScreen.dart';
import 'package:fashionpal/UI/SendSMSScreen.dart';
import 'package:fashionpal/UI/SewingScreen.dart';
import 'package:fashionpal/UI/StaffScreen.dart';
import 'package:fashionpal/UI/subscription.dart';
import 'package:fashionpal/UI/subscription_history.dart';
import 'package:fashionpal/Utils/sharPreference.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../BouncyPageRoute.dart';
import '../colors.dart';
import 'AddStaff.dart';
import 'SideOptionScreen.dart';
import 'balance_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  int _selectedIndex = -1;
  DocumentSnapshot? documentSnapshot;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    getUserData();

    super.initState();
    _selectedIndex = -1;
  }

  getUserData() async {
    permissionList.clear();
    permissionList.add(PermissionModel(false, 'View customers Contact'));
    permissionList.add(PermissionModel(false, 'Financial Details'));
    permissionList.add(PermissionModel(false, 'Send customers sms'));
    permissionList.add(PermissionModel(false, 'Access Shop and Inventory'));
    if (isStaffUser) {
      await FirebaseFirestore.instance
          .collection('staff')
          .doc(await getUserId())
          .get()
          .then((value) {
        if (value.exists) {
          for (var element
              in ((value.data() as Map)['staffData']["permissions"] as List)) {
            permissionList[(element - 1)].isGranted = true;
          }
        }
      });
    }
    String ownerId = await getOwnerId();
    print(ownerId);
    documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(ownerId).get();
    setState(() {});
  }

  Container buildDrawer() {
    return documentSnapshot?.data() == null
        ? Container(
            child: InkWell(
              child: Container(
                height: 50,
                margin: EdgeInsets.only(top: 10, bottom: 20),
                padding: EdgeInsets.only(left: 20),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Image.asset(
                      "images/user.png",
                      height: 30,
                      width: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Log Out",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                await preferences.clear();
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SplashScreen()));

                //Navigator.push(context, new MaterialPageRoute(builder: (context) => SplashScreen()));
              },
            ),
          )
        : Container(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.blue,
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    InkWell(
                      child: Container(
                        color: Colors.white,
                        height: 150,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "FashionPal",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              height: 80,
                              width: 80,
                              child: documentSnapshot == null
                                  ? Text('')
                                  : (documentSnapshot?.data()
                                              as Map)['profileImage'] ==
                                          null
                                      ? getImageWidget()
                                      : (documentSnapshot?.data()
                                                  as Map)['profileImage']
                                              .toString()
                                              .isNotEmpty
                                          ? Image.network(
                                              (documentSnapshot?.data()
                                                      as Map)['profileImage']
                                                  .toString())
                                          : getImageWidget(),
                            ),
                            Container(
                              child: Text(
                                documentSnapshot == null
                                    ? ''
                                    : (documentSnapshot?.data()
                                        as Map)['firstName'],
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            )
                          ],
                        ),
                      ),
                      // onTap: () => Navigator.push(context, MaterialPageRoute(builder:(context) => UserProfile())),
                    ),
                    InkWell(
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(left: 20),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Image.asset(
                              "images/user.png",
                              height: 30,
                              width: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "My Profile",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            BouncyPageRoute(widget: MyProfileScreen()));
                      },
                    ),
                 /*   InkWell(
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(left: 20),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Image.asset(
                              "images/user.png",
                              height: 30,
                              width: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Subscription ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            BouncyPageRoute(widget: SubscriptionScreen()));
                      },
                    ),
                    InkWell(
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(left: 20),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Image.asset(
                              "images/user.png",
                              height: 30,
                              width: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Subscription History",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            BouncyPageRoute(widget: SubscriptionHistory()));
                      },
                    ),*/
                    InkWell(
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(left: 20),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Image.asset(
                              "images/user.png",
                              height: 30,
                              width: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Balance ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            BouncyPageRoute(widget: BalanceScreen()));
                      },
                    ),
                    InkWell(
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(left: 20),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Image.asset(
                              "images/user.png",
                              height: 30,
                              width: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Sewings",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          _selectedIndex = 1;
                        });
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context)=>PhotoBoothScreen())
                        // );
                      },
                    ),
                    InkWell(
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(left: 20),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Image.asset(
                              "images/user.png",
                              height: 30,
                              width: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Search Customers",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context)=>AllUsersScreen())
                        // );
                      },
                    ),
                    InkWell(
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(left: 20),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Image.asset(
                              "images/user.png",
                              height: 30,
                              width: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "My Customers",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          _selectedIndex = 0;
                        });
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context)=>NutritionPlanPage())
                        // );
                      },
                    ),
                    /*    InkWell(
                child: Container(
                  height: 50,
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.only(left: 20),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Image.asset(
                        "images/user.png",
                        height: 30,
                        width: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "My Contacts",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context)=>Setting())
                  // );
                },
              ),
              InkWell(
                child: Container(
                  height: 50,
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.only(left: 20),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Image.asset(
                        "images/user.png",
                        height: 30,
                        width: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Customers",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context)
                  // =>BmiCalculatorPage()));
                },
              ),*/
                    InkWell(
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(left: 20),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Image.asset(
                              "images/user.png",
                              height: 30,
                              width: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Staff",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);

                        setState(() {
                          _selectedIndex = 3;
                        });
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context)=>PrivacyPolicy())
                        // );
                      },
                    ),
                    InkWell(
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(left: 20),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Image.asset(
                              "images/user.png",
                              height: 30,
                              width: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Finances",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context)=>HelpAndSupport())
                        // );
                      },
                    ),
                    InkWell(
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(left: 20),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Image.asset(
                              "images/user.png",
                              height: 30,
                              width: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Notifications",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        // Navigator.push(context,
                        //     BouncyPageRoute(widget: NotificationScreen()));
                      },
                    ),
                    InkWell(
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(left: 20),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Image.asset(
                              "images/user.png",
                              height: 30,
                              width: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Communications",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            BouncyPageRoute(widget: CommunicationScreen()));
                        if (isStaffUser) {
                          print(permissionList[2].permission);
                          if (permissionList[2].isGranted ?? false) {
                            Navigator.push(context,
                                BouncyPageRoute(widget: CommunicationScreen()));
                            return;
                          } else {
                            return;
                          }
                        }

                      },
                    ),
                    InkWell(
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(left: 20),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Image.asset(
                              "images/user.png",
                              height: 30,
                              width: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Contacts Us",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _selectedIndex = 3;
                        });
                        Navigator.push(context,
                            BouncyPageRoute(widget: ContactUsScreen()));
                      },
                    ),
                    InkWell(
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(left: 20),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Image.asset(
                              "images/user.png",
                              height: 30,
                              width: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Reviews",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context)=>HelpAndSupport())
                        // );
                      },
                    ),
                    InkWell(
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(left: 20),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Image.asset(
                              "images/user.png",
                              height: 30,
                              width: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Settings",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context)=>HelpAndSupport())
                        // );
                      },
                    ),
                    InkWell(
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(left: 20),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Image.asset(
                              "images/user.png",
                              height: 30,
                              width: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Inventory",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context)=>HelpAndSupport())
                        // );
                      },
                    ),
                    InkWell(
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(left: 20),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Image.asset(
                              "images/user.png",
                              height: 30,
                              width: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Shop",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context)=>HelpAndSupport())
                        // );
                      },
                    ),
                    InkWell(
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(left: 20),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Image.asset(
                              "images/user.png",
                              height: 30,
                              width: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Gallery",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context)=>HelpAndSupport())
                        // );
                      },
                    ),
                    InkWell(
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 10, bottom: 20),
                        padding: EdgeInsets.only(left: 20),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Image.asset(
                              "images/user.png",
                              height: 30,
                              width: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Log Out",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        await preferences.clear();
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SplashScreen()));

                        //Navigator.push(context, new MaterialPageRoute(builder: (context) => SplashScreen()));
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(160.0),
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 10,
                  left: 20,
                  right: 20,
                  bottom: 20),
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                              child: Image(
                                image: AssetImage('images/menu.png'),
                                width: 30,
                                height: 30,
                              ),
                              onTap: () {
                                if (_scaffoldKey.currentState!.isDrawerOpen) {
                                  Navigator.of(context).pop();
                                } else {
                                  _scaffoldKey.currentState!.openDrawer();
                                }
                              }),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Image(
                                image: AssetImage('images/user.png'),
                                width: 40,
                                height: 40,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text('Hello',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        Container(
                          width: 250,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.blue[700],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: TextField(
                            onChanged: (value) {
                              if (value.isEmpty) {
                                isSearching = false;
                              } else {
                                isSearching = true;
                              }
                              setState(() {});
                            },
                            controller: editingController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search",
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
        drawer: SafeArea(
          child: Container(
            color: Colors.blue,
            child: Drawer(
              child: Column(
                children: [Expanded(child: buildDrawer())],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
            child: Container(
          color: bottombar,
          height: 60,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                MaterialButton(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  onPressed: () {
                    isSearching  = false;
                    editingController.clear();
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image(
                        image: AssetImage('images/customer_icon.png'),
                        width: 20,
                        height: 20,

                      ),
                      Text('My Customers',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.normal))
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    color: Colors.deepOrange,
                    width: 1),
                MaterialButton(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  onPressed: () {
                    isSearching  = false;
                    editingController.clear();
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image(
                        image: AssetImage('images/sewing.png'),
                        width: 20,
                        height: 20,
                      ),
                      Text('Sewings',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.normal))
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    color: Colors.deepOrange,
                    width: 1),
                MaterialButton(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  onPressed: () {
                    isSearching  = false;
                    setState(() {
                      _selectedIndex = 2;
                    });   editingController.clear();
                    if (isStaffUser) {
                      print(permissionList[1].permission);
                      if (permissionList[1].isGranted ?? false) {
                        setState(() {
                          _selectedIndex = 2;
                        });
                        return;
                      } else {
                        return;
                      }
                    }
                    setState(() {
                      _selectedIndex = 2;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image(
                        image: AssetImage('images/finance.png'),
                        width: 20,
                        height: 20,
                      ),
                      Text('Finance',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.normal))
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    color: Colors.deepOrange,
                    width: 1),

                MaterialButton(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  onPressed: () {
                    isSearching  = false;
                    editingController.clear();

                    setState(() {
                      _selectedIndex = 3;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image(
                        image: AssetImage('images/shop.png'),
                        width: 20,
                        height: 20,
                      ),
                      Text('Staff',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.normal))
                    ],
                  ),
                ),
                // Container(
                //     margin: EdgeInsets.only(top: 10,bottom: 10),
                //     color: Colors.deepOrange, width: 1),
                // MaterialButton(
                //   padding: EdgeInsets.only(top: 5,bottom: 5),
                //   onPressed: () {},
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: <Widget>[
                //       Image(image: AssetImage('images/shop.png'),width: 20,
                //         height: 20,),
                //       Text('Shop', textAlign: TextAlign.center,
                //           style: TextStyle(color: Colors.white, fontSize: 10,
                //               fontWeight: FontWeight.normal)
                //       )
                //     ],
                //   ),
                // )
              ]),
        )),
        body: bodyItem(_selectedIndex));
  }

  bool isSearching = false;

  Widget bodyItem(int index) {
    switch (_selectedIndex) {
      case 0:
        return MyContactScreen(
          isSearching: isSearching,
          query: editingController.text.trim().toString(),
        );
      case 1:
        return SewingScreen(
          isSearching: isSearching,
          query: editingController.text.trim().toString(),
        );
      case 2:
        return FinanceScreen();
      case 3:
        return StaffScreen();
    }
    return MyContactScreen(
      isSearching: isSearching,
      query: editingController.text.trim().toString(),
    );
  }

  /*
  other widget
   */
  Widget getImageWidget() {
    return Image.asset('images/huser.png',
        fit: BoxFit.fill, height: 70.0, width: 70.0);
  }

  Widget getUserNameWidget() {
    return Text(
      "Alok kumar",
      style: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  Widget getUserEmailWidget() {
    return Text(
      "XYZ@gmail.com",
      style: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}

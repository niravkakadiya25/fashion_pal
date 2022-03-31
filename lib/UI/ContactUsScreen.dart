import 'package:fashionpal/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreen createState() => _ContactUsScreen();
}

class _ContactUsScreen extends State<ContactUsScreen> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController? get codeOne => null;

  void _submitCommand() {
    final form = formKey.currentState;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            key: scaffoldKey,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(50.0),
                child: AppBar(
                  iconTheme: IconThemeData(
                    color: Colors.white, //change your color here
                  ),
                  centerTitle: true,
                  title: Text(
                    "HELP & SUPPORT",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  backgroundColor: black_theme,
                )),
            body: SingleChildScrollView(
                child: Container(
                    height: MediaQuery.of(context).size.height -
                        (50.0 + MediaQuery.of(context).padding.top),
                    padding: EdgeInsets.only(
                        top: 20, bottom: 20, right: 20, left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  child: InkWell(
                                    child: getImageAssetsHelp(),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5.0),
                                  child: InkWell(
                                      child: Text("Need some helps?",
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: black_theme,
                                              fontWeight: FontWeight.bold)),
                                      onTap: () {
                                        // Navigator.push(context,
                                        //     new BouncyPageRoute(widget: Signup()));
                                      }),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 20, bottom: 30),
                                  child: InkWell(
                                      child: Text(
                                        "Feel free to get in touch with us",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.grey),
                                        textAlign: TextAlign.center,
                                      ),
                                      onTap: () {
                                        // Navigator.push(context,
                                        //     new BouncyPageRoute(widget: Signup()));
                                      }),
                                ),
                                Column(
                                  children: <Widget>[
                                    GestureDetector(

                                      child: Container(
                                        height: 60,
                                        padding: EdgeInsets.only(
                                            top: 10, left: 10, right: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              child: Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(5.0),
                                                    child: InkWell(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                50.0),
                                                        child: Image.asset(
                                                          "images/ic_contactus.png",
                                                          fit: BoxFit.fill,
                                                          color: Colors.black,
                                                          height: 25.0,
                                                          width: 25.0,
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                                        //     CoachDetailsPage()));
                                                      },
                                                    ),
                                                  ),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Mobile Number",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.black,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                          Text(
                                                            "+233 20077 7262",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                        ],
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        _makePhoneCall('tel:+233200777262');
                                      },
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    GestureDetector(

                                      child: Container(
                                        height: 60,
                                        padding: EdgeInsets.only(
                                            top: 10, left: 10, right: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              child: Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(5.0),
                                                    child: InkWell(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                50.0),
                                                        child: Image.asset(
                                                          "images/whatsapp.png",
                                                          fit: BoxFit.fill,
                                                          height: 25.0,
                                                          width: 25.0,
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                                        //     CoachDetailsPage()));
                                                      },
                                                    ),
                                                  ),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "WhatsApp",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.black,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                          Text(
                                                            "+233 20077 7262",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                        ],
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        launchWhatsApp();
                                      },
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    GestureDetector(

                                      child: Container(
                                        height: 60,
                                        padding: EdgeInsets.only(
                                            top: 10, left: 10, right: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              child: Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(5.0),
                                                    child: InkWell(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                50.0),
                                                        child: Image.asset(
                                                          "images/ic_contactus.png",
                                                          fit: BoxFit.fill,
                                                          color: Colors.black,
                                                          height: 25.0,
                                                          width: 25.0,
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                                        //     CoachDetailsPage()));
                                                      },
                                                    ),
                                                  ),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Email ID",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.black,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                          Text(
                                                            "info@fashionpal.com",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                        ],
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        _makePhoneCall('mailto:info@fashionpal.com');
                                      },
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Container(
                                      height: 90,
                                      padding: EdgeInsets.only(
                                          top: 10, left: 10, right: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: InkWell(
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.0),
                                                      child: Image.asset(
                                                        "images/ic_contactus.png",
                                                        fit: BoxFit.fill,
                                                        color: Colors.black,
                                                        height: 25.0,
                                                        width: 25.0,
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                                      //     CoachDetailsPage()));
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: const [
                                                        Text(
                                                          "Address",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                        ),
                                                        InkWell(
                                                          child: Text(
                                                            "Danyame kumas, \nopposite standchart Bank Spintex Accra",
                                                            textAlign: TextAlign
                                                                .start,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                        )
                                                      ],
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      // padding: EdgeInsets.only(top:20,bottom: 20,right: 20,left: 20),
                                      margin:
                                          EdgeInsets.only(top: 20, bottom: 10),
                                      height: 40,
                                      child: RaisedButton(
                                        child: Center(
                                          child: Text(
                                            "Contact Us",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        onPressed: () {
                                          // _submitCommand();
                                          // Navigator.push(context,
                                          //     new BouncyPageRoute(widget: ChatWithUsPage())
                                          // );
                                        },
                                        color: appTheme,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        margin: EdgeInsets.only(top: 20),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),

                        // new Container(
                        //   child:  Align(
                        //     alignment: Alignment.bottomCenter,
                        //     child: InkWell(
                        //       child: Text(
                        //           "Login with social accounts or Sign Up",
                        //           style: TextStyle(fontSize: 12)
                        //       ),
                        //       // onTap: (){
                        //       //   Navigator.push(context,
                        //       //       new BouncyPageRoute(widget: HomePage()));
                        //       // }
                        //     ),
                        //   ),
                        // ),
                      ],
                    )))));
  }

  launchWhatsApp() async {

    await launch("https://wa.me/+233200777262?text=Hello");
  }
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

Widget getImageAssetsHelp() {
  AssetImage assetImage = AssetImage('images/logo.png');
  Image image = Image(image: assetImage, width: 300.0, height: 120.0);
  return Container(child: image);
}

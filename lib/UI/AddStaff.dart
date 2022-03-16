import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fashionpal/SplashScreen.dart';
import 'package:fashionpal/UI/SignUpScreen.dart';
import 'package:fashionpal/Utils/ProgressDialog.dart';
import 'package:fashionpal/Utils/constants.dart';
import 'package:fashionpal/Utils/sharPreference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../colors.dart';

class AddStaff extends StatefulWidget {
  final bool isEdit;
  final DocumentSnapshot? documentFields;
  final String? staffId;

  const AddStaff(
      {Key? key, this.isEdit = false, this.documentFields, this.staffId})
      : super(key: key);

  @override
  _AddStaffState createState() => _AddStaffState();
}

class _AddStaffState extends State<AddStaff> {
  TextEditingController fname = TextEditingController();
  TextEditingController surnamename = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController telnumber = TextEditingController();
  TextEditingController DOB = TextEditingController();
  TextEditingController sex = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController region = TextEditingController();
  TextEditingController city = TextEditingController();
  DateTime selectedDOBDate = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  CollectionReference users = FirebaseFirestore.instance.collection('staff');

  @override
  void initState() {
    super.initState();
    _askPermissions(null);

    if (widget.isEdit) {
      fname = TextEditingController(
          text: (widget.documentFields?.data() as Map)['staffData']
              ["firstName"]);
      surnamename = TextEditingController(
          text: (widget.documentFields?.data() as Map)['staffData']
              ["lastName"]);
      email = TextEditingController(
          text: (widget.documentFields?.data() as Map)['staffData']["email"]);
      telnumber = TextEditingController(
          text: (widget.documentFields?.data() as Map)['staffData']
              ["phoneNumber"]);
      // _controllerDOB = TextEditingController(text:  widget.documentFields!["birthday"].toString());
      sex = TextEditingController(
          text: (widget.documentFields?.data() as Map)['staffData']["sex"]);
      address = TextEditingController(
          text: (widget.documentFields?.data() as Map)['staffData']["address"]);
      country = TextEditingController(
          text: (widget.documentFields?.data() as Map)['staffData']["country"]);
      region = TextEditingController(
          text: (widget.documentFields?.data() as Map)['staffData']["state"]);
      city = TextEditingController(
          text: (widget.documentFields?.data() as Map)['staffData']["city"]);
      DOB = TextEditingController(
          text: (widget.documentFields?.data() as Map)['staffData']
              ["birthday"]);

      for (var element in ((widget.documentFields?.data() as Map)['staffData']
          ["permissions"] as List)) {
        print(element);
        permissionList[(element - 1)].isGranted = true;
      }
      setState(() {});
    }
  }

  Future<void> _askPermissions(String? routeName) async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      final snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      final snackBar =
          SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  Future<void> _pickContact() async {
    try {
      final Contact? contact = await ContactsService.openDeviceContactPicker();
      if (contact != null) {
        fname.text = contact.givenName ?? '';
        telnumber.text = contact.phones?.first.value ?? '';
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDOBDate,
        firstDate: DateTime(1947, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDOBDate)
      setState(() {
        selectedDOBDate = picked;
        DOB.text = formatter.format(selectedDOBDate).toString();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: light_grey_theme,
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          height: 550,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Image.asset(
                            "images/back.png",
                            color: Colors.white,
                            height: 30,
                            width: 30,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          "${widget.isEdit ? 'Edit' : 'Add'} Staff",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _pickContact();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(right: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Image.asset(
                                  "images/shop.png",
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                              Container(
                                child: Text(
                                  "Load from contact",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          "${widget.isEdit ? 'Edit' : 'Add'} Staff's Details",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(top: 10),
                        height: 50,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: TextField(
                                  controller: fname,
                                  decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                    hintText: 'First Name',
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(left: 10),
                                child: TextField(
                                  controller: surnamename,
                                  decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                    hintText: 'Surname',
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 10),
                        child: TextField(
                          controller: email,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            hintText: "Email Address",
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 10),
                        child: TextField(
                          readOnly: widget.isEdit ? true : false,
                          controller: telnumber,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            hintText: "Tel",
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(top: 10),
                        height: 50,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: TextField(
                                  controller: DOB,
                                  onTap: () => _selectDate(context),
                                  decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                    hintText: "Date Of Birth",
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(left: 10),
                                child: DropdownSearch<String>(
                                  mode: Mode.MENU,
                                  showSelectedItem: false,
                                  items: ["Male", "Female", "Other"],
                                  label: "Select Sex",
                                  hint: "Sex",
                                  selectedItem: sex.text,
                                  onChanged: (value) {
                                    sex.text = value!;
                                  },
                                  // validator: (val) =>
                                  // val == null? _snackbar("Select Height Unit") : null,
                                  // onSaved: (newValue) {
                                  //   _heightUnit=newValue;
                                  // },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 10),
                        child: TextField(
                          controller: address,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            hintText: "Complete Address",
                          ),
                        ),
                      ),
                      CSCPicker(
                        stateDropdownLabel:
                            region.text.isEmpty ? 'State' : region.text,
                        countryDropdownLabel:
                            country.text.isEmpty ? 'Country' : country.text,
                        onCountryChanged: (value) {
                          setState(() {
                            // countryValue = value;
                            country.text = value;
                          });
                        },
                        onStateChanged: (value) {
                          setState(() {
                            region.text = value.toString();
                            // stateValue = value;
                          });
                        },
                        onCityChanged: (value) {
                          setState(() {
                            city.text = value.toString();
                            // cityValue = value;
                          });
                        },
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ListView.separated(
                              //Here's your separator
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  height: 10, //Whatever spacing you want.
                                );
                              },
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: permissionList.length,
                              //How many tiles you want
                              padding: EdgeInsets.all(0),
                              itemBuilder: (BuildContext context, int index) {
                                return ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  child: SwitchListTile(
                                    tileColor: Colors.grey[900],
                                    selectedTileColor: Colors.black,
                                    contentPadding: EdgeInsets.zero,
                                    isThreeLine: false,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    onChanged: (v) {
                                      permissionList[index].isGranted = v;
                                      setState(() {});
                                    },
                                    title: Text(
                                        permissionList[index].permission ?? ''),
                                    visualDensity: VisualDensity.compact,
                                    value: permissionList[index].isGranted ??
                                        false,
                                  ),
                                );
                              },
                            ),
                            Container(
                              height: 100,
                              width: 200,
                              child: GestureDetector(
                                onTap: () async {
                                  if (fname.text.isEmpty) {
                                    buildErrorDialog(
                                        context, '', 'Please Enter first Name',
                                        () {
                                      Navigator.pop(context);
                                    });
                                  } else if (telnumber.text.isEmpty) {
                                    buildErrorDialog(context, '',
                                        'Please Enter Mobile Number', () {
                                      Navigator.pop(context);
                                    });
                                  } else {
                                    List permisions = [];
                                    for (int i = 0;
                                        i < permissionList.length;
                                        i++) {
                                      if (permissionList[i].isGranted == true) {
                                        permisions.add((i + 1));
                                      }
                                    }
                                    bool isAlreadyExit = false;
                                    bool isAlreadyExitForOwner = false;
                                    var ownerId = (await getOwnerId());

                                    if (!widget.isEdit) {
                                      await FirebaseFirestore.instance
                                          .collection('staff')
                                          .get()
                                          .then((value) async {
                                        for (var element in value.docs) {
                                          if (element.data()['staffData']
                                                  ['phoneNumber'] ==
                                              mobileNumberController.text
                                                  .trim()) {
                                            isAlreadyExit = true;
                                            if (element.data()['ownerId'] ==
                                                ownerId) {
                                              isAlreadyExitForOwner = true;
                                            }
                                          }
                                          break;
                                        }
                                        if (isAlreadyExitForOwner) {
                                          buildErrorDialog(context, '',
                                              'Staff Already Added', () {
                                            Navigator.pop(context);
                                          });
                                        } else {
                                          ProgressDialog.showLoaderDialog(
                                              context);

                                          await FirebaseAuth.instance
                                              .createUserWithEmailAndPassword(
                                                  email: '+233' +
                                                      telnumber.text
                                                          .substring(1) +
                                                      "@fashionpal.com",
                                                  password: '123456')
                                              .then((value) async {
                                            Map map = {
                                              'address': address.text.trim(),
                                              'birthday': DOB.text.trim(),
                                              'city': city.text.trim(),
                                              'country': country.text.trim(),
                                              'state': region.text.trim(),
                                              'updateAt': DateTime.now(),
                                              'email': '+233' + telnumber.text.substring(1) + "@fashionpal.com",
                                              'firstName': fname.text.trim(),
                                              'lastName':
                                                  surnamename.text.trim(),
                                              'phoneNumber':
                                                  telnumber.text.trim(),
                                              'searchMatch': fname.text.trim(),
                                              'sex': sex.text.trim(),
                                              'role': 'staff',
                                              'isAccountEnabled': true,
                                              'permissions': permisions
                                            };

                                            await addCustomeClaims(permisions);
                                            await addDataInUserCollection(
                                                value.user?.uid);

                                            await FirebaseFirestore.instance
                                                .collection('staff')
                                                .doc(value.user?.uid)
                                                .set({
                                              'staffData': map,
                                              'staffId': value.user?.uid,
                                              'ownerId': ownerId.toString(),
                                            }, SetOptions(merge: true));

                                            Navigator.of(context).popUntil(
                                                (route) => route.isFirst);
                                          });
                                        }
                                      });
                                    } else {
                                      ProgressDialog.showLoaderDialog(context);

                                      await addDataInUserCollection(
                                          widget.staffId);
                                      await addCustomeClaims(permisions);
                                      Map map = {
                                        'address': address.text.trim(),
                                        'birthday': DOB.text.trim(),
                                        'city': city.text.trim(),
                                        'country': country.text.trim(),
                                        'state': region.text.trim(),
                                        'createdAt': DateTime.now(),
                                        'email': '+233' + telnumber.text.substring(1) + "@fashionpal.com",
                                        'firstName': fname.text.trim(),
                                        'lastName': surnamename.text.trim(),
                                        'phoneNumber': telnumber.text.trim(),
                                        'searchMatch': fname.text.trim(),
                                        'sex': sex.text.trim(),
                                        'role': 'staff',
                                        'isAccountEnabled': true,
                                        'permissions': permisions,
                                      };

                                      await FirebaseFirestore.instance
                                          .collection('staff')
                                          .doc(widget.staffId)
                                          .set({
                                        'staffData': map,
                                        'staffId': widget.staffId,
                                        'ownerId': ownerId.toString(),
                                      }, SetOptions(merge: true));

                                      Navigator.of(context)
                                          .popUntil((route) => route.isFirst);
                                    }
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  padding: EdgeInsets.only(left: 10),
                                  child: Image.asset(
                                    widget.isEdit
                                        ? "images/add_staff.png"
                                        : "images/add_staff.png",
                                    height: 60,
                                    width: 60,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  addDataInUserCollection(userId) async {
    Map<String, dynamic> userCollectionMap = {
      'firstName': fname.text.trim(),
      'ownerId': await getOwnerId(),
      'lastName': surnamename.text.trim(),
      'sex': sex.text.trim(),
      'phoneNumber': telnumber.text.trim(),
      'address': address.text.trim(),
      'isEnabled': true,
      'role': 'staff',
      'searchMatch':
          fname.text.toString().replaceAll(' ', '').toLowerCase().toString(),
      'createdAt': DateTime.now(),
      'city': city.text.trim(),
      'country': country.text.trim(),
      'state': region.text.trim(),
    };

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set(userCollectionMap, SetOptions(merge: true));
  }

  addCustomeClaims(permisions) async {
    print('+233' + telnumber.text.substring(1) + "@fashionpal.com");
    try {
      HttpsCallable callable =
          FirebaseFunctions.instance.httpsCallable('addStaffRole');

      final resp = await callable.call(<String, dynamic>{
        'email': '+233' + telnumber.text.substring(1) + "@fashionpal.com",
        'permissions': permisions,
      });
      print("result: ${resp.data}");
    } on FirebaseFunctionsException catch (e) {
      // Do clever things with e
      print("result: ${e.stackTrace.toString()}");
      print("result1: ${e.message.toString()}");
    } catch (e) {
      print("result: ${e.toString()}");
      // Do other things that might be thrown that I have overlooked
    }
  }
}

class PermissionModel {
  bool? isGranted;

  String? permission;

  PermissionModel(this.isGranted, this.permission);
}

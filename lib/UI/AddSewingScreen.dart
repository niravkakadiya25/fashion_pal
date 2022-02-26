import 'package:dropdown_search/dropdown_search.dart';
import 'package:fashionpal/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddSewingScreen extends StatefulWidget {
  @override
  _AddSewingScreenState createState() => _AddSewingScreenState();
}

class _AddSewingScreenState extends State<AddSewingScreen> {
  DateTime selectedDate = DateTime.now();
  late String date;
  TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
              centerTitle: true,
              title: Text(
                "Add Sewings",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              backgroundColor: appTheme,
            )),
        body: _build(context));
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: new DateTime.now().add(Duration(days: -0)),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
        date = DateFormat.yMd().format(selectedDate);
      });
  }

  Widget _build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Container(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
          child: Form(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    height: 30,
                    child: Container(
                        child: Text(
                      "Add Sewings Details",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    margin: EdgeInsets.only(top: 15),
                    child: DropdownSearch<String>(
                      mode: Mode.MENU,
                      showSelectedItem: false,
                      items: ["User1", "User2", "User3"],
                      label: "Select User",
                      hint: "Select",
                      // validator: (val) =>
                      // val == null? _snackbar("Select Height Unit") : null,
                      // onSaved: (newValue) {
                      //   _heightUnit=newValue;
                      // },
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      height: 50,
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              filled: true,
                              hintStyle: new TextStyle(color: Colors.grey),
                              hintText: "Sew Title",
                              fillColor: Colors.white),
                        ),
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      height: 50,
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              filled: true,
                              hintStyle: new TextStyle(color: Colors.grey),
                              hintText: "Description",
                              fillColor: Colors.white),
                        ),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    margin: EdgeInsets.only(top: 15),
                    child: DropdownSearch<String>(
                      mode: Mode.MENU,
                      showSelectedItem: false,
                      items: ["Staff1", "Staff2", "Staff3"],
                      label: "Select Staff",
                      hint: "Select",
                      // validator: (val) =>
                      // val == null? _snackbar("Select Height Unit") : null,
                      // onSaved: (newValue) {
                      //   _heightUnit=newValue;
                      // },
                    ),
                  ),
                ),
                Column(children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 350,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 0.0,
                            color: light_grey_theme,
                            child: Column(
                              children: <Widget>[
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width - 150,
                                    padding: EdgeInsets.only(
                                        top: 10,
                                        bottom: 5,
                                        left: 10,
                                        right: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Container(
                                            height: 20,
                                            child: Container(
                                                child: Text(
                                              "Measurement",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            )),
                                          ),
                                        ),
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Container(
                                              height: 30,
                                              child: Container(
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.text,
                                                  decoration: InputDecoration(
                                                      suffixIcon: Container(
                                                        padding:
                                                            EdgeInsets.all(6.0),
                                                        child: Image.asset(
                                                          'images/equal.png',
                                                          width: 10,
                                                          height: 10,
                                                        ),
                                                      ),
                                                      filled: true,
                                                      hintStyle: new TextStyle(
                                                          color: Colors.grey),
                                                      hintText:
                                                          "Shirt: Long/Short",
                                                      fillColor:
                                                          light_grey_theme),
                                                ),
                                              ),
                                            )),
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Container(
                                              height: 30,
                                              child: Container(
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.text,
                                                  decoration: InputDecoration(
                                                      suffixIcon: Container(
                                                        padding:
                                                            EdgeInsets.all(6.0),
                                                        child: Image.asset(
                                                          'images/equal.png',
                                                          width: 10,
                                                          height: 10,
                                                        ),
                                                      ),
                                                      filled: true,
                                                      hintStyle: new TextStyle(
                                                          color: Colors.grey),
                                                      hintText: "Kaba and Slit",
                                                      fillColor:
                                                          light_grey_theme),
                                                ),
                                              ),
                                            )),
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Container(
                                              height: 30,
                                              child: Container(
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.text,
                                                  decoration: InputDecoration(
                                                      suffixIcon: Container(
                                                        padding:
                                                            EdgeInsets.all(6.0),
                                                        child: Image.asset(
                                                          'images/equal.png',
                                                          width: 10,
                                                          height: 10,
                                                        ),
                                                      ),
                                                      filled: true,
                                                      hintStyle: new TextStyle(
                                                          color: Colors.grey),
                                                      hintText:
                                                          "Dress Skirt and Blouse",
                                                      fillColor:
                                                          light_grey_theme),
                                                ),
                                              ),
                                            )),
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Container(
                                              height: 30,
                                              child: Container(
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.text,
                                                  decoration: InputDecoration(
                                                      suffixIcon: Container(
                                                        padding:
                                                            EdgeInsets.all(6.0),
                                                        child: Image.asset(
                                                          'images/equal.png',
                                                          width: 10,
                                                          height: 10,
                                                        ),
                                                      ),
                                                      filled: true,
                                                      hintStyle: new TextStyle(
                                                          color: Colors.grey),
                                                      hintText:
                                                          "Trousers and Shorts",
                                                      fillColor:
                                                          light_grey_theme),
                                                ),
                                              ),
                                            )),
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Container(
                                              height: 30,
                                              child: Container(
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.text,
                                                  decoration: InputDecoration(
                                                      suffixIcon: Container(
                                                        padding:
                                                            EdgeInsets.all(6.0),
                                                        child: Image.asset(
                                                          'images/equal.png',
                                                          width: 10,
                                                          height: 10,
                                                        ),
                                                      ),
                                                      filled: true,
                                                      hintStyle: new TextStyle(
                                                          color: Colors.grey),
                                                      hintText: "Kaftan Top",
                                                      fillColor:
                                                          light_grey_theme),
                                                ),
                                              ),
                                            )),
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Container(
                                              height: 30,
                                              child: Container(
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.text,
                                                  decoration: InputDecoration(
                                                      suffixIcon: Container(
                                                        padding:
                                                            EdgeInsets.all(6.0),
                                                        child: Image.asset(
                                                          'images/equal.png',
                                                          width: 10,
                                                          height: 10,
                                                        ),
                                                      ),
                                                      filled: true,
                                                      hintStyle: new TextStyle(
                                                          color: Colors.grey),
                                                      hintText:
                                                          "Complete For Male",
                                                      fillColor:
                                                          light_grey_theme),
                                                ),
                                              ),
                                            )),
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Container(
                                              height: 30,
                                              child: Container(
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.text,
                                                  decoration: InputDecoration(
                                                      suffixIcon: Container(
                                                        padding:
                                                            EdgeInsets.all(6.0),
                                                        child: Image.asset(
                                                          'images/equal.png',
                                                          width: 10,
                                                          height: 10,
                                                        ),
                                                      ),
                                                      filled: true,
                                                      hintStyle: new TextStyle(
                                                          color: Colors.grey),
                                                      hintText:
                                                          "Complete For Female",
                                                      fillColor:
                                                          light_grey_theme),
                                                ),
                                              ),
                                            )),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                  width: 120,
                                  padding: EdgeInsets.only(
                                      top: 10, bottom: 5, left: 10, right: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: 10,
                                        ),
                                        child: Image.asset(
                                          'images/ic_style.png',
                                          width: 120,
                                          height: 120,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: 10,
                                        ),
                                        child: Image.asset(
                                          'images/ic_style.png',
                                          width: 120,
                                          height: 120,
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          )
                        ]),
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 15),
                          child: TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                filled: true,
                                hintStyle: new TextStyle(color: Colors.grey),
                                hintText: "Duration (In days)",
                                fillColor: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 15),
                          child: TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                filled: true,
                                hintStyle: new TextStyle(color: Colors.grey),
                                hintText: "Cost",
                                fillColor: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 15),
                          child: TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                filled: true,
                                hintStyle: new TextStyle(color: Colors.grey),
                                hintText: "Order",
                                fillColor: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 15),
                          child: TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                filled: true,
                                hintStyle: new TextStyle(color: Colors.grey),
                                hintText: "No Payment",
                                fillColor: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 15),
                          child: TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                filled: true,
                                hintStyle: new TextStyle(color: Colors.grey),
                                hintText: "Reminder",
                                fillColor: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Image.asset(
                            "images/add_sewing.png",
                            fit: BoxFit.fill,
                            height: 45.0,
                            width: 25.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

// _signUpDetails(String userId, String userName, String gender, String height, String weight,String weightUnit,String heightUnit, String occupation, String objective, String exerciseFrequency,
//     String foodPreference, String sleepingHour, String stressLevel, String allergies, String medicalConditions, String txt) async {
//   Map<String, dynamic> user = {
//     "user_id": userId,
//     "name": userName,
//     "gender": gender,
//     "height": height+heightUnit,
//     "weight": weight+weightUnit,
//     "occupation": occupation,
//     "objective": objective,
//     "exercise_frequency": exerciseFrequency,
//     "food_preference": foodPreference,
//     "sleeping_hour": sleepingHour,
//     "stress_level": stressLevel,
//     "allergies": allergies,
//     "medical_conditions": medicalConditions,
//   };
//   ProgressDialog.showLoaderDialog(context);
//   APIService apiService = new APIService();
//   apiService.updateSignDetails(user).then((value) {
//     ProgressDialog.dismissDialog(context);
//     if (value.status) {
//       if(value.data !=null){
//         Future.delayed(Duration(seconds: 1), () {
//           Navigator.pushNamedAndRemoveUntil(
//               context, '/homepage', (Route<dynamic> route) => false);
//         });
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
// _snackbar(String s){
//   Flushbar(
//     message: s,
//     margin: EdgeInsets.all(8),
//     borderRadius: 8,
//     duration: Duration(seconds: 2),
//   )..show(context);
// }
// void showDialog() {
//   Container(
//     padding: const EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 20),
//     child: Form(
//       key: formKey,
//       child: Column(
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextFormField(
//                 textAlign: TextAlign.left,
//                 minLines: 1,
//                 maxLines: 5,
//                 keyboardType: TextInputType.numberWithOptions(
//                     decimal: true,
//                     signed: false),
//                 decoration: InputDecoration(
//                   labelText: "Referred by",
//                   labelStyle: TextStyle(
//                     color: Colors.grey,
//                   ),
//                   border: OutlineInputBorder(),
//                   focusedBorder: OutlineInputBorder(),
//
//                 ),
//                 validator: (val) =>
//                 val.length < 1 ? "Enter Referred by" : null,
//                 onSaved: (val) => _txt= val,
//               )
//             ],
//           ),
//
//
//         ],
//       ),
//     ),
//
//   );
// }

}

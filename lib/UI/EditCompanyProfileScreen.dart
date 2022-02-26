

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../colors.dart';

class EditCompanyProfileScreen extends StatefulWidget {

  @override
  _EditCompanyProfileScreenState createState() => _EditCompanyProfileScreenState();
}

class _EditCompanyProfileScreenState extends State<EditCompanyProfileScreen> {
  DateTime selectedDate = DateTime.now();
  late String date;
  bool _inProcess=false;
  TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
              centerTitle: true,
              title: Text("Update Company Profile",style: TextStyle(
                  fontSize: 15,fontWeight:
              FontWeight.bold,
                  color: Colors.white),),
              backgroundColor: appTheme,
            )
        ),
        body:_build(context)
    );
  }


  // _BuildBody(BuildContext context) {
  //   return FutureBuilder<SignupDataBeanModel>(
  //       future: myFuture,
  //       builder: (context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.done) {
  //           if (snapshot.hasError) {
  //             return Center(
  //               child: Text(
  //                 snapshot.error.toString(),
  //                 textAlign: TextAlign.center,
  //                 textScaleFactor: 1.3,
  //               ),
  //             );
  //           }
  //           final data = snapshot.data;
  //           return _build(context,data);
  //         } else {
  //           return Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         }
  //       });
  // }
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
          padding: const EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 20),
          child: Form(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: InkWell(
                    child:Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.asset('images/user.png',
                            fit: BoxFit.fill,
                            height: 100.0,
                            width: 100.0),
                      ),

                    ),
                    // onTap: () =>_showPicker(context),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Expanded(child:
                      Container(
                        child:TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              filled: true,
                              hintStyle: new TextStyle(color: Colors.grey),
                              hintText: "Company Name",
                              fillColor: Colors.white),
                        ),
                      ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(child:  Container(
                        child:TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              filled: true,
                              hintStyle: new TextStyle(color: Colors.grey),
                              hintText: "Trading Name",
                              fillColor: Colors.white),
                        ),
                      ),)
                    ],
                  ),
                ),

                Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child:  Container(
                      height: 50,
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        child:TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              filled: true,
                              hintStyle: new TextStyle(color: Colors.grey),
                              hintText: "Tax Number",
                              fillColor: Colors.white),
                        ),
                      ),
                    )
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Expanded(child:
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: InkWell(
                          child:TextFormField(
                            keyboardType: TextInputType.text,
                            controller: _dateController,
                            autofocus: false,
                            decoration: InputDecoration(
                                filled: true,
                                hintStyle: new TextStyle(color: Colors.grey),
                                hintText: "End Date",
                                fillColor: Colors.white),
                          ),
                          onTap: () {
                            _selectDate(context);
                          },
                        ),
                      ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(child:  Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Container(
                          margin: EdgeInsets.only(top: 15),
                          child:TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                filled: true,
                                hintStyle: new TextStyle(color: Colors.grey),
                                hintText: "Phone number",
                                fillColor: Colors.white),
                          ),
                        ),
                      ),)
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Expanded(child:
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child:TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              filled: true,
                              hintStyle: new TextStyle(color: Colors.grey),
                              hintText: "Password",
                              fillColor: Colors.white),
                        ),
                      ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(child:  Container(
                        margin: EdgeInsets.only(top: 15),
                        child:TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              filled: true,
                              hintStyle: new TextStyle(color: Colors.grey),
                              hintText: "Re-enter Password",
                              fillColor: Colors.white),
                        ),
                      ),)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Expanded(child:
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: DropdownSearch<String>(
                          mode: Mode.MENU,
                          showSelectedItem: false,
                          items: ["Sole","Group","Dummy"],
                          label: "Select",
                          hint: "Select",
                          // validator: (val) =>
                          // val == null? _snackbar("Select Height Unit") : null,
                          // onSaved: (newValue) {
                          //   _heightUnit=newValue;
                          // },
                        ),
                      ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(child:  Container(
                        margin: EdgeInsets.only(top: 15),
                        child: DropdownSearch<String>(
                          mode: Mode.MENU,
                          showSelectedItem: false,
                          items: ["Dollar","Rs.","Dinar"],
                          label: "Select",
                          hint: "Select",
                          // validator: (val) =>
                          // val == null? _snackbar("Select Height Unit") : null,
                          // onSaved: (newValue) {
                          //   _heightUnit=newValue;
                          // },
                        ),
                      ),)
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child:  Container(
                    margin: EdgeInsets.only(top: 15),
                    child:TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          filled: true,
                          hintStyle: new TextStyle(color: Colors.grey),
                          hintText: "Complete Address",
                          fillColor: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child:  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: DropdownSearch<String>(
                      mode: Mode.MENU,
                      showSelectedItem: false,
                      items: ["Country1","Country2","Country3"],
                      label: "Select Country",
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
                  child:  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: DropdownSearch<String>(
                      mode: Mode.MENU,
                      showSelectedItem: false,
                      items: ["State1","State2","State3"],
                      label: "Select State",
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
                  child: Row(
                    children: [
                      Expanded(child:
                      Container(
                        child:TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              filled: true,
                              hintStyle: new TextStyle(color: Colors.grey),
                              hintText: "City",
                              fillColor: Colors.white),
                        ),
                      ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(child:  Container(
                        child:TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              filled: true,
                              hintStyle: new TextStyle(color: Colors.grey),
                              hintText: "ZipCode",
                              fillColor: Colors.white),
                        ),
                      ),)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20,bottom: 20),
                  child:SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      color: appTheme,
                      height: 40,
                      child:  Text(
                        'Update',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:16,
                            fontWeight: FontWeight.bold
                        ),),
                      onPressed:  (){


                      },
                    ),
                  ),
                ),
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
//   void _showPicker(context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return SafeArea(
//             child: Container(
//               child: new Wrap(
//                 children: <Widget>[
//                   new ListTile(
//                       leading: new Icon(Icons.photo_library),
//                       title: new Text('Photo Library'),
//                       onTap:(){
//                         getImage(ImageSource.gallery);
//                         Navigator.pop(context, true);
//                       }
//                   ),
//                   new ListTile(
//                     leading: new Icon(Icons.photo_camera),
//                     title: new Text('Camera'),
//                     onTap:(){
//                       getImage(ImageSource.camera);
//                       Navigator.pop(context, true);
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }
//     );
//
//   }

  // getImage(ImageSource source) async {
  //   this.setState(() {
  //     _inProcess=true;
  //   });
  //   File image= (await ImagePicker.pickImage(source: source)) as File;
  //   if(image !=null){
  //     File cropped= (await ImageCropper.cropImage(
  //         sourcePath:image.path,
  //         aspectRatio: CropAspectRatio(
  //             ratioX: 16,ratioY: 9),
  //         compressQuality: 100,
  //         compressFormat: ImageCompressFormat.jpg,
  //         androidUiSettings: AndroidUiSettings(
  //           toolbarColor: main_theme,
  //           toolbarTitle: "Fc Fitness",
  //           toolbarWidgetColor: white_theme,
  //           statusBarColor: main_theme,
  //           backgroundColor: Colors.white,
  //         )
  //     )) as File;
  //     this.setState(() {
  //       _selectedFile=cropped;
  //       _inProcess=false;
  //     });
  //   }else{
  //     this.setState(() {
  //       _inProcess=false;
  //     });
  //   }
  // }


  // Widget getImageWidget(){
  //   if(_selectedFile !=null){
  //     return Image.file(
  //       _selectedFile,
  //         fit: BoxFit.fill,
  //         height: 100.0,
  //         width: 100.0
  //     );
  //   } else {
  //     return Image.asset('images/user.png',
  //         fit: BoxFit.fill,
  //         height: 100.0,
  //         width: 100.0);
  //   }
  // }

}

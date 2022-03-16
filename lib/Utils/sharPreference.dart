import 'package:shared_preferences/shared_preferences.dart';

setLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("userLoggedIn", true);
}

Future<bool> getLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool userFound = prefs.getBool("userLoggedIn") ?? false;
  return userFound;
}

Future<bool> setUserId(String i) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print("sp $i");
  return await prefs.setString("LoginID", i);
}

Future<dynamic> getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.get("LoginID");
}

Future<bool> setOwnerId(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print("sp $id");
  return await prefs.setString("LoginID2", id);
}

Future<dynamic> getOwnerId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.get("LoginID2");
}

Future<bool> setUserName(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setString("LoginName", name);
}

Future<String> getUserName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("LoginName") ?? "Name";
}

Future<bool> setFcm(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setString("FcmToken", token);
}

Future<String> getFcmToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("FcmToken") ?? "";
}

Future<bool> setUserImage(String image) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setString("UserImage", image);
}

Future<String> getUserImage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("UserImage") ?? "image";
}

Future<bool> setHomeUi(String homeUi) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setString("HomeUi", homeUi);
}

Future<String> getHomeUi() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("HomeUi") ?? "Home";
}

Future<bool> setUserEmail(String email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setString("UserEmail", email);
}

Future<String> getUserEmail() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("UserEmail") ?? "Email";
}

Future<bool> setLinkedInLoginStatus(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setString("LoginToken", token);
}

Future<String> getLinkedInLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("LoginToken") ?? "";
}

setLinkedInLogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("LinkedUser", true);
}

getLinkedInLogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool userFound = prefs.getBool("LinkedUser") ?? false;
  return userFound;
}

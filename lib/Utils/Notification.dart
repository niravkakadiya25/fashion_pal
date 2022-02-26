import 'dart:io';

import 'package:fashionpal/Utils/sharPreference.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//--------------------------- Firebase FCM Configs -------------------------------------
// FirebaseDatabase getFeedbackFirebaseDB() {
//   return FirebaseDatabase(app: Firebase.app('db3'));
// }

Future<void> initFirebase() async {
  // print(FirebaseDatabase.instance.app);
  try {
    await _getFeedbackFirebaseConfig();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    //setting up platform specific local notification package implementation.
    await _platformSpecificLocalNotification();

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    //requesting permissions for ios and caching apn.
    _requestIOSPermission();
    //getting FCM token And caching it.
    _grabTokenAndCache();
  } catch (e) {
    debugPrint("Error Occurred while initializing FIREBASE:: $e");
  }
}

Future<void> _platformSpecificLocalNotification() async {
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  if (Platform.isIOS)
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
}

void _requestIOSPermission() {
  if (Platform.isIOS) {
    FirebaseMessaging.instance.requestPermission(sound: true, badge: true, alert: true);
    FirebaseMessaging.instance.getAPNSToken().then((apnToken) {
      if (apnToken != null) {
        // PrefController()
        //     .setIosAPNToken(apnToken)
        //     .then((v) => debugPrint("APN TOKEN Cached :-> $apnToken"));
      }
      debugPrint("APN TOKEN FOUND: $apnToken");
    });
  }
}

void _grabTokenAndCache() {
  FirebaseMessaging.instance.getToken().then((value) {
    if (value != null) {
      setFcmToken(value);
      // PrefController()
      //     .setFCMToken(value)
      //     .then((v) => debugPrint("Cached Token :-> $value"));
      debugPrint("FCM TOKEN $value");
      setFcm(value);
    }
  });
}

void setFcmToken(String fcmtoken) async {
  print("your dcm token is $fcmtoken");
  // await AppPrefrence.setString(AppConstants.fcmToken, fcmtoken);
}

Future<FirebaseApp> _getFeedbackFirebaseConfig() async {
  return await Firebase.initializeApp(
    // name: 'db3',
    // options: Platform.isIOS
    //     ? const FirebaseOptions(
    //     appId: '',
    //
    //     apiKey: "",
    //     messagingSenderId: '',
    //
    //     databaseURL:'',
    //     projectId: "")
    //     : const FirebaseOptions(
    //
    //     appId: '',
    //     apiKey: "",
    //     databaseURL: '',
    //     projectId: "",
    //     messagingSenderId: '')
  );
} //Firebase.app("db3");

//--------------------- Firebase Messaging configurations ----------------------

//
// initialize the Notification channel for android, this will help in receiving notification
// this is going to be a top-level initialization(i.e. global)

//MUST BE TOP-LEVEL
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  "This channel is used for important notifications.", // description
  importance: Importance.high,
);

//initialize our flutter local notifications plugin, this is also a top level initialization
//MUST BE TOP-LEVEL
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

/// Define a top-level named handler which background/terminated messages will
/// call.
///
/// To verify things are working, check out the native platform logs.
///MUST BE TOP-LEVEL
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await _getFeedbackFirebaseConfig();
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId} and message is: ${message.data}');

  //temp.
  // _buildNotificationPopUp(message);
}

//****** Setting listeners for firebase and flutter local notification initialization - context is needed. ********************
void setupFCMListeners(BuildContext context) {
  //--------Initializing Flutter local notification for Android-----------------
  var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

  //******************** Initializing local Notification for IOS ***************
  final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {});
  var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
  //   if (message != null) {
  //     final rs = RouteManager.getFCMRS(FCMArgs(message, true));
  //     Navigator.pushNamed(context, rs.name!, arguments: rs.arguments);
  //   }
  // });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("MESSAGE RECEIVED IN FG: ${message.messageId}");
    _buildNotificationPopUp(message);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('A new onMessageOpenedApp event was published!');
    // navigatorKey.currentState!.pushNamed(AppRoutes.fcmMsg, arguments: message);
    // Navigator.pushNamed(navigatorKey.currentContext, AppRoutes.fcmMsg,
    //     arguments: message);
  });

  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //   print('A new onMessageOpenedApp event was published!');
  //   RemoteNotification? notification = message.notification;
  //   AndroidNotification? android = message.notification?.android;
  //   if (notification != null && android != null) {
  //     showDialog(
  //         context: context,
  //         builder: (_) {
  //           return AlertDialog(
  //             title: Text(notification.title ?? "N/A Title"),
  //             content: SingleChildScrollView(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [Text(notification.body ?? "NA Body")],
  //               ),
  //             ),
  //           );
  //         });
  //   }
  // });
}

void _buildNotificationPopUp(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    print("Notification Condition Passed ");
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channel.description,
            color: Colors.blue,
            playSound: true,
            icon: '@mipmap/ic_launcher',
          ),
        ));
  } else {
    print("Notification Condition Failed ");
  }
}

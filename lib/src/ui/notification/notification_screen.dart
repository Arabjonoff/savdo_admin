// import 'dart:io';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:savdo_admin/main.dart';
//
// class PushNotifications {
//   static final _firebaseMessaging = FirebaseMessaging.instance;
//   static final FlutterLocalNotificationsPlugin
//   _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   // request notification permission
//   static Future init() async {
//     await _firebaseMessaging.requestPermission(
//       alert: true,
//       announcement: true,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//     // get the device fcm token
//     if(Platform.isIOS){
//       final token = await _firebaseMessaging.getAPNSToken();
//       print("apns token: $token");
//     }else{
//       final token = await _firebaseMessaging.getToken();
//       print("device token: $token");
//     }
//   }
//
// // initalize local notifications
//   static Future localNotiInit() async {
//     // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//     final DarwinInitializationSettings initializationSettingsDarwin =
//     DarwinInitializationSettings(
//       onDidReceiveLocalNotification: (id, title, body, payload) {},
//     );
//     const LinuxInitializationSettings initializationSettingsLinux =
//     LinuxInitializationSettings(defaultActionName: 'Open notification');
//     final InitializationSettings initializationSettings =
//     InitializationSettings(
//         android: initializationSettingsAndroid,
//         iOS: initializationSettingsDarwin,
//         linux: initializationSettingsLinux);
//     _flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onDidReceiveNotificationResponse: onNotificationTap,
//         onDidReceiveBackgroundNotificationResponse: onNotificationTap);
//   }
//
//   // on tap local notification in foreground
//   static void onNotificationTap(NotificationResponse notificationResponse) {
//     print(notificationResponse.payload);
//     navigatorKeyMessage.currentState!.pushNamed("/message", arguments: notificationResponse);
//   }
//
//   // show a simple notification
//   static Future showSimpleNotification({
//     required String title,
//     required String body,
//     required String payload,
//   }) async {
//     const AndroidNotificationDetails androidNotificationDetails =
//     AndroidNotificationDetails(
//         'goodChannelId',
//         'goodChannelName',
//         channelDescription: 'your channel description',
//         importance: Importance.max,
//         priority: Priority.high,
//         ticker: 'ticker');
//     const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);await _flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails, payload: payload);
//   }
// }
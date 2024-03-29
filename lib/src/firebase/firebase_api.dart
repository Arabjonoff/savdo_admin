// import 'package:app_settings/app_settings.dart';
// import 'package:flutter/material.dart';
//
// Future<void> handleBackgroundMessage(RemoteMessage remoteMessage)async{
//   print(remoteMessage.notification?.title);
//   print(remoteMessage.notification?.body);
// }
//
// class NotificationService{
//   final _fireBaseMessage = FirebaseMessaging.instance;
//
//   void requestNotificationPermission()async{
//     NotificationSettings notificationSettings = await _fireBaseMessage.requestPermission(
//         alert: true,
//         announcement: true,
//         badge: true,
//         carPlay: true,
//         criticalAlert: true,
//         sound: true);
//     if(notificationSettings.authorizationStatus == AuthorizationStatus.authorized){
//       print("authorized Okkkkk");
//     }
//     else {
//       AppSettings.openAppSettings(type: AppSettingsType.notification);
//       print("authorized Noooo");
//     }
//   }
//
//   // void initLocalNotifications(BuildContext context, RemoteMessage message)async{
//   //   var androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
//   //   var iosInitializationSettings = const DarwinInitializationSettings();
//   //
//   //   var initializationSetting = InitializationSettings(
//   //       android: androidInitializationSettings ,
//   //       iOS: iosInitializationSettings
//   //   );
//   //
//   //   await _flutterLocalNotificationsPlugin.initialize(
//   //       initializationSetting,
//   //       onDidReceiveNotificationResponse: (payload){
//   //         // handle interaction when app is active for android
//   //         handleMessage(context, message);
//   //       }
//   //   );
//   // }
//
//   void firebaseInit(){
//     FirebaseMessaging.onMessage.listen((message) {
//       print(message.notification!.title.toString());
//       print(message.notification!.body.toString());
//     });
//   }
//
//   Future<void> getDeviceToken() async {
//       try {
//         await _fireBaseMessage.requestPermission();
//         final fcmToken = await _fireBaseMessage.getToken();
//         print("TOKEN: $fcmToken");
//         FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
//       } catch (e) {
//         print("Error initializing notifications: $e");
//       }
//     }
//
//   void isTokenRefresh()async{
//     _fireBaseMessage.onTokenRefresh.listen((event) {
//       event.toString();
//     });
//   }
//
//
//   void handleMessage(BuildContext context, RemoteMessage message) {
//     if(message.data['type'] =='msj'){
//       // Navigator.push(context,
//       //     MaterialPageRoute(builder: (context) => MessageScreen(
//       //       id: message.data['id'] ,
//       //     )));
//     }
//   }
//   }

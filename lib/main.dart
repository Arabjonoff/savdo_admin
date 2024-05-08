import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/firebase_options.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/route/app_route.dart';
import 'package:savdo_admin/src/ui/notification/notification_screen.dart';
import 'package:savdo_admin/src/utils/cache.dart';
import 'package:savdo_admin/src/utils/certificate.dart';
import 'package:savdo_admin/src/widget/internet/internet_check_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
final navigatorKey = GlobalKey<NavigatorState>();
final navigatorKeyMessage = GlobalKey<NavigatorState>();
Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    // print("Some notification Received");
  }else{
    // print("Some notification Received");
  }
}
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (Platform.isAndroid) {
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
  }
  CacheService.init();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String token = preferences.getString("token")??'';
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  initNoInternetListener();
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      navigatorKey.currentState!.pushNamed("/message", arguments: message);
    }
  });

  PushNotifications.init();
  PushNotifications.localNotiInit();
  // Listen to background notifications
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);
  // to handle foreground notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = json.encode(message.data);
    if (message.notification != null) {
      PushNotifications.showSimpleNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: payloadData);
    }
  });

  // for handling in terminated state
  final RemoteMessage? message =
  await FirebaseMessaging.instance.getInitialMessage();

  if (message != null) {
    // print("Launched from terminated state");
    Future.delayed(const Duration(seconds: 1), () {
      navigatorKey.currentState!.pushNamed("/message", arguments: message);
    });
  }
  runApp( MyApp(token: token,));
}

class MyApp extends StatelessWidget {
  final String token;
  const MyApp({super.key, required this.token});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      ensureScreenSize: true,
      useInheritedMediaQuery: true,
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_,child){
        return MaterialApp(
          navigatorKey: navigatorKey,
          title: 'Naqsh Savdo',
          theme: ThemeData(
            platform: TargetPlatform.iOS,
            useMaterial3: true,
          ),
          onGenerateRoute: AppRoute.routes,
          initialRoute: token.isEmpty?AppRouteName.login:AppRouteName.splash,
          debugShowCheckedModeBanner: false,
          builder: (BuildContext context, Widget? child,) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
              child: child!,
            );
          },
        );
      },
    );
  }
}

updateConnectivity(dynamic hasConnection, ConnectionStatusListener connectionStatus,) {
  if (!hasConnection) {
    connectionStatus.hasShownNoInternet = true;
    CenterDialog.showInternetDialog(navigatorKey.currentState!.context, 'text',InternetCheckWidget(onTap: () {},));
  } else {
    if (connectionStatus.hasShownNoInternet) {
      connectionStatus.hasShownNoInternet = false;
    }
  }
}
initNoInternetListener() async {
  var connectionStatus = ConnectionStatusListener.getInstance();
  await connectionStatus.initialize();
  if (!connectionStatus.hasConnection) {
    updateConnectivity(false, connectionStatus);
  }
  connectionStatus.connectionChange.listen((event) {
    // internetBloc.connection(event);
    updateConnectivity(event, connectionStatus);
  });
}

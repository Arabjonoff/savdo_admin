import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/route/app_route.dart';
import 'package:savdo_admin/src/utils/cache.dart';
import 'package:savdo_admin/src/widget/internet/internet_check_widget.dart';
final navigatorKey = GlobalKey<NavigatorState>();
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  // if(Platform.isAndroid){
  //   await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //         apiKey: "AIzaSyAvbtnz63KfPeN4L10h9awVkM4jFKMIJi0",
  //         authDomain: "n-savdo.firebaseapp.com",
  //         projectId: "n-savdo",
  //         storageBucket: "n-savdo.appspot.com",
  //         messagingSenderId: "1045718509938",
  //         appId: "1:1045718509938:android:5a9e600ffb0f6ce68315eb",
  //         measurementId: "G-MXW0SET0LK"
  //     ),
  //   );
  // }else if(Platform.isIOS){
  //   await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //         apiKey: "AIzaSyBfNajAFmxxk7XetAw9ZFORrCm-AkmrTag",
  //         authDomain: "n-savdo.firebaseapp.com",
  //         projectId: "n-savdo",
  //         storageBucket: "n-savdo.appspot.com",
  //         messagingSenderId: "1045718509938",
  //         appId: "1:1045718509938:ios:4ced77f71ebdc3a08315eb",
  //         measurementId: "G-MXW0SET0LK"
  //     ),
  //   );
  // }
  // await NotificationService().getDeviceToken();§
  CacheService.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  initNoInternetListener();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          initialRoute: AppRouteName.login,
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

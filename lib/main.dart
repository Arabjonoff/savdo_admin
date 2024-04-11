import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/route/app_route.dart';
import 'package:savdo_admin/src/utils/cache.dart';
import 'package:savdo_admin/src/widget/internet/internet_check_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
final navigatorKey = GlobalKey<NavigatorState>();
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // await FirebaseMessaging.instance.requestPermission();
  // if (Platform.isAndroid) {
  //   await FirebaseMessaging.instance.setAutoInitEnabled(true);
  // }
  CacheService.init();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String token = preferences.getString("token")??'';
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  initNoInternetListener();
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

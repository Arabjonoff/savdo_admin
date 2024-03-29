// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:n_savdo_admin/src/theme/colors/app_colors.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class ThemeProvider with ChangeNotifier{
//   bool isLightTheme;
//   ThemeProvider({required this.isLightTheme});
//
//   getCurrentNavigationBarColor(){
//     if(isLightTheme){
//       SystemChrome.setSystemUIOverlayStyle(
//           const SystemUiOverlayStyle(
//               statusBarColor: Colors.transparent,
//               statusBarBrightness: Brightness.light,
//               statusBarIconBrightness: Brightness.dark,
//               systemNavigationBarColor: Colors.white,
//               systemNavigationBarIconBrightness:Brightness.dark
//           )
//       );
//     }
//     else{
//       SystemChrome.setSystemUIOverlayStyle(
//           const SystemUiOverlayStyle(
//               statusBarColor: Colors.transparent,
//               statusBarBrightness: Brightness.light,
//               statusBarIconBrightness: Brightness.dark,
//               systemNavigationBarColor: Colors.red,
//               systemNavigationBarIconBrightness:Brightness.dark
//           )
//       );
//     }
//   }
//
//   toggleThemeData() async {
//     if(isLightTheme){
//       SharedPreferences preferences = await SharedPreferences.getInstance();
//       preferences.setBool('themeMode', false);
//       isLightTheme = !isLightTheme;
//       notifyListeners();
//     }
//     else{
//       SharedPreferences preferences = await SharedPreferences.getInstance();
//       preferences.setBool('themeMode', true);
//       isLightTheme = !isLightTheme;
//       notifyListeners();
//     }
//     getCurrentNavigationBarColor();
//     notifyListeners();
//   }
//
//   ThemeData themeData(){
//     return ThemeData(
//         useMaterial3: true,
//         platform: TargetPlatform.iOS,
//         brightness: isLightTheme?Brightness.light:Brightness.dark,
//         scaffoldBackgroundColor: isLightTheme?AppColors.backgroundLight:AppColors.backgroundDark
//     );
//   }
//
//   ThemeMode themeMode(){
//     return ThemeMode(
//         cardColor: isLightTheme?AppColors.cardLight:AppColors.cardDark,
//         textColor: isLightTheme?AppColors.textLight:AppColors.textDark,
//         textColorBold: isLightTheme?AppColors.textBoldLight:AppColors.textDark
//     );
//   }
// }
//
// class ThemeMode{
//   Color cardColor;
//   Color textColor;
//   Color textColorBold;
//   ThemeMode({required this.cardColor,required this.textColor,required this.textColorBold});
// }
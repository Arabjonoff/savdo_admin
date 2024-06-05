import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/route/app_route.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/utils/cache.dart';
import 'package:savdo_admin/src/widget/button/button_widget.dart';
import 'package:savdo_admin/src/widget/textfield/textfield_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // NotificationService notificationService = NotificationService();
  final Repository _repository = Repository();
  final TextEditingController _controllerName = TextEditingController(text: "");
  final TextEditingController _controllerPassword = TextEditingController(text: "");
  final TextEditingController _controllerBase = TextEditingController(text: "");
@override
  void initState() {
  // notificationService.requestNotificationPermission();
  // notificationService.firebaseInit();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.0.w),
                  child: Text("Исм",style: AppStyle.small(Colors.black),),
                ),
                TextFieldWidget(controller: _controllerName, hintText: "Исм"),
                Padding(
                  padding: EdgeInsets.only(left: 16.0.w),
                  child: Text("Пароль",style: AppStyle.small(Colors.black),),
                ),
                TextFieldWidget(controller: _controllerPassword, hintText: "Пароль"),
                Padding(
                  padding: EdgeInsets.only(left: 16.0.w),
                  child: Text("База рақами",style: AppStyle.small(Colors.black),),
                ),
                TextFieldWidget(controller: _controllerBase, hintText: "База рақами"),
              ],
            ),
          ),
          ButtonWidget(onTap: ()async{
            CenterDialog.showLoadingDialog(context, "Бироз кутинг");
            HttpResult res = await _repository.login(_controllerName.text, _controllerPassword.text, _controllerBase.text);
            try{
              if(res.isSuccess){
                if(res.result['tip'] == 0 || res.result['tip'] == 2||res.result['tip'] == 3 ||res.result['tip'] == 4){
                  CacheService.saveToken(res.result['jwt']);
                  CacheService.savePassword(_controllerPassword.text);
                  CacheService.saveName(_controllerName.text);
                  CacheService.tip(res.result['tip'].toString());
                  CacheService.saveIdAgent(res.result['id']);
                  CacheService.saveDb(_controllerBase.text);
                  if(res.result["id_skl"] == -1){
                    CacheService.saveWareHouseName("Asosiy ombor");
                    CacheService.saveWareHouseId(1);
                  }else if(res.result["id_skl"] == 1){
                    CacheService.saveWareHouseName("Ko'shimcha ombor");
                    CacheService.saveWareHouseId(2);
                  }
                  else if(res.result["id_skl"] == 2){
                    CacheService.saveWareHouseName("Улгуржа савдо");
                    CacheService.saveWareHouseId(3);
                  }
                  if(context.mounted)Navigator.popUntil(context, (route) => route.isFirst);
                  if(context.mounted)Navigator.pushReplacementNamed(context, AppRouteName.splash);
                }
                else{
                  if(context.mounted)Navigator.pop(context);
                  if(context.mounted)CenterDialog.showErrorDialog(context, "Киришга рухсат йўқ");
                }
              }
              else{
                if(context.mounted)Navigator.pop(context);
                if(context.mounted)CenterDialog.showErrorDialog(context, res.result['message']);
              }
            }catch(e){
              if(context.mounted)Navigator.pop(context);
              if(context.mounted)CenterDialog.showErrorDialog(context, "Маълумотда хатолик бор текшириб қайта киритинг");
            }
          }, color: AppColors.green, text: "Кириш"),
          SizedBox(height: 24.h,)
        ],
      ),
    );
  }
}

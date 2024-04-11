// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/route/app_route.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/utils/cache.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Repository _repository = Repository();
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1)).then((value)async{
      HttpResult response = await _repository.login(CacheService.getName(), CacheService.getPassword(), CacheService.getDb());
      if(response.result['status'] == true){
        Future.delayed(const Duration(seconds: 2)).then((value) {
          CacheService.saveToken(response.result['jwt']);
          if(context.mounted)Navigator.popUntil(context, (route) => route.isFirst);
          if(context.mounted)Navigator.pushReplacementNamed(context, AppRouteName.main);
        });
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Center(child: SvgPicture.asset("assets/icons/logo.svg",width: 100.spMax,)),
          SizedBox(height: 12.h,),
          Text("N-Savdo",style: AppStyle.extraLarge(Colors.black),),
          const Spacer(),
          const CircularProgressIndicator.adaptive(),
          SizedBox(height: 12.h,),
          Text("Power by Naqsh Group",style: AppStyle.small(Colors.black),),
          SizedBox(height: 34.h,),
        ],
      ),
    );
  }
}

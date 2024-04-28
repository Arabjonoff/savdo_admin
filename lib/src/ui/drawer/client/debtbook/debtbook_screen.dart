import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';

class DebtBookScreen extends StatefulWidget {
  const DebtBookScreen({super.key});

  @override
  State<DebtBookScreen> createState() => _DebtBookScreenState();
}

class _DebtBookScreenState extends State<DebtBookScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text("Қарздорлик китоби")
      ),
      body: ListView.builder(itemBuilder: (ctx,index){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 8.r,horizontal: 16.w),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Colors.grey.shade300
                  )
              ),
              color: Colors.white
          ),
          child: Row(
            children: [
              CircleAvatar(
                child:Text("M",style: AppStyle.mediumBold(Colors.black),),
              ),
              SizedBox(width: 8.w,),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Muhammad ali",style: AppStyle.mediumBold(Colors.black),),
                  Text("123 231 312",style: AppStyle.small(Colors.black),),
                ],
              )),
            ],
          ),
        );
      })
    );
  }
}

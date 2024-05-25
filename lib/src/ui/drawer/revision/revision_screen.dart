import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/bloc/revision/revision_bloc.dart';
import 'package:savdo_admin/src/model/revision/revision_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/drawer/returend/returned_list_screen.dart';
import 'package:savdo_admin/src/ui/drawer/revision/revision_list.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:snapping_sheet_2/snapping_sheet.dart';

class RevisionScreen extends StatefulWidget {
  const RevisionScreen({super.key});

  @override
  State<RevisionScreen> createState() => _RevisionScreenState();
}

class _RevisionScreenState extends State<RevisionScreen> {
  @override
  void initState() {
    revisionBloc.getAllRevision();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ревизия"),
      ),
      body: StreamBuilder<List<RevisionResult>>(
        stream: revisionBloc.getRevisionStream,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            var data = snapshot.data!;
            return SnappingSheet(
              grabbingHeight: 65.spMax,
              grabbing: GestureDetector(
                onTap: ()async{
                  Navigator.push(context, MaterialPageRoute(builder: (ctx){
                    return RevisionListScreen();
                  }));
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  decoration:  BoxDecoration(
                    color: AppColors.green,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                  ),
                  child: Text("Янги киритиш",style: AppStyle.large(Colors.white),),
                ),
              ),
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (ctx,index){
                return GestureDetector(
                  onTap: (){
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: AppColors.card,
                        border:  Border(bottom: BorderSide(color: Colors.grey.shade400)
                        )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Container(
                        //   padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
                        //   decoration: BoxDecoration(
                        //       color: AppColors.green,
                        //       borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
                        //   ),
                        //   child: Text(data[index].agentName,style: AppStyle.smallBold(Colors.white),),
                        // ),
                        SizedBox(height: 4.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(data[index].agentName,style: AppStyle.mediumBold(Colors.black),),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: 1 ==1?Colors.red:AppColors.green
                                ),
                                child: Text("№: ${data[index].ndoc}",style: AppStyle.medium(Colors.white),)),
                          ],
                        ),
                        Text(data[index].izoh,style: AppStyle.small(Colors.grey),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Жами:",style: AppStyle.medium(Colors.black),),
                          ],
                        ),
                        SizedBox(height: 4.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Вақти',style: AppStyle.small(Colors.black),),
                            Text("data[index].vaqt.toString().substring(10,19)",style: AppStyle.small(Colors.black),),
                          ],
                        ),
                        SizedBox(height: 4.h,),
                      ],
                    ),
                  ),
                );
              }
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        }
      ),
    );
  }
}

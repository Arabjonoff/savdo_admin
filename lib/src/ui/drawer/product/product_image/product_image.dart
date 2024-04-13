// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';

class ProductImageScreen extends StatefulWidget {
  final String idSkl2;
  const ProductImageScreen({super.key, required this.idSkl2});

  @override
  State<ProductImageScreen> createState() => _ProductImageScreenState();
}

class _ProductImageScreenState extends State<ProductImageScreen> {
  final Repository _repository = Repository();
  final picker = ImagePicker();
  XFile _image = XFile('path');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 200.h,
            child: Image.file(File(_image.path,),errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace)=> Center(child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_photo_alternate_outlined,size: 60.r,),
                TextButton(onPressed: ()=> getImageFromGallery(), child: Text("Расим қўшиш",style: AppStyle.medium(AppColors.green),))
              ],
            )),
            fit: BoxFit.cover,)
          ),
          TextButton(onPressed: ()async{
            HttpResult  res = await _repository.postImage(_image.path, widget.idSkl2);
            if(res.result['status'] == true){
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res.result['message'])));
            }
            else{
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res.result['message']),backgroundColor: Colors.red,));
            }
          }, child: Text("Расмини сақлаш",style: AppStyle.medium(AppColors.green)))
        ],
      ),
    );
  }
  Future getImageFromGallery() async {
    final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        maxWidth: 800,
        maxHeight: 800
    );
    setState(() {
      _image = image!;
    });
  }

}

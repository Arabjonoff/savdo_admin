import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';

class EmptyWidgetScreen extends StatelessWidget {
  const EmptyWidgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
         child: EmptyWidget(
           hideBackgroundAnimation: true,
           image: null,
           packageImage: PackageImage.Image_3,
           title: 'Маълумотлар топилмади',
           subTitle: 'Ушбу санада ҳеч қандай маълумотлар йўқ',
           titleTextStyle: const TextStyle(
             fontSize: 22,
             color: Color(0xff9da9c7),
             fontWeight: FontWeight.w500,
           ),
           subtitleTextStyle: const TextStyle(
             fontSize: 12,
             color: Color(0xffabb8d6),
           ),
         ),
       ),
    );
  }
}

import 'package:flutter/material.dart';

class CardMenuItemWidget extends StatelessWidget {
  const CardMenuItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 100,
    );
  }
}

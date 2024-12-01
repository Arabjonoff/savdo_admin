import 'package:flutter/material.dart';

class EmptyWidgetScreen extends StatelessWidget {
  const EmptyWidgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
         child: Text("MAlumotlar yo'q"),
       ),
    );
  }
}

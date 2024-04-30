import 'package:flutter/material.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';

class DebtBookDetail extends StatefulWidget {
  const DebtBookDetail({super.key});

  @override
  State<DebtBookDetail> createState() => _DebtBookDetailState();
}

class _DebtBookDetailState extends State<DebtBookDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: AppColors.background,
    );
  }
}

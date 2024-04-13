import 'package:flutter/material.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';

class WarehouseProductDetailScreen extends StatefulWidget {
  const WarehouseProductDetailScreen({super.key});

  @override
  State<WarehouseProductDetailScreen> createState() => _WarehouseProductDetailScreenState();
}

class _WarehouseProductDetailScreenState extends State<WarehouseProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Container(
            width: width,
          )
        ],
      ),
    );
  }
}

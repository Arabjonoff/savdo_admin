import 'package:flutter/material.dart';

class WareHouseToScreen extends StatefulWidget {
  final Map<String,dynamic> data;
  const WareHouseToScreen({super.key, required this.data});

  @override
  State<WareHouseToScreen> createState() => _WareHouseToScreenState();
}

class _WareHouseToScreenState extends State<WareHouseToScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // bottom: PreferredSize(
        //   preferredSize: const Size.fromHeight(0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
        //     children: [
        //       TextButton(onPressed: (){}, child: const Text("Харажат")),
        //       TextButton(onPressed: (){}, child: const Text("Таннархи сони")),
        //       TextButton(onPressed: (){}, child: const Text("Таннархи суммаси")),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}

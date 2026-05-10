import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/core_export.dart';
import '../controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<HomeController>();

    return Scaffold(
      // appBar: AppBar(
      //   title: const CustomText('Home', variant: TextVariant.headlineSmall),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.refresh_outlined),
      //       onPressed: ctrl.refresh,
      //     ),
      //   ],
      // ),
      body: Center(child: Text(AppStaticStrings.home)),
    );
  }
}

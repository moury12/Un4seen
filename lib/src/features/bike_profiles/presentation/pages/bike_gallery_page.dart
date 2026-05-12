import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/core_export.dart';

class BikeGalleryPage extends StatelessWidget {
  const BikeGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStaticStrings.bikeGallery.tr,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GridView.builder(
          padding: AppPadding.getPadding12(context),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.2,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?q=80&w=500&img=$index',
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }
}

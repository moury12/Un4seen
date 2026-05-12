import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/core_export.dart';

class StoryUserInfo extends StatelessWidget {
  final String name;
  final String time;
  final String image;

  const StoryUserInfo({
    super.key,
    required this.name,
    required this.time,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(image),
          ),
          space8W,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                name,
                color: Colors.white,
                variant: TextVariant.labelMedium,
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                time,
                color: Colors.white.withValues(alpha: 0.7),
                variant: TextVariant.labelSmall,
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
  }
}

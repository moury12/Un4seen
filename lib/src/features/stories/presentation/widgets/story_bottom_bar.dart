import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/core_export.dart';

class StoryBottomBar extends StatelessWidget {
  final VoidCallback onJoinTap;
  final Function(String) onMessageSent;

  const StoryBottomBar({
    super.key,
    required this.onJoinTap,
    required this.onMessageSent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Join Button
          GestureDetector(
            onTap: onJoinTap,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.kPrimaryColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: CustomText(
                  AppStaticStrings.joinSyndicate.tr,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  variant: TextVariant.titleSmall,
                ),
              ),
            ),
          ),
          space12H,
          // Message Row
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 45,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                  ),
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: AppStaticStrings.sendMessage.tr,
                      hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
                      border: InputBorder.none,
                    ),
                    onSubmitted: onMessageSent,
                  ),
                ),
              ),
              space12W,
              const Icon(Icons.camera_alt_outlined, color: Colors.white),
              space12W,
              const Icon(Icons.favorite_border, color: Colors.white),
              space12W,
              const Icon(Icons.share_outlined, color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }
}

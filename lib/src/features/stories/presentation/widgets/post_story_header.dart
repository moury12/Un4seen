import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:un4seen/src/core/core_export.dart';
import 'package:get/get.dart';

class PostStoryHeader extends StatelessWidget {
  const PostStoryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.getPadding12(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            AppStaticStrings.postYourStory.tr,
            variant: TextVariant.titleLarge,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: AppColors.kPrimaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

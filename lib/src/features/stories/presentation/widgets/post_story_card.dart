import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:un4seen/src/core/core_export.dart';
import 'package:un4seen/src/core/routes/app_routes.dart';
import 'package:un4seen/src/features/stories/presentation/widgets/story_card_custom_shape.dart';
import 'package:get/get.dart';

class PostStoryCard extends StatelessWidget {
  const PostStoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.postStory),
      child: GenericSlantedCard(
        isLeft: true,
        borderRadius: 14,
        slantHeight: 25,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.kPrimaryDarkColor3, AppColors.kPrimaryColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            // spacing: 7,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: AppColors.kPrimaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  CupertinoIcons.add,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              space12H,
              Text(
                AppStaticStrings.postYourStory.tr,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                AppStaticStrings.shareYourRide.tr,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

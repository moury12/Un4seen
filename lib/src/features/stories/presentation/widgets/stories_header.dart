import 'package:flutter/material.dart';
import 'package:un4seen/src/core/core_export.dart';
import 'package:get/get.dart';
import 'package:un4seen/src/features/stories/presentation/widgets/announcements_button.dart';

class StoriesHeader extends StatelessWidget {
  const StoriesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStaticStrings.syndicateStories.tr,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.kTextColor,
          ),
        ),
        Text(
          AppStaticStrings.membersStoriesCheckThemOut.tr,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.kSecondaryTextColor,
          ),
        ),
        // const SizedBox(width: 4),
        const AnnouncementsButton(),
      ],
    );
  }
}

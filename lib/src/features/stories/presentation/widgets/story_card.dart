import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:un4seen/src/core/core_export.dart';
import 'package:un4seen/src/core/routes/app_routes.dart';
import 'package:un4seen/src/features/stories/data/models/story_model.dart';
import 'package:un4seen/src/features/stories/presentation/stories_presentation_export.dart';
import 'package:un4seen/src/features/stories/presentation/widgets/story_bottom_bar.dart';
import '../widgets/story_card_custom_shape.dart';

class StoryCard extends StatelessWidget {
  final bool isLeft;
  final StoryModel story;
  final bool isFromSaved;

  const StoryCard({
    super.key,
    required this.isLeft,
    required this.story,
    this.isFromSaved = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(
        AppRoutes.storyFull,
        extra: story,
      ),
      child: GenericSlantedCard(
        isLeft: isLeft,
        borderRadius: 14,
        slantHeight: 25,
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: CustomNetworkImage(
                imageUrl: story.content,
                fit: BoxFit.cover,
              ),
            ),

            // Top Badges
            Positioned(
              top: 25,
              left: isLeft ? null : 12,
              right: isLeft ? 12 : null,
              child: Column(
                crossAxisAlignment: isLeft
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  buildBadgeWidget(story.user.fullName, context),
                  const SizedBox(height: 4),
                  buildBadgeWidget(story.user.memberNumber, context),
                ],
              ),
            ),

            // Interaction Icons
            Positioned(
              bottom: 10,
              left: isLeft ? 12 : null,
              right: isLeft ? null : 12,
              child: isFromSaved
                  ? Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: AppColors.kPrimaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.bookmark,
                        color: Colors.white,
                        size: 18,
                      ),
                    )
                  : Column(
                      spacing: 6,
                      children: [
                        Row(
                          children: [
                            CustomIconButtonWidget(
                              padding: 8,
                              iconSize: 13,
                              image: AppIcons.fire,
                              colorFilter: ColorFilter.mode(
                                story.isHearted
                                    ? AppColors.kPrimaryColor
                                    : Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                            space8W,
                            if (story.heartCount > 0)
                              CustomText(
                                story.heartCount.toString(),
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                          ],
                        ),
                        CustomIconButtonWidget(
                          padding: 8,
                          iconSize: 13,
                          iconData: story.isSaved
                              ? CupertinoIcons.bookmark_fill
                              : CupertinoIcons.bookmark,
                        ),
                      ],
                    ),
            ),

            // Time Text
            Positioned(
              bottom: 30,
              right: isLeft ? 12 : null,
              left: isLeft ? null : 12,
              child: CustomText(
                story.timeAgo,
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

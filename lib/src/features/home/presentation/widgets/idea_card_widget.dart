import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/core_export.dart';
import '../../data/models/idea_model.dart';

class IdeaCardWidget extends StatelessWidget {
  final IdeaModel model;
  final VoidCallback onUpvote;

  const IdeaCardWidget({
    super.key,
    required this.model,
    required this.onUpvote,
  });

  @override
  Widget build(BuildContext context) {
    // Dynamically select icon based on category/title content
    String icon = AppIcons.ideas;
    final categoryLower = model.category.toLowerCase();
    if (categoryLower.contains('meetup') ||
        categoryLower.contains('chat') ||
        categoryLower.contains('feedback')) {
      icon = AppIcons.chat;
    } else if (categoryLower.contains('cell') ||
        categoryLower.contains('phone') ||
        categoryLower.contains('decal')) {
      icon = AppIcons.cell;
    } else if (categoryLower.contains('pad') ||
        categoryLower.contains('color') ||
        categoryLower.contains('design') ||
        categoryLower.contains('plate')) {
      icon = AppIcons.colorPlate;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.kPrimaryColor, AppColors.kPrimaryDarkColor3],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon in circle
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              icon,
              height: 24,
              width: 24,
              colorFilter: const ColorFilter.mode(
                AppColors.kPrimaryColor,
                BlendMode.srcIn,
              ),
            ),
          ),
          space12W,
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  model.title,
                  variant: TextVariant.titleMedium,
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                space4H,
                CustomText(
                  model.description,
                  variant: TextVariant.bodySmall,
                  fontSize: 12,
                  color: Colors.white,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                space12H,
                Row(
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundImage: model.user.image.isNotEmpty
                          ? NetworkImage(model.user.image)
                          : const NetworkImage(
                              'https://i.pravatar.cc/150?u=temp_user',
                            ),
                    ),
                    space8W,
                    CustomText(
                      '${model.user.fullName} • ${formatDate(model.createdAt)}',
                      variant: TextVariant.labelSmall,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
          space8W,
          // Upvote button
          GestureDetector(
            onTap: onUpvote,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: model.isUpvoted
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    model.isUpvoted ? Icons.thumb_up : Icons.thumb_up_outlined,
                    size: 16,
                    color:
                        model.isUpvoted ? AppColors.kPrimaryColor : Colors.white,
                  ),
                  space4H,
                  CustomText(
                    model.upvoteCount.toString(),
                    variant: TextVariant.labelSmall,
                    color:
                        model.isUpvoted ? AppColors.kPrimaryColor : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

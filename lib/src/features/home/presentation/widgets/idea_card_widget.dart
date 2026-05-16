import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/core_export.dart';

class IdeaCardWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String description;
  final String userName;
  final String date;
  final int upvotes;
  final String userImage;

  const IdeaCardWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.userName,
    required this.date,
    required this.upvotes,
    required this.userImage,
  });

  @override
  Widget build(BuildContext context) {
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
                  title,
                  variant: TextVariant.titleMedium,
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                space4H,
                CustomText(
                  description,
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
                      backgroundImage: NetworkImage(userImage),
                    ),
                    space8W,
                    CustomText(
                      '$userName • $date',
                      variant: TextVariant.labelSmall,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
          space8W,
          // Upvote badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.thumb_up_outlined,
                  size: 16,
                  color: AppColors.kPrimaryColor,
                ),
                space4H,
                CustomText(
                  upvotes.toString(),
                  variant: TextVariant.labelSmall,
                  color: AppColors.kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:un4seen/src/core/core_export.dart';
import 'package:un4seen/src/features/profile/data/models/announcement_model.dart';
import 'package:un4seen/src/features/profile/presentation/widgets/announcement_video_player.dart';

class AnnouncementCardWidget extends StatelessWidget {
  final AnnouncementModel announcement;
  final VoidCallback onHeartTap;
  final VoidCallback onSaveTap;

  const AnnouncementCardWidget({
    super.key,
    required this.announcement,
    required this.onHeartTap,
    required this.onSaveTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: AppPadding.getPadding12(context),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.kPrimaryDarkColor, AppColors.kPrimaryDarkColor2],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.kPrimaryDarkColor2, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header: User Avatar & Info ───────────────────
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.kPrimaryColor,
                    width: 1.5,
                  ),
                ),
                child: ClipOval(
                  child: CustomNetworkImage(
                    imageUrl: announcement.user.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: CustomText(
                            announcement.user.fullName,
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.kPrimaryColor.withValues(
                              alpha: 0.2,
                            ),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: AppColors.kPrimaryColor.withValues(
                                alpha: 0.5,
                              ),
                              width: 0.5,
                            ),
                          ),
                          child: CustomText(
                            announcement.user.role.isNotEmpty
                                ? announcement.user.role
                                : 'Official',
                            color: AppColors.kPrimaryColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        if (announcement.user.memberNumber.isNotEmpty) ...[
                          CustomText(
                            announcement.user.memberNumber,
                            color: AppColors.kSecondaryTextColor,
                            fontSize: 11,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            '•',
                            style: TextStyle(
                              color: AppColors.kSecondaryTextColor,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        if (announcement.timeAgo.isNotEmpty)
                          CustomText(
                            announcement.timeAgo,
                            color: AppColors.kSecondaryTextColor,
                            fontSize: 11,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ── Media Content (Image or Video) ────────────────
          if (announcement.content.isNotEmpty) ...[
            if (announcement.contentType == 'video')
              AnnouncementVideoPlayer(videoUrl: announcement.content)
            else
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CustomNetworkImage(
                  imageUrl: announcement.content,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 12),
          ],

          // ── Title & Caption ──────────────────────────────
          if (announcement.title.isNotEmpty) ...[
            CustomText(
              announcement.title,
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 4),
          ],

          if (announcement.caption.isNotEmpty) ...[
            CustomText(
              announcement.caption,
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 13,
              height: 1.4,
            ),
            const SizedBox(height: 8),
          ],

          // ── Music Info (if present) ───────────────────────
          if (announcement.music != null &&
              announcement.music!.title.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.1),
                  width: 0.5,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.music_note,
                    color: AppColors.kPrimaryColor,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: CustomText(
                      announcement.music!.title,
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (announcement.music!.category.isNotEmpty) ...[
                    const SizedBox(width: 6),
                    CustomText(
                      '(${announcement.music!.category})',
                      color: AppColors.kSecondaryTextColor,
                      fontSize: 11,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],

          // ── Expiration Date (if available) ─────────────────
          if (announcement.expiresAt != null &&
              announcement.expiresAt!.isNotEmpty) ...[
            Row(
              children: [
                const Icon(
                  Icons.timer_outlined,
                  color: AppColors.kSecondaryTextColor,
                  size: 13,
                ),
                const SizedBox(width: 4),
                CustomText(
                  'Expires: ${formatDate(announcement.expiresAt!)}',
                  color: AppColors.kSecondaryTextColor,
                  fontSize: 11,
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],

          const Divider(color: Colors.white10, height: 16),

          // ── Action Buttons (Heart & Save) ────────────────
          Row(
            children: [
              // Heart action button
              InkWell(
                onTap: onHeartTap,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        announcement.isHearted
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: announcement.isHearted
                            ? AppColors.kPrimaryColor
                            : Colors.white70,
                        size: 20,
                      ),
                      const SizedBox(width: 6),
                      CustomText(
                        '${announcement.heartCount}',
                        color: announcement.isHearted
                            ? AppColors.kPrimaryColor
                            : Colors.white70,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // Save action button
              InkWell(
                onTap: onSaveTap,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        announcement.isSaved
                            ? CupertinoIcons.bookmark_fill
                            : CupertinoIcons.bookmark,
                        color: announcement.isSaved
                            ? AppColors.kPrimaryColor
                            : Colors.white70,
                        size: 19,
                      ),
                      const SizedBox(width: 6),
                      CustomText(
                        announcement.isSaved ? 'Saved' : 'Save',
                        color: announcement.isSaved
                            ? AppColors.kPrimaryColor
                            : Colors.white70,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

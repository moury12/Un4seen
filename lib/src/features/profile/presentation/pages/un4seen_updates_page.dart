import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:un4seen/src/core/core_export.dart';
import 'package:un4seen/src/features/profile/presentation/controllers/un4seen_updates_controller.dart';
import 'package:un4seen/src/features/profile/presentation/widgets/announcement_video_player.dart';

class Un4seenUpdatesPage extends StatefulWidget {
  const Un4seenUpdatesPage({super.key});

  @override
  State<Un4seenUpdatesPage> createState() => _Un4seenUpdatesPageState();
}

class _Un4seenUpdatesPageState extends State<Un4seenUpdatesPage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late final Un4seenUpdatesController controller;

  // Animation for Heart Pop
  late AnimationController _fireController;
  late Animation<double> _scaleAnimation;
  bool _showFire = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    controller = Get.isRegistered<Un4seenUpdatesController>()
        ? Get.find<Un4seenUpdatesController>()
        : Get.put(Un4seenUpdatesController(), permanent: true);

    _fireController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: 1.3,
        ).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.3,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.linear)),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 20,
      ),
    ]).animate(_fireController);

    // Mark updates as read after frame build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.markAsRead();
    });
  }

  void _handleDoubleTap() {
    if (controller.announcements.isEmpty) return;
    final announcement =
        controller.announcements[controller.currentAnnouncementIndex.value];
    setState(() => _showFire = true);

    if (!announcement.isHearted) {
      controller.toggleHeart(announcement);
    }

    _fireController.forward(from: 0.0).then((_) {
      if (mounted) setState(() => _showFire = false);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller.closeViewer();
    _fireController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      controller.pauseStory();
    } else if (state == AppLifecycleState.resumed) {
      controller.resumeStory();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        if (controller.isLoading.value && controller.announcements.isEmpty) {
          return const Center(child: AppLoader());
        }

        if (controller.hasError.value && controller.announcements.isEmpty) {
          return EmptyStateWidget(
            message: controller.errorMessage.value.isNotEmpty
                ? controller.errorMessage.value
                : 'Failed to load announcements',
            icon: Icons.error_outline,
            onRetry: () => controller.fetchAnnouncements(),
            retryLabel: 'Retry',
          );
        }

        if (controller.announcements.isEmpty) {
          return EmptyStateWidget(
            message: 'No Un4seen updates available right now.',
            icon: Icons.campaign_outlined,
            onRetry: () => controller.fetchAnnouncements(isRefresh: true),
            retryLabel: 'Refresh',
          );
        }

        final announcement =
            controller.announcements[controller.currentAnnouncementIndex.value];

        return GestureDetector(
          onDoubleTap: _handleDoubleTap,
          onLongPressStart: (_) => controller.pauseStory(),
          onLongPressEnd: (_) => controller.resumeStory(),
          onTapUp: (details) {
            final width = MediaQuery.of(context).size.width;
            if (details.globalPosition.dx < width / 3) {
              controller.previousAnnouncement();
            } else {
              controller.nextAnnouncement();
            }
          },
          child: Stack(
            children: [
              // 1. Full Screen Content (Image or Video)
              Positioned.fill(
                child: announcement.contentType == 'video'
                    ? AnnouncementVideoPlayer(
                        videoUrl: announcement.content,
                        hasMusic:
                            announcement.music != null &&
                            announcement.music!.audioUrl.isNotEmpty,
                        isSoundOn: controller.isSoundOn.value,
                      )
                    : CustomNetworkImage(
                        imageUrl: announcement.content,
                        fit: BoxFit.cover,
                      ),
              ),

              // 2. Gradient Overlays for top and bottom readability
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withValues(alpha: 0.75),
                        Colors.transparent,
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.85),
                      ],
                      stops: const [0.0, 0.2, 0.55, 1.0],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),

              // 3. Top Section: Progress Bars & User Header
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Progress Indicators
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      child: Row(
                        children: List.generate(
                          controller.announcements.length,
                          (index) {
                            double progress = 0.0;
                            if (index <
                                controller.currentAnnouncementIndex.value) {
                              progress = 1.0;
                            } else if (index ==
                                controller.currentAnnouncementIndex.value) {
                              progress = controller.currentProgress.value;
                            }

                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 2,
                                ),
                                child: LinearProgressIndicator(
                                  value: progress,
                                  backgroundColor: Colors.white24,
                                  valueColor: const AlwaysStoppedAnimation(
                                    Colors.white,
                                  ),
                                  minHeight: 2.5,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    // User Header Row
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
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
                                CustomText(
                                  announcement.user.fullName,
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                if (announcement.timeAgo.isNotEmpty)
                                  CustomText(
                                    announcement.timeAgo,
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                              ],
                            ),
                          ),

                          // Close (X) Button
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              controller.closeViewer();
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withValues(alpha: 0.4),
                              ),
                              child: const Icon(
                                CupertinoIcons.multiply,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // 4. Double Tap Heart Pop Animation Overlay
              if (_showFire)
                Center(
                  child: AnimatedBuilder(
                    animation: _scaleAnimation,
                    builder: (context, child) => Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Opacity(
                        opacity: _scaleAnimation.value.clamp(0.0, 1.0),
                        child: child,
                      ),
                    ),
                    child: SvgPicture.asset(
                      AppIcons.fire,
                      height: 120,
                      width: 120,
                      colorFilter: const ColorFilter.mode(
                        AppColors.kPrimaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),

              // 5. Bottom Overlay: Music Chip, Title, Caption & Action Bar
              Positioned(
                bottom: 30,
                left: 16,
                right: 16,
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Music Pill Chip (Matching Screenshot)
                      if (announcement.music != null &&
                          announcement.music!.title.isNotEmpty) ...[
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: controller.toggleSound,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.55),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white24,
                                width: 0.8,
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
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],

                      // Announcement Title (Bold)
                      if (announcement.title.isNotEmpty) ...[
                        CustomText(
                          announcement.title,
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                      ],

                      // Announcement Caption (Regular Body)
                      if (announcement.caption.isNotEmpty) ...[
                        CustomText(
                          announcement.caption,
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 13,
                          height: 1.35,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 14),
                      ],

                      // Bottom Interaction Bar (Replacing Delete & View with Heart & Save!)
                      Row(
                        children: [
                          // Heart / Like Button (Left Side)
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => controller.toggleHeart(announcement),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  AppIcons.fire,
                                  height: 24,
                                  width: 24,
                                  colorFilter: ColorFilter.mode(
                                    announcement.isHearted
                                        ? AppColors.kPrimaryColor
                                        : Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                CustomText(
                                  '${announcement.heartCount}',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),

                          const Spacer(),

                          // Save Button
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => controller.toggleSave(announcement),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withValues(alpha: 0.5),
                                border: Border.all(
                                  color: Colors.white24,
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                announcement.isSaved
                                    ? CupertinoIcons.bookmark_fill
                                    : CupertinoIcons.bookmark,
                                color: announcement.isSaved
                                    ? AppColors.kPrimaryColor
                                    : Colors.white,
                                size: 20,
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          // Sound Mute/Unmute Button
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: controller.toggleSound,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withValues(alpha: 0.5),
                                border: Border.all(
                                  color: Colors.white24,
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                controller.isSoundOn.value
                                    ? Icons.volume_up
                                    : Icons.volume_off,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

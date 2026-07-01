import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:un4seen/src/core/routes/app_routes.dart';
import '../../../../core/core_export.dart';
import '../controllers/story_controller.dart';
import '../widgets/story_user_info.dart';
import '../widgets/story_bottom_bar.dart';

class StoryFullPage extends StatefulWidget {
  final int initialIndex;
  final bool isFromSaved;
  const StoryFullPage({
    super.key,
    required this.initialIndex,
    this.isFromSaved = false,
  });

  @override
  State<StoryFullPage> createState() => _StoryFullPageState();
}

class _StoryFullPageState extends State<StoryFullPage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  final controller = Get.find<StoryController>();

  // Animation for Heart Pop
  late AnimationController _fireController;
  late Animation<double> _scaleAnimation;
  bool _showFire = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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

    controller.startStoryTimer(
      widget.initialIndex,
      isFromSaved: widget.isFromSaved,
    );
  }

  void _handleDoubleTap() {
    if (controller.activeStories.isEmpty) return;
    final story = controller.activeStories[controller.currentStoryIndex.value];
    setState(() => _showFire = true);

    if (!story.isHearted) {
      controller.toggleHeart(story);
    }

    _fireController.forward(from: 0.0).then((_) {
      if (mounted) setState(() => _showFire = false);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller.closeStoryViewer();
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
      body: GestureDetector(
        onDoubleTap: _handleDoubleTap,
        onLongPressStart: (_) => controller.pauseStory(),
        onLongPressEnd: (_) => controller.resumeStory(),
        onTapUp: (details) {
          final width = MediaQuery.of(context).size.width;
          // ── NAVIGATION ZONES ──
          if (details.globalPosition.dx < width / 3) {
            controller.previousStory(); // Left 33% = Previous
          } else {
            controller.nextStory(); // Right 66% = Next
          }
        },
        child: Stack(
          children: [
            // 1. Content
            Obx(() {
              if (controller.activeStories.isEmpty) return const SizedBox();
              final story =
                  controller.activeStories[controller.currentStoryIndex.value];
              return Positioned.fill(
                child: CustomNetworkImage(
                  imageUrl: story.content,
                  fit: BoxFit.cover,
                ),
              );
            }),

            // 2. Progress Bars & Header
            SafeArea(
              child: Column(
                children: [
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      child: Row(
                        children: List.generate(
                          controller.activeStories.length,
                          (index) {
                            double progress = 0.0;
                            if (index < controller.currentStoryIndex.value)
                              progress = 1.0;
                            else if (index ==
                                controller.currentStoryIndex.value)
                              progress = controller.currentProgress.value;

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
                                  minHeight: 2,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Obx(() {
                    if (controller.activeStories.isEmpty)
                      return const SizedBox();
                    final story = controller
                        .activeStories[controller.currentStoryIndex.value];
                    return Row(
                      children: [
                        ButtonTapWidget(
                          onTap: () {
                            controller.pauseStory();
                            if (!story.isOwnStory) {
                              context
                                  .push(
                                    AppRoutes.memberDetails,
                                    extra: story.user.id,
                                  )
                                  .then((_) {
                                    controller.resumeStory();
                                  });
                            } else {
                              context.push(AppRoutes.myBikeProfile);
                            }
                          },
                          child: StoryUserInfo(
                            name: story.user.fullName,
                            time: story.user.memberNumber,
                            image: story.user.image,
                          ),
                        ),
                        const Spacer(),
                        if (story.isOwnStory)
                          ButtonTapWidget(
                            onTap: () {
                              controller.pauseStory();
                              showDialog(
                                context: context, // Passed correctly here
                                barrierDismissible:
                                    false, // Prevents closing by tapping outside without resuming the story
                                builder: (dialogContext) => AlertDialog(
                                  title: const Text("Delete Story"),
                                  content: const Text(
                                    "Are you sure you want to delete this story?",
                                  ),
                                  actions: [
                                    // Cancel Button
                                    TextButton(
                                      onPressed: () {
                                        controller.resumeStory();
                                        Navigator.pop(
                                          dialogContext,
                                        ); // Closes the dialog
                                      },
                                      child: const Text("Cancel"),
                                    ),
                                    // Delete Button
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(
                                          dialogContext,
                                        ); // Closes the dialog
                                        controller.deleteStory(story.id);
                                        controller
                                            .closeStoryViewer(); // Closes the story screen
                                      },
                                      child: const Text(
                                        "Delete",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.kAccentColor,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ButtonTapWidget(
                          onTap: () {
                            controller.closeStoryViewer();
                            Navigator.pop(context); // Close the story screen
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.kPrimaryDarkColor2,
                            ),
                            child: const Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Icon(
                                CupertinoIcons.multiply,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        space12W,
                      ],
                    );
                  }),
                ],
              ),
            ),

            // 3. Heart Animation Overlay
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
                    color: AppColors.kPrimaryColor,
                  ),
                ),
              ),

            // 4. Interaction Bar
            Positioned(
              bottom: 40,
              left: 20,
              right: 20,
              child: Obx(() {
                if (controller.activeStories.isEmpty) return const SizedBox();
                final story = controller
                    .activeStories[controller.currentStoryIndex.value];
                return Row(
                  children: [
                    CustomIconButtonWidget(
                      image: AppIcons.fire,
                      colorFilter: ColorFilter.mode(
                        story.isHearted
                            ? AppColors.kPrimaryColor
                            : Colors.white,
                        BlendMode.srcIn,
                      ),
                      onPressed: () => controller.toggleHeart(story),
                    ),
                    space12W,
                    CustomIconButtonWidget(
                      iconData: story.isSaved
                          ? CupertinoIcons.bookmark_fill
                          : CupertinoIcons.bookmark,
                      onPressed: () => controller.toggleSave(story),
                    ),
                    const Spacer(),
                    CustomIconButtonWidget(
                      iconData: controller.isSoundOn.value
                          ? Icons.volume_up
                          : Icons.volume_off,
                      onPressed: controller.toggleSound,
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

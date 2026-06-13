import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:un4seen/src/core/core_export.dart';
import 'package:un4seen/src/features/stories/data/models/story_model.dart';
import '../controllers/story_controller.dart';
import '../widgets/story_progress_bar.dart';
import '../widgets/story_user_info.dart';
import '../widgets/story_bottom_bar.dart';

class StoryFullPage extends StatefulWidget {
 final StoryModel storyModel;

  const StoryFullPage({
    super.key,
    required this.storyModel,
  });

  @override
  State<StoryFullPage> createState() => _StoryFullPageState();
}

class _StoryFullPageState extends State<StoryFullPage>
    with SingleTickerProviderStateMixin {
  final controller = Get.put(StoryController());

  late AnimationController _fireController;
  late Animation<double> _scaleAnimation;
  bool _showFire = false;

  @override
  void initState() {
    super.initState();
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
  }

  void _handleDoubleTap() {
    setState(() {
      _showFire = true;
    });

    // Update controller state
    controller.isLiked.value = true;

    _fireController.forward(from: 0.0).then((_) {
      if (mounted) {
        setState(() {
          _showFire = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _fireController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.black,
      body: GestureDetector(
        onDoubleTap: _handleDoubleTap,
        child: Stack(
          children: [
            // Full Screen Content
            Positioned.fill(
              child: CustomNetworkImage(
                imageUrl: widget.storyModel.content,
                fit: BoxFit.cover,
              ),
            ),

            // Top Overlays
            SafeArea(
              child: Column(
                children: [
                  // Progress Bar
                  const StoryProgressBar(segmentCount: 3, activeIndex: 0),
                  // User Info & Close
                  StoryUserInfo(
                    name: widget.storyModel.user.fullName,
                    time: widget.storyModel.timeAgo,
                    image: widget.storyModel.user.image,
                  ),
                ],
              ),
            ),

            // Fire Animation Overlay
            if (_showFire)
              Center(
                child: AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Opacity(
                        opacity: _scaleAnimation.value.clamp(0.0, 1.0),
                        child: child,
                      ),
                    );
                  },
                  child: SvgPicture.asset(
                    AppIcons.fire,
                    height: 120,
                    width: 120,
                    colorFilter: const ColorFilter.mode(
                      AppColors.kAccentColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),

            // Sound Toggle & Download (Optional floating buttons or integrated)
            Positioned(
              right: 16,
              bottom: 16,
              child: Column(
                children: [
                  Obx(
                    () => CustomIconButtonWidget(
                      iconData: controller.isSoundOn.value
                          ? Icons.volume_up
                          : Icons.volume_off,
                      onPressed: controller.toggleSound,
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Bar
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: StoryBottomBar(
          onJoinTap: () {
            // Navigate to subscription or similar
          },
          onMessageSent: (val) {
            // Handle message
          },
        ),
      ),
    );
  }
}

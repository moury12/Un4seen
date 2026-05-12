import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:un4seen/src/core/core_export.dart';
import 'package:un4seen/src/core/widgets/custom_network_image.dart';
import '../controllers/story_controller.dart';
import '../widgets/story_progress_bar.dart';
import '../widgets/story_user_info.dart';
import '../widgets/story_bottom_bar.dart';

class StoryFullPage extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String time;

  StoryFullPage({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.time,
  });

  final controller = Get.put(StoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Full Screen Content
          Positioned.fill(
            child: CustomNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
            ),
          ),

          // Top Overlays
          SafeArea(
            child: Column(
              children: [
                // Progress Bar
                const StoryProgressBar(
                  segmentCount: 3,
                  activeIndex: 0,
                ),
                // User Info & Close
                StoryUserInfo(
                  name: name,
                  time: time,
                  image: 'https://i.pravatar.cc/150?img=11',
                ),
              ],
            ),
          ),

          // Sound Toggle & Download (Optional floating buttons or integrated)
          Positioned(
            right: 16,
            top: 120,
            child: Column(
              children: [
                Obx(() => IconButton(
                  icon: Icon(
                    controller.isSoundOn.value ? Icons.volume_up : Icons.volume_off,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: controller.toggleSound,
                )),
                IconButton(
                  icon: const Icon(Icons.download, color: Colors.white, size: 28),
                  onPressed: () => controller.downloadImage(imageUrl),
                ),
              ],
            ),
          ),

          // Bottom Bar
          Align(
            alignment: Alignment.bottomCenter,
            child: StoryBottomBar(
              onJoinTap: () {
                // Navigate to subscription or similar
              },
              onMessageSent: (val) {
                // Handle message
              },
            ),
          ),
        ],
      ),
    );
  }
}

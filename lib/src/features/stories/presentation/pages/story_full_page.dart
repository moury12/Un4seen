import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:un4seen/src/core/core_export.dart';
import 'package:un4seen/src/core/widgets/custom_network_image.dart';
import '../controllers/story_controller.dart';

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
          // Full Screen Image
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
                // Progress Bar (Simplified)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Container(
                          height: 2,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Profile Info
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            time,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Overlays
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Row(
              children: [
                // Sound Toggle
                Obx(() => IconButton(
                      icon: Icon(
                        controller.isSoundOn.value ? Icons.volume_up : Icons.volume_off,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: controller.toggleSound,
                    )),
                const Spacer(),
                // Download Button
                GestureDetector(
                  onTap: () => controller.downloadImage(imageUrl),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.kPrimaryColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.download, color: Colors.white, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          AppStaticStrings.download.tr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

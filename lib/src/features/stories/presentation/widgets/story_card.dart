import 'package:flutter/material.dart';
import 'package:un4seen/src/core/widgets/custom_network_image.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/story_card_custom_shape.dart';

class StoryCard extends StatelessWidget {
  final bool isLeft;
  final String imageUrl;

  const StoryCard({required this.isLeft, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GenericSlantedCard(
      isLeft: isLeft,
      // borderColor: AppColors.kPrimaryColor,
      // borderWidth: 2,
      borderRadius: 24,
      slantHeight: 30,
      child: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: CustomNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover),
          ),

          // Top Left Badges
          Positioned(
            top: 12,
            left: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBadge('Sarah Martinez 🇦🇴'),
                const SizedBox(height: 4),
                _buildBadge('#SYN-2847'),
              ],
            ),
          ),

          // Bookmark Icon
          Positioned(
            bottom: isLeft ? 60 : 40,
            left: isLeft ? 12 : null,
            right: isLeft ? null : 12,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: AppColors.kPrimaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.bookmark, color: Colors.white, size: 18),
            ),
          ),

          // Time Text
          Positioned(
            bottom: isLeft ? 40 : 60,
            right: isLeft ? 12 : null,
            left: isLeft ? null : 12,
            child: const Text(
              '2h ago',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

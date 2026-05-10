import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_scaffold.dart';

class SavedStoriesPage extends StatelessWidget {
  const SavedStoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: const Text(AppStaticStrings.savedStories),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 0.8,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return _buildStoryCard();
        },
      ),
    );
  }

  Widget _buildStoryCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.kPrimaryColor.withOpacity(0.3)),
        image: const DecorationImage(
          image: NetworkImage('https://via.placeholder.com/300'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Sitting Pretty',
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
          const Positioned(
            top: 10,
            right: 10,
            child: Icon(Icons.bookmark, color: AppColors.kPrimaryColor, size: 20),
          ),
        ],
      ),
    );
  }
}

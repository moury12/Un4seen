import 'package:flutter/material.dart';
import 'package:un4seen/src/features/stories/presentation/widgets/story_card.dart';
import '../../../../core/utils/app_strings.dart';

class SavedStoriesPage extends StatelessWidget {
  const SavedStoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          AppStaticStrings.savedStories,
          style: TextStyle(
            color: Color(0xFF1A1A2E),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A2E)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 1,
          childAspectRatio: 0.65,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          // Alternating slant direction based on column
          final isLeftColumn = index % 2 == 0;
          return StoryCard(
            isLeft: isLeftColumn,
            imageUrl: _sampleImages[index % _sampleImages.length],
          );
        },
      ),
    );
  }
}

const List<String> _sampleImages = [
  'https://images.unsplash.com/photo-1558981403-c5f91bbde3ad?q=80&w=300&auto=format&fit=crop',
  'https://images.unsplash.com/photo-1591123120675-6f7f1aae0e5b?q=80&w=300&auto=format&fit=crop',
  'https://images.unsplash.com/photo-1599819811279-d5ad9cccf838?q=80&w=300&auto=format&fit=crop',
  'https://images.unsplash.com/photo-1614165933026-075a46032248?q=80&w=300&auto=format&fit=crop',
];

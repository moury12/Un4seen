import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:un4seen/src/core/core_export.dart';
import 'package:un4seen/src/features/stories/presentation/widgets/post_story_card.dart';
import 'package:un4seen/src/features/stories/presentation/widgets/stories_header.dart';
import 'package:un4seen/src/features/stories/presentation/widgets/story_card.dart';
import 'package:un4seen/src/features/stories/presentation/widgets/story_filter_chips.dart';

class StoriesPage extends StatelessWidget {
  const StoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, title: Text(AppStaticStrings.stories.tr)),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12H(context),
        child: Column(
          spacing: 6,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StoriesHeader(),

            const StoryFilterChips(),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemCount: 7, // 1 post card + 6 story cards
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const PostStoryCard();
                }
                // Dummy data for story cards
                return StoryCard(
                  isLeft: index % 2 == 0,
                  
                  imageUrl: 'https://picsum.photos/id/${index + 10}/400/600',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

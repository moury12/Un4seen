import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:un4seen/src/features/stories/presentation/controllers/story_controller.dart';
import 'package:un4seen/src/features/stories/presentation/widgets/story_card.dart';
import '../../../../core/utils/app_strings.dart';

class SavedStoriesPage extends StatelessWidget {
  const SavedStoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StoryController>();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => controller.fetchSavedStories(),
    );

    return Scaffold(
      appBar: AppBar(title: Text(AppStaticStrings.savedStories.tr)),
      body: RefreshIndicator(
        onRefresh: controller.fetchSavedStories,
        child: Obx(() {
          if (controller.isSavedLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 12,
              childAspectRatio: 0.7,
            ),
            itemCount: controller.savedStories.length,
            itemBuilder: (context, index) {
              return StoryCard(
                index: index,
                isLeft: index % 2 == 0,
                story: controller.savedStories[index],
                isFromSaved: true,
              );
            },
          );
        }),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:un4seen/src/features/stories/presentation/controllers/story_controller.dart';
import '../../../../src_export.dart';
import '../widgets/post_story_card.dart';
import '../widgets/stories_header.dart';
import '../widgets/story_card.dart';
import '../widgets/story_filter_chips.dart';
import '../widgets/story_card_custom_shape.dart';

class StoriesPage extends StatelessWidget {
  const StoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StoryController());

    return Scaffold(
      appBar: AppBar(elevation: 0, title: Text(AppStaticStrings.stories.tr)),
      body: RefreshIndicator(
        onRefresh: () => controller.fetchStories(),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            // 1. Header & Filters
            SliverPadding(
              padding: AppPadding.getPadding12H(context).copyWith(bottom: 12),
              sliver: const SliverToBoxAdapter(child: StoriesHeader()),
            ),
            SliverPadding(
              padding: AppPadding.getPadding12H(context),
              sliver: const SliverToBoxAdapter(child: StoryFilterChips()),
            ),

            // 2. The Main Grid
            Obx(() {
              int itemCount =
                  controller.isStoriesLoading.value &&
                      controller.stories.isEmpty
                  ? 6
                  : controller.stories.length + 1;

              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.75,
                  ),
                  // ─── THE FIX STARTS HERE ───
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      // INDEX 0 is ALWAYS the Post Story Card
                      if (index == 0) {
                        return const PostStoryCard();
                      }

                      // While Loading, show Shimmer placeholders
                      if (controller.isStoriesLoading.value &&
                          controller.stories.isEmpty) {
                        return GenericSlantedCard(
                          isLeft: index % 2 == 0,
                          child: Container(
                            color: AppColors.kPrimaryDarkColor.withValues(
                              alpha: 0.1,
                            ),
                          ),
                        );
                      }

                      // Show actual Stories
                      final story = controller.stories[index - 1];
                      return StoryCard(isLeft: index % 2 == 0, story: story);
                    },
                    childCount:
                        itemCount, // This replaces 'itemCount' parameter
                  ),
                  // ─── THE FIX ENDS HERE ───
                ),
              );
            }),

            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }
}

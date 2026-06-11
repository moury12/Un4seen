import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/core_export.dart';
import '../controllers/ideas_controller.dart';
import '../widgets/how_it_works_widget.dart';
import '../widgets/idea_card_widget.dart';
import '../widgets/share_idea_dialog.dart';

class IdeasFeedbackPage extends StatelessWidget {
  const IdeasFeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(IdeasController());

    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              AppStaticStrings.ideasAndFeedback.tr,
              variant: TextVariant.headlineLarge,
              fontWeight: FontWeight.bold,
              color: AppColors.kTextColor,
            ),
            CustomText(
              AppStaticStrings.helpShapeFuture.tr,
              variant: TextVariant.bodyMedium,
              color: AppColors.kSecondaryTextColor,
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () => ShareIdeaDialog.show(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: AppColors.kPrimaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.fetchIdeas(isRefresh: true),
        color: AppColors.kPrimaryColor,
        backgroundColor: AppColors.kPrimaryDarkColor3,
        child: Obx(() {
          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification.metrics.pixels >=
                  notification.metrics.maxScrollExtent - 100) {
                controller.loadMore();
              }
              return false;
            },
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                // 1. Shimmer Loading State
                if (controller.isLoading.value && controller.ideas.isEmpty)
                  SliverPadding(
                    padding: AppPadding.getPadding12(context),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => _buildShimmerItem(),
                        childCount: 5,
                      ),
                    ),
                  )

                // 2. Empty State
                else if (controller.ideas.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: CustomText(
                        "No ideas yet. Be the first!",
                        variant: TextVariant.bodyLarge,
                        color: AppColors.kSecondaryTextColor,
                      ),
                    ),
                  )

                // 3. The List
                else
                  SliverPadding(
                    padding: AppPadding.getPadding12(context),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final idea = controller.ideas[index];
                          return IdeaCardWidget(
                            model: idea,
                            onUpvote: () => controller.toggleUpvote(index),
                          );
                        },
                        childCount: controller.ideas.length,
                      ),
                    ),
                  ),

                // 4. Load More Indicator
                if (controller.isMoreLoading.value)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.kPrimaryColor,
                        ),
                      ),
                    ),
                  ),

                // 5. How It Works Widget at bottom
                const SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  sliver: SliverToBoxAdapter(
                    child: HowItWorksWidget(),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 30)),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildShimmerItem() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.kPrimaryDarkColor.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

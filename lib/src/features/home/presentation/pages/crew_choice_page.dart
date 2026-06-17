
import '../../../../src_export.dart';
import '../controllers/crew_choice_controller.dart';
import '../widgets/poll_card_widget.dart';

class CrewChoicePage extends StatelessWidget {
  const CrewChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CrewChoiceController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Column(
          children: [
            CustomText(AppStaticStrings.crewChoice.tr, variant: TextVariant.titleLarge, fontWeight: FontWeight.bold),
            CustomText(AppStaticStrings.syndicateCallsShots.tr, variant: TextVariant.labelSmall, color: AppColors.kSecondaryTextColor),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: controller.fetchData,
        child: Obx(() {
          if (controller.isLoading.value && controller.activePolls.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // 1. Active Polls
              SliverPadding(
                padding: AppPadding.getPadding12(context),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => PollCardWidget(model: controller.activePolls[index]),
                    childCount: controller.activePolls.length,
                  ),
                ),
              ),

              // 2. Past Results Header
              if (controller.pastPolls.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: CustomText("Past Results".tr, variant: TextVariant.titleMedium, fontWeight: FontWeight.bold),
                  ),
                ),

              // 3. Past Polls
              SliverPadding(
                padding: AppPadding.getPadding12(context),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Opacity(
                      opacity: 0.8,
                      child: PollCardWidget(model: controller.pastPolls[index]),
                    ),
                    childCount: controller.pastPolls.length,
                  ),
                ),
              ),

              // 4. How it works
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: HowItWorksWidget(), // Your existing how it works widget
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 40)),
            ],
          );
        }),
      ),
    );
  }
}
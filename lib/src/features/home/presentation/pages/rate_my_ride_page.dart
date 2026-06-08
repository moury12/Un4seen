import '../../../../src_export.dart';
import '../widgets/upload_ride_dialog.dart';


class RateRidePage extends StatelessWidget {
  const RateRidePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RateMyRideController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppStaticStrings.rateMyRideTitle.tr),
        actions: [
          SizedBox(
            width: 120,
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: CustomButton(
                text: AppStaticStrings.upload.tr,
                onPressed: () => UploadRideDialog.show(context),
                isExpanding: true,
                icon: Icons.upload_outlined,
                borderRadius: 20,
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        // Initial full-page loading
        if (controller.isLoading.value && controller.rides.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            // Logic for pagination (load more)
            if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
              controller.loadMore();
            }
            return false;
          },
          child: RefreshIndicator(
            onRefresh: () => controller.fetchRides(isRefresh: true),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                // 1. Description and Info Box Section
                SliverPadding(
                  padding: AppPadding.getPadding12(context),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      children: [
                        CustomText(
                          AppStaticStrings.rateMyRideDesc.tr,
                          color: AppColors.kTextColor,
                          fontSize: 12,
                        ),
                        space12H,
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.kPrimaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.emoji_events_outlined, color: Colors.white, size: 18),
                              space8W,
                              CustomText(
                                AppStaticStrings.votingEndsSunday.tr,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 2. The Main Feed List
                SliverPadding(
                  padding: AppPadding.getPadding12H(context),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: RateRideCardWidget(
                            ride: controller.rides[index],
                            index: index,
                          ),
                        );
                      },
                      childCount: controller.rides.length,
                    ),
                  ),
                ),

                // 3. Bottom Loading Indicator for Pagination
                if (controller.isMoreLoading.value)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
                
                // Extra padding at the bottom
                const SliverToBoxAdapter(child: SizedBox(height: 40)),
              ],
            ),
          ),
        );
      }),
    );
  }
}
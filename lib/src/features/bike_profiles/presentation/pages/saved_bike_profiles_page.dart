// lib/src/features/bike_profiles/presentation/pages/saved_bike_profiles_page.dart

import 'dart:math';

import '../../../../src_export.dart';
import '../widgets/member_card_widget.dart';
import 'single_bike_details_page.dart';

class SavedBikeProfilesPage extends StatelessWidget {
  const SavedBikeProfilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BikeProfilesController>();

    // Initial lifecycle data load
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => controller.fetchSavedBikes(),
    );

    return Scaffold(
      appBar: AppBar(title: const Text(AppStaticStrings.savedBikeProfiles)),
      body: Obx(() {
        // 1. Only show full-screen loader on initial fetch when list is completely empty
        if (controller.isSavedLoading.value && controller.savedBikes.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: () => controller.fetchSavedBikes(),
          color: AppColors.kPrimaryColor,
          child: CustomScrollView(
            // 2. This forces the scroll viewport to always accept drag gestures
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              if (controller.savedBikes.isEmpty)
                // 3. Perfectly centers the empty state message inside the scrollable viewport
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text(
                      "No saved profiles found".tr,
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ),
                )
              else
                // 4. Content list wrapped inside a sliver padding container
                SliverPadding(
                  padding: AppPadding.getPadding12(context).copyWith(top: 0),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final savedItem = controller.savedBikes[index];
                      final bike = savedItem.bike;
                      final owner = bike.user;

                      return GestureDetector(
                        onTap: () => Get.to(
                          () => SingleBikeDetailsPage(
                            bikeId: bike.id,
                            fromMember: true,
                          ),
                        ),
                        child: MemberCardWidget(
                          userId: owner?.id ?? '',
                          name: owner != null && owner.fullName.isNotEmpty
                              ? owner.fullName
                              : 'Unknown Member',
                          location: '${bike.make} ${bike.model} (${bike.year})',
                          image:
                              owner?.image ??
                              'https://i.pravatar.cc/150?u=fallback',
                          points: 'View Profile',
                          syndicateId:
                              '#SYN-${bike.id.substring(0, min(4, bike.id.length)).toUpperCase()}',
                          memberType: bike.bikeType.tr,
                          followers: bike.isRetired
                              ? 'Status: Retired'
                              : 'Status: Active',
                        ),
                      );
                    }, childCount: controller.savedBikes.length),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}

import 'package:flutter_svg/flutter_svg.dart';
import 'package:un4seen/src/features/bike_profiles/presentation/widgets/bike_details_container.dart';
import '../../../../src_export.dart';
import '../widgets/retired_bike_item.dart';
import '../widgets/upgrade_category_widget.dart';
import '../widgets/bike_shimmer_loading.dart';
import '../../../../core/widgets/gradient_container.dart';

class MyBikeProfilePage extends StatelessWidget {
  const MyBikeProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BikeProfilesController());
    final profileCntrl = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStaticStrings.myBikeProfile.tr),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: AppColors.kPrimaryDarkColor2,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.bookmark_outline,
              color: AppColors.kWhiteTextColor,
              size: 20,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: controller.fetchBikeProfile,
          child: Obx(() {
            if (controller.isLoading.value &&
                controller.activeBike.value == null) {
              return const Padding(
                padding: EdgeInsets.all(12),
                child: BikeShimmerLoading(),
              );
            }

            final bike = controller.activeBike.value;

            return CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: AppPadding.getPadding12H(context),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      if (bike == null) ...[
                        const SizedBox(height: 100),
                        Center(
                          child: CustomText(
                            "No active bike found.".tr,
                            variant: TextVariant.titleMedium,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ] else ...[
                        CustomText(
                          "${profileCntrl.userProfile.value.fullName}'s Ride",
                          textAlign: TextAlign.center,
                        ),
                        space8H,
                        Center(
                          child: Image.asset(
                            AppImages.logo,
                            height: 40,
                            errorBuilder: (context, error, stackTrace) =>
                                const CustomText(
                                  "UN4SEEN SYNDICATE",
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        space8H,
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CustomNetworkImage(
                            imageUrl: bike.image,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        space8H,
                        BikeDetailsContainerWidget(bike: bike),
                        space8H,
                        GradientContainer(
                          onTap: () => context.push(
                            AppRoutes.bikeGallery,
                            extra: bike.id,
                          ),
                          padding: AppPadding.getPadding12(context),
                          child: Row(
                            spacing: 8,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              space8H,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      AppStaticStrings.myBikeGallery.tr,
                                      color: Colors.white,
                                      variant: TextVariant.titleMedium,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomText(
                                      AppStaticStrings
                                          .viewAllPhotosOfThisBike
                                          .tr,
                                      color: Colors.white.withValues(
                                        alpha: 0.8,
                                      ),
                                      variant: TextVariant.labelMedium,
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                        space8H,
                        Row(
                          spacing: 8,
                          children: [
                            const Icon(
                              Icons.build_outlined,
                              color: AppColors.kPrimaryColor,
                              size: 25,
                            ),
                            CustomText(
                              AppStaticStrings.rideUpgrades.tr,
                              variant: TextVariant.titleLarge,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        space8H,
                        Column(
                          spacing: 8,
                          children: bike.upgrades.map((u) {
                            return UpgradeCategoryWidget(
                              title: u.title,
                              icon: Icons.build_outlined,
                              items: u.items,
                            );
                          }).toList(),
                        ),
                        space8H,
                      ],
                      Row(
                        spacing: 8,
                        children: [
                          SvgPicture.asset(AppIcons.settings),
                          CustomText(
                            AppStaticStrings.retiredBikes.tr,
                            variant: TextVariant.titleMedium,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      space8H,
                    ]),
                  ),
                ),
                SliverPadding(
                  padding: AppPadding.getPadding12H(context),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final rb = controller.retiredBikes[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: RetiredBikeItem(
                          title: "${rb.year} ${rb.make} ${rb.model}",
                          subtitle: "${rb.bikeType} • Retired",
                          imageUrl: rb.image,
                          onTap: () => context.push(
                            '${AppRoutes.singleBikeDetails}/${rb.id}',
                          ),
                        ),
                      );
                    }, childCount: controller.retiredBikes.length),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: CustomButton(
                      text: AppStaticStrings.addNewBike.tr,
                      icon: Icons.add,
                      onPressed: () {
                        context.push(AppRoutes.addNewBike);
                      },
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

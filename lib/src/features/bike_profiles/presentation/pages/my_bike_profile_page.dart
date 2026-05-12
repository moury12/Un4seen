import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:un4seen/src/core/widgets/custom_network_image.dart';
import '../../../../core/core_export.dart';
import '../../../../core/routes/app_routes.dart';
import '../widgets/bike_detail_item.dart';
import '../widgets/retired_bike_item.dart';
import '../widgets/upgrade_category_widget.dart';
import '../../../../core/widgets/gradient_container.dart';

class MyBikeProfilePage extends StatelessWidget {
  const MyBikeProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStaticStrings.myBikeProfile.tr),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
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
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: AppPadding.getPadding12H(context),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  CustomText(
                    "Jake Thompson's Ride",
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
                      imageUrl:
                          'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?q=80&w=1000',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  space8H,
                  Container(
                    padding: AppPadding.getPadding16(context),
                    decoration: BoxDecoration(
                      color: AppColors.kPrimaryDarkColor2,
                      borderRadius: BorderRadius.circular(16),
                      // border: Border.all(color: AppColors.kAccentColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          AppStaticStrings.bikeDetails.tr,
                          variant: TextVariant.titleLarge,
                          fontWeight: FontWeight.bold,
                          color: AppColors.kWhiteTextColor,
                        ),
                        space8H,
                        const Row(
                          spacing: 8,
                          children: [
                            Expanded(
                              child: BikeDetailItem(
                                label: 'Year',
                                value: '2023',
                                icon: Icons.calendar_today,
                              ),
                            ),

                            Expanded(
                              child: BikeDetailItem(
                                label: 'Type',
                                value: 'MX',
                                icon: Icons.directions_bike,
                              ),
                            ),
                          ],
                        ),
                        space8H,
                        const Row(
                          spacing: 8,
                          children: [
                            Expanded(
                              child: BikeDetailItem(
                                label: 'Make',
                                value: 'Yamaha',
                                icon: Icons.bookmark_add_outlined,
                              ),
                            ),

                            Expanded(
                              child: BikeDetailItem(
                                label: 'Model',
                                value: 'YZ450F',
                                icon: Icons.motorcycle,
                              ),
                            ),
                          ],
                        ),
                        space8H,
                        const BikeDetailItem(
                          label: 'Color',
                          value: 'Blue',
                          icon: Icons.color_lens,
                        ),
                      ],
                    ),
                  ),
                  space8H,
                  GradientContainer(
                    onTap: () => context.push(AppRoutes.bikeGallery),
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
                                AppStaticStrings.viewAllPhotosOfThisBike.tr,
                                color: Colors.white.withValues(alpha: 0.8),
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
                    children: List.generate(5, (index) {
                      return UpgradeCategoryWidget(
                        title: AppStaticStrings.plastics.tr,
                        icon: Icons.build_outlined,
                        items: const [
                          '2023 YZ Front Fender',
                          'Shrouds Cycra',
                          'Number Plate - 2023 YZF',
                        ],
                      );
                    }),
                  ),

                  space8H,
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
                  RetiredBikeItem(
                    title: '2021 Kawasaki KLX 140',
                    subtitle: 'Dirt Bike • Retired March 2023',
                    imageUrl:
                        'https://images.unsplash.com/photo-1444491741275-3747c53c99b4?q=80&w=500',
                  ),
                  space8H,
                  RetiredBikeItem(
                    title: 'Yamaha YZ450F',
                    subtitle: 'MX • Retired August 2021',
                    imageUrl:
                        'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?q=80&w=500',
                  ),
                  space8H,
                  CustomButton(
                    text: AppStaticStrings.addNewBike.tr,
                    icon: Icons.add,
                    onPressed: () {
                      context.push(AppRoutes.addNewBike);
                    },
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

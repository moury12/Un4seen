// lib/src/features/un4seen_world/presentation/pages/un4seen_world_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../src_export.dart';
import '../controllers/un4seen_world_controller.dart';
import '../widgets/brand_card_widget.dart';

class Un4seenWorldPage extends StatelessWidget {
  const Un4seenWorldPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dynamically inject/locate dependency tree loop allocation
    final ctrl = Get.put(Un4seenWorldController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Column(
          children: [
            CustomText(
              AppStaticStrings.un4seenWorld.tr,
              variant: TextVariant.titleLarge,
              fontWeight: FontWeight.bold,
            ),
            CustomText(
              AppStaticStrings.exploreBrandsBehind.tr,
              variant: TextVariant.labelSmall,
              color: AppColors.kSecondaryTextColor,
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => ctrl.fetchBrands(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: AppPadding.getPadding12(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ecosystem header card
              Container(
                padding: AppPadding.getPadding12(context),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.kPrimaryColor,
                      AppColors.kPrimaryDarkColor2,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      AppStaticStrings.fullEcosystem.tr,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    space8H,
                    CustomText(
                      AppStaticStrings.ecosystemDesc.tr,
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    space8H,
                    Row(
                      children: [
                        const Icon(Icons.bolt, color: Colors.white, size: 16),
                        space8W,
                        CustomText(
                          AppStaticStrings.discountWithCodes.tr,
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              space16H,

              CustomText(
                AppStaticStrings.featuredBrands.tr,
                variant: TextVariant.titleLarge,
                fontWeight: FontWeight.bold,
              ),
              space8H,

              // Reactive Obx handling API lists, Empty States and circular indicators
              Obx(() {
                if (ctrl.isLoading.value && ctrl.brands.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (ctrl.brands.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32.0),
                    child: Center(
                      child: CustomText(
                        "No brands available right now.",
                        variant: TextVariant.bodyMedium,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: ctrl.brands.length,
                  itemBuilder: (context, index) {
                    final brandItem = ctrl.brands[index];
                    return BrandCardWidget(brand: brandItem);
                  },
                );
              }),

              // space8H,

              // Member benefits section
              Container(
                padding: AppPadding.getPadding12(context),
                decoration: BoxDecoration(
                  color: AppColors.kPrimaryDarkColor3,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      AppStaticStrings.syndicateMemberBenefits.tr,
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    space8H,
                    _benefitRow(
                      Icons.local_offer_outlined,
                      AppStaticStrings.exclusiveDiscountCodes.tr,
                      AppStaticStrings.offAcrossPartner.tr,
                    ),
                    _benefitRow(
                      Icons.bolt_outlined,
                      AppStaticStrings.earlyAccessWorld.tr,
                      AppStaticStrings.beFirstToKnow.tr,
                    ),
                    _benefitRow(
                      Icons.public_outlined,
                      AppStaticStrings.supportMovement.tr,
                      AppStaticStrings.yourPurchasesHelp.tr,
                    ),
                  ],
                ),
              ),
              space8H,
            ],
          ),
        ),
      ),
    );
  }

  Widget _benefitRow(IconData icon, String title, String sub) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: AppColors.kAccentColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.kPrimaryDarkColor3, size: 20),
          ),
          space12W,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
                CustomText(sub, color: Colors.white, fontSize: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

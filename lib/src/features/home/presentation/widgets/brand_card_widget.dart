// lib/src/features/un4seen_world/presentation/widgets/brand_card_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart'; // Make sure to add url_launcher to pubspec.yaml
import '../../../../core/core_export.dart';
import '../../data/models/brand_model.dart';

class BrandCardWidget extends StatelessWidget {
  final BrandModel brand;

  const BrandCardWidget({super.key, required this.brand});

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Get.snackbar("Error", "Could not open brand link");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: AppPadding.getPadding12(context),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.kPrimaryColor, AppColors.kPrimaryDarkColor2],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dynamic Image Section from Cloudinary API Payload
          if (brand.image.isNotEmpty) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                brand.image,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const SizedBox(),
              ),
            ),
            space8H,
          ],

          CustomText(
            brand.title,
            color: Colors.white,
            variant: TextVariant.titleLarge,
            fontWeight: FontWeight.bold,
          ),
          CustomText(brand.subTitle, color: Colors.white, fontSize: 12),
          space4H,
          CustomText(brand.description, color: Colors.white, fontSize: 12),
          space8H,

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.kAccentColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        AppStaticStrings.syndicateCode.tr,
                        color: AppColors.kTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        brand.discountCode,
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        AppStaticStrings
                            .offYourOrder
                            .tr, // Simplified clean dynamic call
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ClipboardUtils.copyText(brand.discountCode);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.copy,
                      color: AppColors.kPrimaryColor,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          space8H,
          CustomButton(
            text: "${AppStaticStrings.visitBrand.tr} ${brand.title}",
            onPressed: () => _launchUrl(brand.link),
            rightIcon: Icons.open_in_new,
            backgroundColor: AppColors.kPrimaryColor,
          ),
        ],
      ),
    );
  }
}

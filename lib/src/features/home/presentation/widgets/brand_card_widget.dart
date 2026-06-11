import 'package:flutter/services.dart';
import '../../../../src_export.dart';

class BrandCardWidget extends StatelessWidget {
  final String name;
  final String category;
  final String description;
  final String code;
  final String discount;

  const BrandCardWidget({
    super.key,
    required this.name,
    required this.category,
    required this.description,
    required this.code,
    required this.discount,
  });

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
          CustomText(
            name,
            color: Colors.white,
            variant: TextVariant.titleLarge,
            fontWeight: FontWeight.bold,
          ),
          CustomText(category, color: Colors.white, fontSize: 12),
          space4H,
          CustomText(description, color: Colors.white, fontSize: 12),
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
                        code,
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        "$discount ${AppStaticStrings.offYourOrder.tr}",
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: code));
                    Get.snackbar(
                      "Copied",
                      "Code copied to clipboard",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColors.kPrimaryDarkColor3,
                      colorText: Colors.white,
                    );
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
            text: "${AppStaticStrings.visitBrand.tr} $name",
            onPressed: () {},
            rightIcon: Icons.open_in_new,
            backgroundColor: AppColors.kPrimaryColor,
          ),
        ],
      ),
    );
  }
}

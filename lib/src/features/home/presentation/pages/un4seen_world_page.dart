import '../../../../src_export.dart';
import '../widgets/brand_card_widget.dart';

class Un4seenWorldPage extends StatelessWidget {
  const Un4seenWorldPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
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
            space8H,
            CustomText(
              AppStaticStrings.featuredBrands.tr,
              variant: TextVariant.titleLarge,
              fontWeight: FontWeight.bold,
            ),
            space8H,
            const BrandCardWidget(
              name: "Revdup",
              category: "MX - Bmx - MTB Apparel",
              description:
                  "Revdup was born in NZ dirt, built by three brothers who live to ride. Tested across MX, ATV, MTB & BMX.",
              code: "REV15",
              discount: "15%",
            ),
            const BrandCardWidget(
              name: "Jaxson Bottles",
              category: "Stay hydrated without taking your helmet off",
              description:
                  "Jaxson Bottles — built for purpose, hydration made easy 👊",
              code: "TRICKS15",
              discount: "15%",
            ),
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

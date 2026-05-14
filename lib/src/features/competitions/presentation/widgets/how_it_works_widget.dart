import '../../../../src_export.dart';

class HowItWorksWidget extends StatelessWidget {
  const HowItWorksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.getPadding12(context),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryDarkColor3,
        borderRadius: BorderRadius.circular(appRadius16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome_outlined, color: AppColors.kPrimaryColor, size: 20),
              space8W,
              CustomText(AppStaticStrings.howCompetitionsWork.tr, fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
            ],
          ),
          space12H,
          _bulletPoint(AppStaticStrings.submitPhase.tr),
          _bulletPoint(AppStaticStrings.votingPhase.tr),
          _bulletPoint(AppStaticStrings.winnerAnnounced.tr),
          _bulletPoint(AppStaticStrings.productionPhase.tr),
          _bulletPoint(AppStaticStrings.websiteFeature.tr),
          _bulletPoint(AppStaticStrings.prizeDelivery.tr),
        ],
      ),
    );
  }

  Widget _bulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText("• ", color: Colors.white),
          Expanded(child: CustomText(text, color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }
}

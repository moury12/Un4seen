import '../../../../src_export.dart';
import '../widgets/poll_card_widget.dart';
import '../widgets/poll_option_widget.dart';

class CrewChoicePage extends StatelessWidget {
  const CrewChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Column(
          children: [
            CustomText(
              AppStaticStrings.crewChoice.tr,
              variant: TextVariant.titleLarge,
              fontWeight: FontWeight.bold,
            ),
            CustomText(
              AppStaticStrings.syndicateCallsShots.tr,
              variant: TextVariant.labelSmall,
              color: AppColors.kSecondaryTextColor,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context),
        child: Column(
          children: [
            PollCardWidget(
              icon: AppIcons.reward,
              title: AppStaticStrings.nextGiveawayPrize.tr,
              subtitle: AppStaticStrings.voteBelowNextWeek.tr,
              totalVotes: "192",
              timeLeft: "3 ${AppStaticStrings.daysLeft.tr}",
              options: const [
                PollOptionWidget(title: "Carbon Fork Wraps", percentage: 0.23),
                PollOptionWidget(
                  title: "Custom Made Hoodie with your race number and Name",
                  percentage: 0.35,
                ),
                PollOptionWidget(
                  title: "2026 Honda Crf110cc",
                  percentage: 0.27,
                ),
                PollOptionWidget(
                  title: "Full Set of Race Numbers",
                  percentage: 0.15,
                ),
              ],
            ),
            PollCardWidget(
              icon: AppIcons.badge,
              title: AppStaticStrings.newProductDrop.tr,
              subtitle: AppStaticStrings.whatProductRelease.tr,
              totalVotes: "192",
              timeLeft: "3 ${AppStaticStrings.daysLeft.tr}",
              hasVoted: true,
              options: const [
                PollOptionWidget(title: "Textured Laminate", percentage: 0.28),
                PollOptionWidget(title: "Exhaust Decals", percentage: 0.22),
                PollOptionWidget(
                  title: "T-Shirt Designs",
                  percentage: 0.33,
                  isSelected: true,
                ),
                PollOptionWidget(title: "Road Bike Decals", percentage: 0.18),
              ],
            ),
            space12H,
            // How it works card
            Container(
              padding: AppPadding.getPadding12(context),
              decoration: BoxDecoration(
                color: AppColors.kPrimaryDarkColor3,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: AppColors.kPrimaryColor,
                        size: 20,
                      ),
                      space8W,
                      CustomText(
                        AppStaticStrings.howItWorks.tr,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  space12H,
                  _bullet(AppStaticStrings.howItWorksPollsDesc1.tr),
                  _bullet(AppStaticStrings.howItWorksPollsDesc2.tr),
                  _bullet(AppStaticStrings.howItWorksPollsDesc3.tr),
                ],
              ),
            ),
            space24H,
          ],
        ),
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText("• ", color: Colors.white),
          Expanded(child: CustomText(text, color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}

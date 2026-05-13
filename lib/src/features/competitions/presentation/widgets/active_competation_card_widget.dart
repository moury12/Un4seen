import 'package:un4seen/src/core/widgets/custom_network_image.dart';
import 'package:un4seen/src/features/competitions/presentation/widgets/submit_design_dialog.dart';

import '../../../../src_export.dart';

class ActiveCompetitionCard extends StatelessWidget {
  final String title;
  final String status; // 'VOTING' | 'OPEN' | 'ENDED'
  final String image;
  final String prize;

  const ActiveCompetitionCard({
    super.key,
    required this.title,
    required this.status,
    required this.image,
    required this.prize,
  });

  @override
  Widget build(BuildContext context) {
    bool isVoting = status == 'VOTING';
    bool isOpen = status == 'OPEN';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryDarkColor3,
        borderRadius: BorderRadius.circular(appRadius16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(appRadius16)),
                child: CustomNetworkImage(imageUrl: image, height: 180, width: double.infinity),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isVoting ? AppColors.kRedColor : (isOpen ? AppColors.kGreenColor : Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(isVoting ? Icons.how_to_vote : Icons.lock_open, size: 12, color: Colors.white),
                      space4W,
                      CustomText(
                        isVoting ? AppStaticStrings.votingNow.tr : (isOpen ? AppStaticStrings.openForEntries.tr : AppStaticStrings.ended.tr),
                        color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: AppPadding.getPadding12(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(title, variant: TextVariant.titleLarge, color: Colors.white, fontWeight: FontWeight.bold),
                space8H,
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.kPrimaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.kPrimaryColor.withOpacity(0.5)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.emoji_events, color: AppColors.kPrimaryColor),
                      space8W,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(AppStaticStrings.grandPrize.tr, fontWeight: FontWeight.bold, color: AppColors.kPrimaryColor),
                            CustomText(prize, color: Colors.white70, fontSize: 11),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                space12H,
                if (isVoting)
                  CustomButton(
                    text: AppStaticStrings.viewEntries.tr,
                    onPressed: () => context.push(AppRoutes.entriesGallery),
                    isOutlined: true,
                    borderColor: Colors.white24,
                    textColor: Colors.white,
                  )
                else if (isOpen)
                  CustomButton(
                    text: AppStaticStrings.submitYourDesign.tr,
                    onPressed: () => _showSubmitDialog(context),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSubmitDialog(BuildContext context) {
    Get.dialog(const SubmitDesignDialog());
  }
}
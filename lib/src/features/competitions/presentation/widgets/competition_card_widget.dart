import '../../../../src_export.dart';

class CompetitionCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final String prize;
  final String date;
  final String image;
  final String status; // 'VOTING' | 'OPEN'
  final List<Widget>? votingItems;

  const CompetitionCardWidget({
    super.key,
    required this.title,
    required this.description,
    required this.prize,
    required this.date,
    required this.image,
    required this.status,
    this.votingItems,
  });

  @override
  Widget build(BuildContext context) {
    bool isVoting = status == 'VOTING';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF0078B9),
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
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: .5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(isVoting ? Icons.how_to_vote : Icons.local_fire_department, size: 12, color: Colors.white),
                      space4W,
                      CustomText(
                        isVoting ? AppStaticStrings.votingNow.tr : AppStaticStrings.openForEntries.tr,
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
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
                space4H,
                CustomText(description, color: Colors.white.withValues(alpha: .9), fontSize: 11, maxLines: 2),
                space12H,
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.kPrimaryColor.withValues(alpha: .3),
                    borderRadius: BorderRadius.circular(appRadius),
                    border: Border.all(color: AppColors.kPrimaryColor.withValues(alpha: .5)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.emoji_events_outlined, color: Colors.white, size: 24),
                      space12W,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(AppStaticStrings.grandPrize.tr, fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14),
                            CustomText(prize, color: Colors.white.withValues(alpha: .8), fontSize: 12, maxLines: 2),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                space12H,
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined, color: Colors.white, size: 14),
                    space8W,
                    CustomText(date, color: Colors.white, fontSize: 12),
                  ],
                ),
                if (isVoting) ...[
                  space12H,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(AppStaticStrings.voteForYourFavorite.tr,fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                      GestureDetector(
                        onTap: () => context.push(AppRoutes.entriesGallery),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomText(AppStaticStrings.viewEntries.tr, color: AppColors.kPrimaryColor, fontSize: 12, fontWeight: FontWeight.bold),
                              const Icon(Icons.chevron_right, size: 14, color: AppColors.kPrimaryColor),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  space8H,
                  ...?votingItems,
                ] else ...[
                  space12H,
                  CustomButton(
                    text: AppStaticStrings.submitYourDesign.tr,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const SubmitDesignDialog(),
                      );
                    },
                    icon: Icons.upload_outlined,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

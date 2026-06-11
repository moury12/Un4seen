import '../../../../src_export.dart';

class CompetitionCardWidget extends StatefulWidget {
  final CompetitionModel model;

  const CompetitionCardWidget({super.key, required this.model});

  @override
  State<CompetitionCardWidget> createState() => _CompetitionCardWidgetState();
}

class _CompetitionCardWidgetState extends State<CompetitionCardWidget> {
  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  final controller = Get.find<CompetitionsController>();
  @override
  void initState() {
    controller.fetchGallery(widget.model.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isVoting = widget.model.canVote;
    final bool isOpen = widget.model.canSubmit;

    final String statusLabel = widget.model.statusLabel;

    final String dateRange =
        "${_formatDate(widget.model.startDate)} ➔ ${_formatDate(widget.model.endDate)}";

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
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(appRadius16),
                ),
                child: CustomNetworkImage(
                  imageUrl: widget.model.image,
                  height: 180,
                  width: double.infinity,
                ),
              ),

              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: .5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isVoting
                            ? Icons.how_to_vote
                            : Icons.local_fire_department,
                        size: 12,
                        color: Colors.white,
                      ),
                      space4W,
                      CustomText(
                        statusLabel,
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
                CustomText(
                  widget.model.title,
                  variant: TextVariant.titleLarge,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                space4H,
                CustomText(
                  widget.model.description,
                  color: Colors.white.withValues(alpha: .9),
                  fontSize: 11,
                  maxLines: 2,
                ),
                space8H,
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.kPrimaryColor.withValues(alpha: .3),
                    borderRadius: BorderRadius.circular(appRadius),
                    border: Border.all(
                      color: AppColors.kPrimaryColor.withValues(alpha: .5),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.emoji_events_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                      space12W,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                              AppStaticStrings.grandPrize.tr,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            CustomText(
                              widget.model.grandPrize,
                              color: Colors.white.withValues(alpha: .8),
                              fontSize: 12,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                space8H,
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.white,
                      size: 14,
                    ),
                    space8W,
                    CustomText(dateRange, color: Colors.white, fontSize: 12),
                  ],
                ),
                // if (isVoting)
                ...[
                  space8H,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (isVoting)
                        CustomText(
                          AppStaticStrings.voteForYourFavorite.tr,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )
                      else
                        const SizedBox.shrink(),
                      GestureDetector(
                        onTap: () {
                          context.push(AppRoutes.entriesGallery);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomText(
                                AppStaticStrings.viewEntries.tr,
                                color: AppColors.kPrimaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              const Icon(
                                Icons.chevron_right,
                                size: 14,
                                color: AppColors.kPrimaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  space4H,
                  Obx(() {
                    final entries = controller.entries.toList();
                    if (entries.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return Column(
                      children: List.generate(
                        controller.entries.length > 2
                            ? 2
                            : controller.entries.length,
                        (index) => VoteEntryItemWidget(
                          title: controller.entries[index].designName,
                          author:
                              controller.entries[index].user.fullName ?? "--",
                          synId: controller.entries[index].id,
                          likes: controller.entries[index].heartCount
                              .toString(),
                          image: controller.entries[index].image,
                        ),
                      ),
                    );
                  }),
                ],

                if (isOpen) ...[
                  space8H,
                  CustomButton(
                    text: AppStaticStrings.submitYourDesign.tr,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            SubmitDesignDialog(competition: widget.model),
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

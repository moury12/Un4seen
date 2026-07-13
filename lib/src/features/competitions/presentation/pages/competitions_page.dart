import 'package:un4seen/src/src_export.dart';

class CompetitionsPage extends StatelessWidget {
  const CompetitionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CompetitionsController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          spacing: 8,
          children: [
            const Icon(Icons.emoji_events, color: AppColors.kPrimaryColor),
            RichText(
              text: TextSpan(
                text: "${AppStaticStrings.competitionsTitle.tr}\n",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.kTextColor,
                ),
                children: [
                  TextSpan(
                    text: AppStaticStrings.designUploadVoteWin.tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: AppColors.kTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          ButtonTapWidget(
            onTap: () {
              if (Get.isRegistered<NavigationController>()) {
                Get.find<NavigationController>().changeIndex(0);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(AppIcons.logo, height: 38),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return controller.fetchAllCompetitions();
        },
        child: SingleChildScrollView(
          padding: AppPadding.getPadding12H(context),

          child: Obx(() {
            if (controller.isCompLoading.value) {
              return _buildShimmer(context);
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Active Competitions
                if (controller.activeComps.isNotEmpty) ...[
                  CustomText(
                    AppStaticStrings.activeCompetitions.tr,
                    variant: TextVariant.titleLarge,
                    fontWeight: FontWeight.bold,
                    color: AppColors.kTextColor,
                    fontSize: 18,
                  ),
                  space4H,
                  ...controller.activeComps.map(
                    (comp) => CompetitionCardWidget(model: comp),
                  ),
                ],

                // Upcoming Competitions
                if (controller.upcomingComps.isNotEmpty) ...[
                  space4H,
                  const CustomText(
                    'Upcoming Competitions',
                    variant: TextVariant.titleLarge,
                    fontWeight: FontWeight.bold,
                    color: AppColors.kTextColor,
                    fontSize: 18,
                  ),
                  space8H,
                  ...controller.upcomingComps.map(
                    (comp) => CompetitionCardWidget(model: comp),
                  ),
                ],

                // Ended Competitions
                if (controller.endedComps.isNotEmpty) ...[
                  space8H,
                  CustomText(
                    AppStaticStrings.ended.tr,
                    variant: TextVariant.titleLarge,
                    fontWeight: FontWeight.bold,
                    color: AppColors.kTextColor,
                    fontSize: 18,
                  ),
                  space4H,
                  ...controller.endedComps.map(
                    (comp) => _buildEndedTile(context, comp),
                  ),
                ],

                // Empty state
                if (controller.activeComps.isEmpty &&
                    controller.upcomingComps.isEmpty &&
                    controller.endedComps.isEmpty) ...[
                  const SizedBox(height: 80),
                  Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.emoji_events_outlined,
                          size: 64,
                          color: AppColors.kPrimaryColor.withValues(alpha: .5),
                        ),
                        space8H,
                        const CustomText(
                          'No competitions available',
                          color: AppColors.kSecondaryTextColor,
                        ),
                      ],
                    ),
                  ),
                ],

                space8H,
                const HowItWorksWidget(),
                space8H,
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildEndedTile(BuildContext context, CompetitionModel comp) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor,
        borderRadius: BorderRadius.circular(appRadius16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: Colors.white,
                size: 16,
              ),
              space4W,
              CustomText(
                AppStaticStrings.ended.tr,
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          space4H,
          CustomText(
            comp.title,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          CustomText(
            comp.description,
            color: Colors.white70,
            fontSize: 12,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildShimmer(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(3, (i) => _buildShimmerCard()),
      ),
    );
  }

  Widget _buildShimmerCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      height: 300,
      decoration: BoxDecoration(
        color: AppColors.kPrimaryDarkColor2,
        borderRadius: BorderRadius.circular(appRadius16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160,
            decoration: const BoxDecoration(
              color: AppColors.kPrimaryDarkColor3,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(appRadius16),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 16,
                  width: 200,
                  color: AppColors.kPrimaryDarkColor3,
                  margin: const EdgeInsets.only(bottom: 8),
                ),
                Container(
                  height: 12,
                  width: 280,
                  color: AppColors.kPrimaryDarkColor3,
                  margin: const EdgeInsets.only(bottom: 6),
                ),
                Container(
                  height: 12,
                  width: 240,
                  color: AppColors.kPrimaryDarkColor3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

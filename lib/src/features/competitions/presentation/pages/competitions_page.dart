import '../../../../src_export.dart';

class CompetitionsPage extends StatelessWidget {
  const CompetitionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.emoji_events, color: AppColors.kPrimaryColor),
            space8W,
            CustomText(
              AppStaticStrings.competitionsTitle.tr,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              AppStaticStrings.designUploadVoteWin.tr,
              color: Colors.white70,
            ),
            space12H,

            // Winners Circle Section
            CustomText(
              AppStaticStrings.thisWeek.tr,
              variant: TextVariant.titleMedium,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            space8H,
            SizedBox(
              height: 140,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                separatorBuilder: (_, __) => space12W,
                itemBuilder: (context, index) => const WinnersCircleCard(),
              ),
            ),

            space24H,
            CustomText(
              AppStaticStrings.activeCompetitions.tr,
              variant: TextVariant.titleMedium,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            space12H,

            const ActiveCompetitionCard(
              title: "Design the Sickest Graphics Kit",
              status: "VOTING",
              prize: "Win your design made for your bike!",
              image:
                  "https://images.unsplash.com/photo-1558981403-c5f9899a28bc?q=80&w=500",
            ),

            const ActiveCompetitionCard(
              title: "Design Your Own Un4seen MX Gear",
              status: "OPEN",
              prize: "Win your custom MX gear design made in your size!",
              image:
                  "https://images.unsplash.com/photo-1444491741275-3747c53c99b4?q=80&w=500",
            ),
          ],
        ),
      ),
    );
  }
}

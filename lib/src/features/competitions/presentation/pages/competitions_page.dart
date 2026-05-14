import 'package:flutter_svg/flutter_svg.dart';
import '../../../../src_export.dart';


class CompetitionsPage extends StatelessWidget {
  const CompetitionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          spacing: 8,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Icon(Icons.emoji_events, color: AppColors.kPrimaryColor),
            RichText(text:  TextSpan(
              text: "${AppStaticStrings.competitionsTitle.tr}\n", 
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.kTextColor),
              children: [
                TextSpan(
                  text: AppStaticStrings.designUploadVoteWin.tr, 
                  style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: AppColors.kTextColor),
                ),
              ],
            )),
           
          ],
        ),
        actions: [ 
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AppIcons.logo, height: 38),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12H(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            CustomText(AppStaticStrings.activeCompetitions.tr, variant: TextVariant.titleLarge, 
            fontWeight: FontWeight.bold, color: AppColors.kTextColor, fontSize: 18),
            
space4H,
            CompetitionCardWidget(
              title: AppStaticStrings.designSickestKit.tr,
              description: AppStaticStrings.designSickestKitDesc.tr,
              prize: AppStaticStrings.winDesignMadeForBike.tr,
              date: "September 20, 2026 ➔ September 27, 2026",
              image: "https://images.unsplash.com/photo-1558981403-c5f9899a28bc?q=80&w=500",
              status: "VOTING",
              votingItems: [
                VoteEntryItemWidget(title: "Flame Thunder", author: "Jake Thompson", synId: "#SYN-1892", likes: "88", image: "https://images.unsplash.com/photo-1558981403-c5f9899a28bc?q=80&w=100"),
                VoteEntryItemWidget(title: "Neon Storm", author: "Sarah Martinez", synId: "#SYN-4521", likes: "80", image: "https://images.unsplash.com/photo-1444491741275-3747c53c99b4?q=80&w=100"),
                VoteEntryItemWidget(title: "Shadow Strike", author: "Alex Rivera", synId: "#SYN-1892", likes: "77", image: "https://images.unsplash.com/photo-1558981403-c5f9899a28bc?q=80&w=100"),
              ],
            ),

            CompetitionCardWidget(
              title: AppStaticStrings.designOwnGear.tr,
              description: AppStaticStrings.designOwnGearDesc.tr,
              prize: AppStaticStrings.winCustomGearSize.tr,
              date: "October 10, 2026 ➔ October 20, 2026",
              image: "https://images.unsplash.com/photo-1444491741275-3747c53c99b4?q=80&w=500",
              status: "OPEN",
            ),

            Container(
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
                      const Icon(Icons.check_circle_outline, color: Colors.white, size: 16),
                      
                      CustomText(AppStaticStrings.ended.tr, color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ],
                  ),
                  
                  CustomText(AppStaticStrings.ebikeChallenge.tr, fontWeight: FontWeight.bold, color: Colors.white),
                  CustomText(AppStaticStrings.bmxToEbike.tr, color: Colors.white70, fontSize: 12),
                  
                  const CustomText("August 15, 2026 - August 25, 2026", color: Colors.white70, fontSize: 12),
                ],
              ),
            ),

            const HowItWorksWidget(),
            
          ],
        ),
      ),
    );
  }
}

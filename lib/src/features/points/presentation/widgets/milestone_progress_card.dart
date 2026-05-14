import '../../../../src_export.dart';
import '../../../../core/widgets/gradient_container.dart';

class MilestoneProgressCard extends StatelessWidget {
  const MilestoneProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      padding: EdgeInsets.zero,
      gradientColors: [AppColors.kPrimaryDarkColor2, AppColors.kPrimaryColor],
      child: Column(
        children: [
          const CustomNetworkImage(
            imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?q=80&w=400',
            height: 150,
            width: double.infinity,
          ),
          Padding(
            padding: AppPadding.getPadding12(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(child: CustomText("🔒 When we hit 5000 Active Syndicate members, you'll receive an Un4seen Backpack.", color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                    space8W,
                    CustomButton(text: "Claim", onPressed: () {}, isExpanding: false, borderRadius: 20),
                  ],
                ),
                space8H,
                CustomText(AppStaticStrings.backpackDesc.tr, color: Colors.white70, fontSize: 10),
                space12H,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText("3000 Members", color: Colors.white, fontSize: 9),
                    CustomText("5000 Members", color: Colors.white, fontSize: 9),
                  ],
                ),
                space4H,
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: const LinearProgressIndicator(value: 0.6, minHeight: 8, backgroundColor: Colors.black26, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

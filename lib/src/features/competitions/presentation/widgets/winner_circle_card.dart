import '../../../../src_export.dart';

class WinnersCircleCard extends StatelessWidget {
  const WinnersCircleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: AppPadding.getPadding12(context),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryDarkColor2,
        borderRadius: BorderRadius.circular(appRadius16),
        border: Border.all(color: AppColors.kPrimaryColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(AppStaticStrings.winnersCircle.tr, fontWeight: FontWeight.bold, color: Colors.white),
              const Icon(Icons.emoji_events_outlined, color: Colors.white, size: 18),
            ],
          ),
          space8H,
          Row(
            children: [
              const CircleAvatar(radius: 20, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11')),
              space8W,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText("Jake Thompson 🇺🇸", fontWeight: FontWeight.bold, color: Colors.white),
                    CustomText("WEEK 17 WINNER", variant: TextVariant.labelSmall, color: AppColors.kPrimaryColor),
                  ],
                ),
              ),
            ],
          ),
          space8H,
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                const Icon(Icons.card_giftcard, color: Colors.white, size: 14),
                space8W,
                const Expanded(child: CustomText("Premium Decal Kit + T-Shirt", color: Colors.white, fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
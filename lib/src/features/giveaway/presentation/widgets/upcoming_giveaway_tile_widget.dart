import '../../../../src_export.dart';

class UpcomingGiveawayTileWidget extends StatelessWidget {
  final String title;
  final String week;
  final String price;

  const UpcomingGiveawayTileWidget({
    super.key,
    required this.title,
    required this.week,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: AppPadding.getPadding12(context),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.kPrimaryDarkColor2, AppColors.kPrimaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                CustomText(week, color: Colors.white70, fontSize: 10),
              ],
            ),
          ),
          CustomText(
            price,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

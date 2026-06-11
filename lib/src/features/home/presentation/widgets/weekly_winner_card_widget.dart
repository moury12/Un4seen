import '../../../../src_export.dart';

class WeeklyWinnerCardWidget extends StatelessWidget {
  final String week;
  final String name;
  final String prize;
  final String image;

  const WeeklyWinnerCardWidget({
    super.key,
    required this.week,
    required this.name,
    required this.prize,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(bottom: 12),
      padding: AppPadding.getPadding12(context),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.kPrimaryColor.withValues(alpha: 0.8),
            AppColors.kPrimaryDarkColor,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 24, backgroundImage: NetworkImage(image)),
          space12W,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomText(
                    week,
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                space4H,
                CustomText(
                  name,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.card_giftcard,
                      color: Colors.white,
                      size: 12,
                    ),
                    space4W,
                    Expanded(
                      child: CustomText(
                        prize,
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            spacing: 8,
            children: [
              const Icon(
                Icons.emoji_events_outlined,
                color: Colors.white,
                size: 20,
              ),
              SizedBox(
                width: 80,
                height: 30,
                child: CustomButton(
                  text: AppStaticStrings.follow.tr,
                  textColor: AppColors.kWhiteTextColor,
                  onPressed: () {},
                  isExpanding: false,
                  borderRadius: 20,
                  // padding:0,
                  textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

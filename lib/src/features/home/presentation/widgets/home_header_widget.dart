import '../../../../src_export.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                AppStaticStrings.quoteOfTheDay.tr,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              CustomText(
                AppStaticStrings.neverGiveUp.tr,
                color: AppColors.kSecondaryTextColor,
                fontSize: 12,
              ),
            ],
          ),
        ),
        Image.asset(
          AppImages.logo,
          // width: 80,
          height: 30,
        ),
      ],
    );
  }
}

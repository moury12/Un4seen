import '../../../../src_export.dart';

class PollOptionWidget extends StatelessWidget {
  final String title;
  final double percentage;
  final bool isSelected;
  final PollOption option;

  final VoidCallback? onTap; // Added Tap Callback

  const PollOptionWidget({
    super.key,
    required this.title,
    required this.percentage,
    this.isSelected = false,
    this.onTap, required this.option,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black.withOpacity(0.3) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? AppColors.kWhiteTextColor : Colors.transparent,
          width: 2,
        ),
      ),
      child: ButtonTapWidget( // Added Ripple effect
        onTap: onTap,
        radius: 12,
        child: Padding(
          padding: AppPadding.getPadding12(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomText(
                      title,
                      color: isSelected ? Colors.white : AppColors.kTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  CustomText(
                    "${(percentage * 100).toInt()}%",
                    color: AppColors.kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              space8H,
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: percentage,
                  minHeight: 8,
                  backgroundColor: isSelected ? Colors.white24 : AppColors.kAccentColor.withOpacity(0.3),
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.kPrimaryColor),
                ),
              ),
              if (!isSelected && onTap != null) ...[
                space4H,
                CustomText("Tap to vote".tr, color: AppColors.kSecondaryTextColor, fontSize: 10),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
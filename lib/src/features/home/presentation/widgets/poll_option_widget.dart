import 'package:flutter_svg/flutter_svg.dart';
import '../../../../src_export.dart';

class PollOptionWidget extends StatelessWidget {
  final String title;
  final double percentage;
  final bool isSelected;

  const PollOptionWidget({
    super.key,
    required this.title,
    required this.percentage,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: AppPadding.getPadding12(context),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black.withOpacity(0.3) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isSelected
            ? Border.all(color: AppColors.kPrimaryColor, width: 2)
            : null,
      ),
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
              backgroundColor: isSelected
                  ? Colors.white24
                  : AppColors.kAccentColor.withOpacity(0.3),
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.kPrimaryColor,
              ),
            ),
          ),
          space8H,
          Row(
            children: List.generate(
              4,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 4),
                child: SvgPicture.asset(
                  AppIcons.fire,
                  height: 12,
                  colorFilter: const ColorFilter.mode(
                    AppColors.kPrimaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

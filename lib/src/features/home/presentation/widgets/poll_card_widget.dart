import 'package:flutter_svg/flutter_svg.dart';
import '../../../../src_export.dart';

class PollCardWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final List<Widget> options;
  final String totalVotes;
  final String timeLeft;
  final bool hasVoted;

  const PollCardWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.options,
    required this.totalVotes,
    required this.timeLeft,
    this.hasVoted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: AppPadding.getPadding12(context),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  icon,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    AppColors.kPrimaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              space12W,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    CustomText(
                      subtitle,
                      color: Colors.white.withValues(alpha: .9),
                      fontSize: 11,
                    ),
                  ],
                ),
              ),
            ],
          ),
          space8H,
          ...options,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.people_outline,
                    color: Colors.white,
                    size: 14,
                  ),
                  space4W,
                  CustomText(
                    "$totalVotes ${AppStaticStrings.votesCount.tr}",
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CustomText(
                      timeLeft,
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (hasVoted) ...[
                    space8W,
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.kPrimaryDarkColor3,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 10,
                          ),
                          space4W,
                          CustomText(
                            AppStaticStrings.voted.tr,
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter_svg/flutter_svg.dart';
import '../../../../src_export.dart';

class ChannelListItemWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? img;
  final String? profileImg;

  final bool isActive;
  final VoidCallback onTap;

  const ChannelListItemWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.isActive = false,
    required this.onTap,
    this.img,
    this.profileImg,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTapWidget(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: AppPadding.getPadding12(context),
        decoration: BoxDecoration(
          color: AppColors.kPrimaryColor.withValues(alpha: .3),
          borderRadius: BorderRadius.circular(appRadius),
          border: Border.all(color: AppColors.kPrimaryDarkColor),
        ),
        child: Row(
          spacing: 8,
          children: [
            if (img != null)
              SvgPicture.asset(
                img ?? "",
                colorFilter: const ColorFilter.mode(
                  AppColors.kTextColor,
                  BlendMode.srcIn,
                ),
                height: 20,
              )
            else if (profileImg != null)
              CustomNetworkImage(
                imageUrl: profileImg ?? "",
                height: 60,
                width: 60,
                radius: 50,
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title,
                    fontWeight: FontWeight.bold,
                    color: isActive
                        ? AppColors.kPrimaryColor
                        : AppColors.kTextColor,
                    fontSize: 14,
                  ),
                  space4H,
                  Row(
                    children: [
                      const Icon(
                        Icons.circle,
                        size: 8,
                        color: AppColors.kGreenColor,
                      ),
                      space4W,
                      CustomText(
                        subtitle,
                        fontSize: 12,
                        color: AppColors.kTextColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (title.contains('KLX'))
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const CustomText(
                  'Request',
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

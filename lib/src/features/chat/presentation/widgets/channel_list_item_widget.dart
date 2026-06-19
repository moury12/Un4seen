import 'package:flutter_svg/flutter_svg.dart';
import '../../../../src_export.dart';

class ChannelListItemWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? img;
  final String? profileImg;
  final String channelId;
  final bool? fromChannel;
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
    this.fromChannel = false, this.channelId="",
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTapWidget(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: AppPadding.getPadding6(context),
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
                      if (subtitle.contains('Online'))
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

            if (fromChannel == true && channelId.isNotEmpty)
              Container(
                decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ButtonTapWidget(
                  onTap: () {
                    context.push(AppRoutes.buildsMods,extra:{
                      "channelId":channelId,
                      "channelName":title,
                    } );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                      "Feed",
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/button_tap_widget.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_network_image.dart';
class ChannelMemberItemWidget extends StatelessWidget {
  final String name;
  final String? memberNumber;
  final String? imageUrl;
  final bool isAdded;
  final bool isAdmin;
  final VoidCallback? onToggle;

  const ChannelMemberItemWidget({
    super.key,
    required this.name,
    required this.isAdded,
    this.memberNumber,
    this.imageUrl,
    this.isAdmin = false,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.getPadding12(context),
      decoration: BoxDecoration(
        color: AppColors.kSurfaceColor,
        borderRadius: BorderRadius.circular(appRadius),
      ),
      child: Row(
        children: [
          CustomNetworkImage(
            imageUrl: imageUrl ?? '',
            height: 32,
            width: 32,
            radius: 16,
          ),
          // CircleAvatar(
          //   radius: 16,
          //   backgroundImage: imageUrl != null && imageUrl!.isNotEmpty
          //       ? NetworkImage(imageUrl!)
          //       : const AssetImage('assets/images/logo.png') as ImageProvider,
          // ),
          space12W,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(name, fontWeight: FontWeight.bold),
                if (memberNumber != null)
                  CustomText(memberNumber!, fontSize: 11),
              ],
            ),
          ),
          if (isAdmin)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: AppColors.kPrimaryDarkColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomText(
                AppStaticStrings.admin.tr,
                fontSize: 10,
                color: AppColors.kWhiteTextColor,
              ),
            ),
          if (onToggle != null)
            ButtonTapWidget(
              onTap: onToggle!,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: isAdded
                      ? AppColors.kBackgroundColor
                      : AppColors.kPrimaryColor,
                  borderRadius: BorderRadius.circular(appRadius),
                ),
                child: CustomText(
                  isAdded ? AppStaticStrings.remove.tr : AppStaticStrings.add.tr,
                  color: isAdded
                      ? AppColors.kTextColor
                      : AppColors.kWhiteTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

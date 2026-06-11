import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_text_field.dart';

class ReportMessageDialog extends StatelessWidget {
  final String message;

  const ReportMessageDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(appRadius16),
      ),
      child: Padding(
        padding: AppPadding.getPadding12(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  AppStaticStrings.reportMessage.tr,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            CustomText(
              AppStaticStrings.helpKeepCommunitySafe.tr,
              fontSize: 12,
              color: AppColors.kSecondaryTextColor,
            ),
            space12H,
            Container(
              padding: AppPadding.getPadding12(context),
              decoration: BoxDecoration(
                color: AppColors.kBackgroundColor,
                borderRadius: BorderRadius.circular(appRadius),
              ),
              child: CustomText('"$message"'),
            ),
            space12H,
            CustomText(AppStaticStrings.reason.tr, fontWeight: FontWeight.bold),
            space8H,
            const CustomTextField(
              hintText: "Select a reason...",
              suffixIcon: Icon(Icons.keyboard_arrow_down),
            ),
            space12H,
            CustomText(
              AppStaticStrings.additionalDetails.tr,
              fontWeight: FontWeight.bold,
            ),
            space8H,
            CustomTextField(
              hintText: AppStaticStrings.provideMoreContext.tr,
              maxLines: 3,
            ),
            space12H,
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: AppStaticStrings.cancel.tr,
                    backgroundColor: AppColors.kSurfaceColor,
                    textColor: AppColors.kTextColor,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                space12W,
                Expanded(
                  child: CustomButton(
                    text: AppStaticStrings.submitReport.tr,

                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

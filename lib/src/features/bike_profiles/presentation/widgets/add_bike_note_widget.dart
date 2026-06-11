import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/core_export.dart';

class AddBikeNoteWidget extends StatelessWidget {
  const AddBikeNoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.getPadding12(context),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.kPrimaryColor.withValues(alpha: 0.5),
        ),
      ),
      child: CustomText(
        AppStaticStrings.addNewBikeDetailedNote.tr,
        variant: TextVariant.labelMedium,
        color: Colors.white.withValues(alpha: 0.9),
      ),
    );
  }
}

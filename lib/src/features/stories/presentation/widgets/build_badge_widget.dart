import 'package:flutter/material.dart';

import '../../../../core/core_export.dart';

Widget buildBadgeWidget(String text, BuildContext context) {
  return    Container(
      padding: AppPadding.getPadding4(context),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: CustomText(
        text,
        color: Colors.white,
        fontSize: 9,
        fontWeight: FontWeight.bold,
      ),
    ) ;}
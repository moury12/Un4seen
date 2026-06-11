import 'package:flutter/material.dart';
import 'package:un4seen/src/core/core_export.dart';

class BulletTextWidget extends StatelessWidget {
  final String text;

  const BulletTextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: CircleAvatar(
              radius: 2,
              backgroundColor: AppColors.kWhiteTextColor,
            ),
          ),
          space8W,
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.kWhiteTextColor.withValues(alpha: 0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

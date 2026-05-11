import 'package:flutter/material.dart';
import 'package:un4seen/src/core/core_export.dart';

class ProfilePillWidget extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback? onTap;

  const ProfilePillWidget({
    super.key,
    required this.text,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.kPrimaryColor : AppColors.kSurfaceColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.kPrimaryColor),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? Colors.white : AppColors.kPrimaryColor,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:un4seen/src/core/core_export.dart';

class ProfileDropdownWidget extends StatelessWidget {
  final String value;

  const ProfileDropdownWidget({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.kSurfaceColor,
        borderRadius: BorderRadius.circular(appRadius),
        border: Border.all(color: AppColors.kPrimaryColor, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(value, style: const TextStyle(fontSize: 12, color: Colors.white)),
          const Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 18),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:un4seen/src/core/core_export.dart';

class ProfileDropdownWidget extends StatelessWidget {
  final String value;
  final List<String> options;
  final Function(String?)? onChanged;

  const ProfileDropdownWidget({
    super.key,
    required this.value,
    this.options = const [],
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.kSurfaceColor,
        borderRadius: BorderRadius.circular(appRadius),
        border: Border.all(color: AppColors.kPrimaryColor, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: AppColors.kWhiteTextColor,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.kTextColor,
            size: 18,
          ),
          items: options.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.kTextColor,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

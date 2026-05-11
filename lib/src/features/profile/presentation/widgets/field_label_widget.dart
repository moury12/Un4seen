import 'package:flutter/material.dart';
import 'package:un4seen/src/core/core_export.dart';

class FieldLabelWidget extends StatelessWidget {
  final String label;

  const FieldLabelWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        label,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.kWhiteTextColor),
      ),
    );
  }
}

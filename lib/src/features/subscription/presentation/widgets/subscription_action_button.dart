import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_strings.dart';

class SubscriptionActionButton extends StatelessWidget {
  final bool isAnnual;
  final VoidCallback onPressed;

  const SubscriptionActionButton({
    super.key,
    required this.isAnnual,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    String buttonText = isAnnual
        ? '${AppStaticStrings.startAnnualSubscription} (\$363.99)'
        : 'Start 8-Week Subscription (\$55.89)';

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.kPrimaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
        ),
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

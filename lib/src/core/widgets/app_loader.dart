import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'custom_text.dart';
import 'custom_button.dart';

// ── AppLoader ─────────────────────────────────────────────
class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.kPrimaryColor),
    );
  }
}

// ── EmptyStateWidget ──────────────────────────────────────
class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.onRetry,
    this.retryLabel = 'Retry',
  });

  final String message;
  final IconData icon;
  final VoidCallback? onRetry;
  final String retryLabel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 64, color: AppColors.kSecondaryTextColor),
            const SizedBox(height: 16),
            CustomText(
              message,
              variant: TextVariant.bodyMedium,
              color: AppColors.kSecondaryTextColor,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              CustomButton(
                text: retryLabel,
                onPressed: onRetry!,
                isExpanding: false,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

String formatDate(String isoDate) {
  try {
    DateTime parsedDate = DateTime.parse(isoDate);
    // Returns format: Day/Month/Year (e.g., 9/6/2026)
    return "${parsedDate.day}/${parsedDate.month}/${parsedDate.year}";
  } catch (e) {
    return isoDate; // Fallback to original if parsing fails
  }
}

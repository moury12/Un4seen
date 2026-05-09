import 'package:flutter/material.dart';
import '../../../../core/core_export.dart';
import '../../domain/entities/item_entity.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.item, this.onTap});

  final ItemEntity item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ButtonTapWidget(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: AppPadding.getPadding12(context),
        decoration: BoxDecoration(
          color: AppColors.kSurfaceColor,
          borderRadius: BorderRadius.circular(appRadius),
          border: Border.all(color: AppColors.kAccentColor),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.kPrimaryColor.withValues(alpha: .12),
                borderRadius: BorderRadius.circular(appRadius),
              ),
              child: const Icon(Icons.inbox_outlined, color: AppColors.kPrimaryColor),
            ),
            space12H,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(item.title, variant: TextVariant.titleSmall),
                  if (item.subtitle != null)
                    CustomText(
                      item.subtitle!,
                      variant: TextVariant.labelSmall,
                      color: AppColors.kSecondaryTextColor,
                    ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.kSecondaryTextColor),
          ],
        ),
      ),
    );
  }
}

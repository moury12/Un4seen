import 'package:un4seen/src/src_export.dart';

class PricingCardWidget extends StatelessWidget {
  final String title;
  final String originalPrice;
  final String currentPrice;
  final String unit;
  final bool isSelected;
  final bool showBadge;
  final VoidCallback onTap;

  const PricingCardWidget({
    super.key,
    required this.title,
    required this.originalPrice,
    required this.currentPrice,
    required this.unit,
    required this.isSelected,
    this.showBadge = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            padding: AppPadding.getPadding8(context),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.kPrimaryColor : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected
                    ? AppColors.kPrimaryColor
                    : AppColors.kPrimaryColor.withOpacity(0.3),
                width: 1.5,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColors.kPrimaryColor.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Column(
              children: [
                CustomText(
                  title,
                  variant: TextVariant.titleMedium,
                  color: isSelected ? Colors.white : AppColors.kTextColor,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 4),
                CustomText(
                  originalPrice,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.kTextColor,
                    fontSize: 18,
                    decoration: TextDecoration.lineThrough,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                CustomText(
                  currentPrice,
                  color: isSelected ? Colors.white : AppColors.kTextColor,
                  variant: TextVariant.headlineSmall,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 2),
                CustomText(
                  unit,
                  color: isSelected ? Colors.white : AppColors.kTextColor,
                  variant: TextVariant.labelSmall,
                ),
              ],
            ),
          ),
          if (showBadge)
            Positioned(
              top: -12,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF22C55E),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const CustomText(
                    'Best Value',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

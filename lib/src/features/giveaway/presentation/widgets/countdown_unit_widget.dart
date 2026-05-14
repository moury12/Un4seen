import '../../../../src_export.dart';

class CountdownUnitWidget extends StatelessWidget {
  final String value;
  final String label;
  final bool showLabelBelow;

  const CountdownUnitWidget({
    super.key,
    required this.value,
    required this.label,
    this.showLabelBelow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.kPrimaryColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 4, offset: const Offset(0, 2)),
            ],
          ),
          child: CustomText(
            value,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        if (showLabelBelow) ...[
          space4H,
          CustomText(label, variant: TextVariant.labelSmall, color: Colors.white70),
        ],
      ],
    );
  }
}

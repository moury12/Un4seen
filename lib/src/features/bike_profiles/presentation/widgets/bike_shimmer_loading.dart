import '../../../../src_export.dart';

class BikeShimmerLoading extends StatelessWidget {
  const BikeShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final Color base = AppColors.kPrimaryDarkColor.withValues(alpha: 0.3);
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: base,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        space12H,
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: base,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        space12H,
        ...List.generate(
          3,
          (index) => Container(
            height: 60,
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: base,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}

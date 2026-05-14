import '../../../../src_export.dart';
import '../../../../core/widgets/gradient_container.dart';

class ActivityLogTile extends StatelessWidget {
  final String title;
  final String date;
  final String points;

  const ActivityLogTile({
    super.key,
    required this.title,
    required this.date,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      margin: const EdgeInsets.only(bottom: 8),
      padding: AppPadding.getPadding12(context),
      gradientColors: [AppColors.kPrimaryDarkColor, AppColors.kPrimaryColor],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(title, color: Colors.white, fontWeight: FontWeight.bold,fontSize: 14),
              CustomText(date, color: Colors.white70, fontSize: 12),
            ],
          ),
          CustomText("+$points", color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ],
      ),
    );
  }
}

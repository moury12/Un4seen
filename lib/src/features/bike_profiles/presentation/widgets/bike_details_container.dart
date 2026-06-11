import '../../../../src_export.dart';
import '../widgets/bike_detail_item.dart';

class BikeDetailsContainerWidget extends StatelessWidget {
  final BikeModel bike;
  const BikeDetailsContainerWidget({super.key, required this.bike});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryDarkColor2,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            AppStaticStrings.bikeDetails.tr,
            variant: TextVariant.titleLarge,
            fontWeight: FontWeight.bold,
            color: AppColors.kWhiteTextColor,
          ),
          space8H,
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: BikeDetailItem(
                  label: 'Year',
                  value: bike.year,
                  icon: Icons.calendar_today,
                ),
              ),
              Expanded(
                child: BikeDetailItem(
                  label: 'Type',
                  value: bike.bikeType,
                  icon: Icons.directions_bike,
                ),
              ),
            ],
          ),
          space8H,
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: BikeDetailItem(
                  label: 'Make',
                  value: bike.make,
                  icon: Icons.bookmark_add_outlined,
                ),
              ),
              Expanded(
                child: BikeDetailItem(
                  label: 'Model',
                  value: bike.model,
                  icon: Icons.motorcycle,
                ),
              ),
            ],
          ),
          space8H,
          BikeDetailItem(
            label: 'Color',
            value: bike.color,
            icon: Icons.color_lens,
          ),
        ],
      ),
    );
    ;
  }
}

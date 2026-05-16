import '../../../../src_export.dart';
import '../widgets/rate_ride_card_widget.dart';
import '../widgets/upload_ride_dialog.dart';

class RateRidePage extends StatelessWidget {
  const RateRidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppStaticStrings.rateMyRideTitle.tr),
        actions: [
          SizedBox(
            width: 150,
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: CustomButton(
                text: AppStaticStrings.upload.tr,
                onPressed: () => UploadRideDialog.show(context),
                isExpanding: true,
                icon: Icons.upload_outlined,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12H(context),
        child: Column(
          children: [
            CustomText(
              AppStaticStrings.rateMyRideDesc.tr,
              color: AppColors.kTextColor,
              fontSize: 12,
            ),
            space12H,
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(color: AppColors.kPrimaryColor),
              child: Row(
                children: [
                  const Icon(
                    Icons.emoji_events_outlined,
                    color: Colors.white,
                    size: 16,
                  ),
                  space8W,
                  CustomText(
                    AppStaticStrings.votingEndsSunday.tr,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ],
              ),
            ),
            space12H,
            const RateRideCardWidget(),
            space24H,
          ],
        ),
      ),
    );
  }
}

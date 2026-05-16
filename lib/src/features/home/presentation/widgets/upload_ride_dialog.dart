import '../../../../src_export.dart';

class UploadRideDialog extends StatelessWidget {
  const UploadRideDialog({super.key});

  static void show(BuildContext context) {
    showDialog(context: context, builder: (context) => const UploadRideDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.kPrimaryDarkColor3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.kPrimaryColor),
      ),
      child: Padding(
        padding: AppPadding.getPadding16(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(AppStaticStrings.rateMyRideTitle.tr, color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      CustomText(AppStaticStrings.chooseBestBikePhoto.tr, color: Colors.white70, fontSize: 11),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.white),
                  style: IconButton.styleFrom(backgroundColor: AppColors.kPrimaryColor),
                ),
              ],
            ),
            const Divider(color: Colors.white10, height: 24),
            CustomText(AppStaticStrings.uploadDesignImage.tr, color: Colors.white, fontWeight: FontWeight.bold),
            space8H,
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.camera_alt_outlined, color: AppColors.kPrimaryColor, size: 32),
            ),
            space12H,
            CustomTextField(
              title: AppStaticStrings.bikeTypeLabel.tr,
              hintText: "MX",
              fillColor: Colors.transparent,
              titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            space12H,
            CustomTextField(
              title: AppStaticStrings.description.tr,
              hintText: AppStaticStrings.bikeDescriptionHint.tr,
              maxLines: 3,
              fillColor: Colors.transparent,
              titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            space16H,
            CustomButton(text: AppStaticStrings.uploadEnterCompetition.tr, onPressed: () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }
}

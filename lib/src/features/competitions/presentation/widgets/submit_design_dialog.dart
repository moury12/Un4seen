import '../../../../src_export.dart';

class SubmitDesignDialog extends StatelessWidget {
  const SubmitDesignDialog({super.key});

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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(AppStaticStrings.submitYourDesign.tr, variant: TextVariant.titleLarge, color: Colors.white),
                IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.close, color: Colors.white)),
              ],
            ),
            space12H,
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white12, style: BorderStyle.solid),
              ),
              child: const Icon(Icons.camera_alt_outlined, color: AppColors.kPrimaryColor, size: 40),
            ),
            space12H,
            CustomTextField(
              title: AppStaticStrings.designNameLabel.tr,
              hintText: AppStaticStrings.designNameHint.tr,
              fillColor: Colors.white10,
              borderColor: Colors.white24,
              inputTextStyle: const TextStyle(color: Colors.white),
            ),
            space12H,
            CustomButton(text: AppStaticStrings.submitEntry.tr, onPressed: () => Get.back()),
          ],
        ),
      ),
    );
  }
}
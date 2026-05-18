import '../../../../src_export.dart';

class SubmitDesignDialog extends StatelessWidget {
  const SubmitDesignDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.kPrimaryDarkColor3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(appRadius16),
        side: BorderSide(color: AppColors.kPrimaryColor.withValues(alpha: 0.6)),
      ),
      child: Padding(
        padding: AppPadding.getPadding16(context),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        AppStaticStrings.submitYourDesign.tr,
                        variant: TextVariant.titleLarge,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      space4H,
                      CustomText(
                        AppStaticStrings.designOwnGear.tr,
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
              space12H,
              CustomText(
                AppStaticStrings.uploadDesignImage.tr,
                color: Colors.white,
                fontSize: 12,
              ),
              space8H,
              ButtonTapWidget(
                onTap: () {
                  final controller = Get.find<HomeController>();
                  controller.pickRideImage();
                },
                child: Obx(() {
                  final controller = Get.find<HomeController>();
                  return Container(
                    height: controller.selectedRideImage.value != null
                        ? 300
                        : 100,
                    width: double.infinity,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: controller.selectedRideImage.value == null
                        ? const Icon(
                            Icons.camera_alt_outlined,
                            color: AppColors.kPrimaryColor,
                            size: 32,
                          )
                        : InteractiveViewer(
                            panEnabled: true,
                            scaleEnabled: true,
                            minScale: 0.5,
                            maxScale: 4.0,
                            child: Image.file(
                              controller.selectedRideImage.value!,
                              fit: BoxFit.contain,
                            ),
                          ),
                  );
                }),
              ),
              space16H,
              CustomTextField(
                title: AppStaticStrings.designNameLabel.tr,
                hintText: AppStaticStrings.designNameHint.tr,
                fillColor: Colors.white10,
                borderColor: Colors.white24,
                titleStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                inputTextStyle: const TextStyle(color: Colors.white),
                hintStyle: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
              space16H,
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(appRadius),
                  border: Border.all(color: Colors.white12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      AppStaticStrings.winCustomGearSize.tr,
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    space4H,
                    CustomText(
                      AppStaticStrings.designOwnGearDesc.tr,
                      color: Colors.white,
                      fontSize: 11,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              space16H,
              CustomButton(
                text: AppStaticStrings.submitEntry.tr,
                onPressed: () => Get.back(),
              ),
              space12H,
              CustomText(
                'By submitting, you grant Un4seen rights to feature your design.',
                color: Colors.white,
                fontSize: 10,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

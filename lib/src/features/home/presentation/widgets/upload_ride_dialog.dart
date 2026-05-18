import '../../../../src_export.dart';

class UploadRideDialog extends StatelessWidget {
  const UploadRideDialog({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const UploadRideDialog(),
    );
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
        padding: AppPadding.getPadding12(context),
        child: SingleChildScrollView(
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
                        CustomText(
                          AppStaticStrings.rateMyRideTitle.tr,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        CustomText(
                          AppStaticStrings.chooseBestBikePhoto.tr,
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.kPrimaryColor,
                    ),
                  ),
                ],
              ),
              const Divider(color: Colors.white10, height: 24),
              CustomText(
                AppStaticStrings.uploadDesignImage.tr,
                color: Colors.white,

                fontWeight: FontWeight.bold,
              ),
              space8H,

              Obx(() {
                final controller = Get.find<HomeController>();
                return controller.selectedRideImage.value == null
                    ? ButtonTapWidget(
                        onTap: () {
                          controller.pickRideImage();
                        },
                        child: Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            color: AppColors.kPrimaryColor,
                            size: 32,
                          ),
                        ),
                      )
                    : Container(
                        height: 300,
                        width: double.infinity,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: InteractiveViewer(
                                panEnabled: true,
                                scaleEnabled: true,
                                minScale: 0.5,
                                maxScale: 4.0,
                                child: Image.file(
                                  controller.selectedRideImage.value!,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: InkWell(
                                onTap: () {
                                  controller.pickRideImage();
                                },
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.kPrimaryDarkColor2,
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
              }),
              space12H,
              CustomTextField(
                hintStyle: TextStyle(color: Colors.white, fontSize: 12),
                title: AppStaticStrings.bikeTypeLabel.tr,
                hintText: "MX",
                inputTextStyle: const TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                fillColor: Colors.transparent,
                titleStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              space12H,
              CustomTextField(
                hintStyle: TextStyle(color: Colors.white, fontSize: 12),
                title: AppStaticStrings.description.tr,
                hintText: AppStaticStrings.bikeDescriptionHint.tr,
                maxLines: 3,
                inputTextStyle: const TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                fillColor: Colors.transparent,
                titleStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              space16H,
              CustomButton(
                text: AppStaticStrings.uploadEnterCompetition.tr,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import '../../../../src_export.dart';

class UploadRideDialog extends StatefulWidget {
  const UploadRideDialog({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const UploadRideDialog(),
    );
  }

  @override
  State<UploadRideDialog> createState() => _UploadRideDialogState();
}

class _UploadRideDialogState extends State<UploadRideDialog> {
  // Local controllers for the input fields
  final TextEditingController _bikeModelCtrl = TextEditingController();
  final TextEditingController _descriptionCtrl = TextEditingController();
  final TextEditingController _rideTypeCtrl = TextEditingController();

  @override
  void dispose() {
    _bikeModelCtrl.dispose();
    _descriptionCtrl.dispose();
    _rideTypeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RateMyRideController>();
    final homeController = Get.find<HomeController>();

    return Dialog(
      backgroundColor: AppColors.kPrimaryDarkColor3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.kPrimaryColor),
      ),
      child: Padding(
        padding: AppPadding.getPadding12(context),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
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

              // Image Picker Section
              Obx(() {
                return homeController.selectedRideImage.value == null
                    ? ButtonTapWidget(
                        onTap: () => homeController.pickRideImage(),
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
                        height: 250,
                        width: double.infinity,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.file(
                                homeController.selectedRideImage.value!,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: ButtonTapWidget(
                                onTap: () => homeController.pickRideImage(),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.kPrimaryColor,
                                  ),
                                  child: const Icon(
                                    Icons.refresh,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
              }),
              space12H,

              // Input Fields
              CustomTextField(
                fillColor: Colors.transparent,
                hintStyle: const TextStyle(
                  color: AppColors.kWhiteTextColor,
                  fontSize: 10,
                ),
                title: AppStaticStrings.bikeModel.tr,
                hintText: "Eg. Honda CRF250R",
                textEditingController: _bikeModelCtrl,

                inputTextStyle: const TextStyle(color: Colors.white),
                titleStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // space12H,
              // CustomTextField(
              //   fillColor: Colors.transparent,
              //   hintStyle: const TextStyle(
              //     color: AppColors.kWhiteTextColor,
              //     fontSize: 10,
              //   ),
              //   title: AppStaticStrings.bikeTypeLabel.tr,
              //   hintText: "MX",
              //   textEditingController: _rideTypeCtrl,

              //   inputTextStyle: const TextStyle(color: Colors.white),
              //   titleStyle: const TextStyle(
              //     color: Colors.white,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              space12H,
              CustomTextField(
                fillColor: Colors.transparent,
                hintStyle: const TextStyle(
                  color: AppColors.kWhiteTextColor,
                  fontSize: 10,
                ),
                title: AppStaticStrings.description.tr,
                hintText: AppStaticStrings.bikeDescriptionHint.tr,
                textEditingController: _descriptionCtrl,
                maxLines: 3,

                inputTextStyle: const TextStyle(color: Colors.white),
                titleStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              space24H,

              // Submit Button
              Obx(
                () => CustomButton(
                  text: AppStaticStrings.uploadEnterCompetition.tr,
                  isLoading: controller.isSubmitting.value,
                  onPressed: () async {
                    final isSuccess = await controller.uploadRide(
                      _bikeModelCtrl.text.trim(),
                      _descriptionCtrl.text.trim(),
                      _rideTypeCtrl.text.trim(),
                    );
                    if (isSuccess) {
                      context.pop();
                    } else {
                      context.pop();
                    }
                  },
                ),
              ),
              space12H,
            ],
          ),
        ),
      ),
    );
  }
}

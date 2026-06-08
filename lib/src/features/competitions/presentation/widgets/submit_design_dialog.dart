import '../../../../src_export.dart';

class SubmitDesignDialog extends StatefulWidget {
  final CompetitionModel competition;
  const SubmitDesignDialog({super.key, required this.competition});

  @override
  State<SubmitDesignDialog> createState() => _SubmitDesignDialogState();
}

class _SubmitDesignDialogState extends State<SubmitDesignDialog> {
  final TextEditingController _designNameController = TextEditingController();

  @override
  void dispose() {
    _designNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final competitionsController = Get.find<CompetitionsController>();
    final homeController = Get.find<HomeController>();

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
                  Expanded(
                    child: Column(
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
                          widget.competition.title,
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ],
                    ),
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
                onTap: () => homeController.pickRideImage(),
                child: Obx(() {
                  return Container(
                    height: homeController.selectedRideImage.value != null
                        ? 300
                        : 100,
                    width: double.infinity,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: homeController.selectedRideImage.value == null
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
                              homeController.selectedRideImage.value!,
                              fit: BoxFit.contain,
                            ),
                          ),
                  );
                }),
              ),
              space16H,
              CustomTextField(
                textEditingController: _designNameController,
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
                      widget.competition.grandPrize,
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    space4H,
                    CustomText(
                      widget.competition.description,
                      color: Colors.white,
                      fontSize: 11,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              space16H,
              Obx(
                () => CustomButton(
                  text: competitionsController.isSubmitting.value
                      ? 'Submitting...'
                      : AppStaticStrings.submitEntry.tr,
                  onPressed: () async {
                    if (competitionsController.isSubmitting.value) return;
                    final imagePath =
                        homeController.selectedRideImage.value?.path;
                    if (imagePath == null) {
                      CustomSnackbar.showError('Please select an image.');
                      return;
                    }
                    if (_designNameController.text.trim().isEmpty) {
                      CustomSnackbar.showError('Please enter a design name.');
                      return;
                    }
                    final success = await competitionsController.submitDesign(
                      widget.competition.id,
                      _designNameController.text.trim(),
                      imagePath,
                    );
                    if (success) {
                      context.pop();
                      return;
                    } else {
                      context.pop();
                      // CustomSnackbar.showError('Please enter a design name.');
                      return;
                    }
                  },
                ),
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

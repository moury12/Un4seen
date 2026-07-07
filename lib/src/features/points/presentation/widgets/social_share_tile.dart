import 'package:flutter_svg/flutter_svg.dart';
import '../../../../src_export.dart';
import '../../../../core/widgets/gradient_container.dart';

class SocialShareTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final String icon;
  final String points;
  final VoidCallback? onTap;

  const SocialShareTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.points,
    this.onTap,
  });

  @override
  State<SocialShareTile> createState() => _SocialShareTileState();
}

class _SocialShareTileState extends State<SocialShareTile> {
  final TextEditingController _platformCtrl = TextEditingController();
  final TextEditingController _postLinkCtrl = TextEditingController();

  @override
  void dispose() {
    _platformCtrl.dispose();
    _postLinkCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pointsCtrl = Get.find<PointsController>();
    return GradientContainer(
      margin: const EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.zero,
      gradientColors: const [
        AppColors.kPrimaryDarkColor,
        AppColors.kPrimaryColor,
      ],
      child: ButtonTapWidget(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(widget.icon, height: 20),
              ),
              space12W,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      widget.title,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      widget.subtitle,
                      color: Colors.white70,
                      fontSize: 10,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CustomText(
                  "+${widget.points}",
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              space8W,
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ButtonTapWidget(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => SubmitProofDialog(
                        platformCtrl: _platformCtrl,
                        postLinkCtrl: _postLinkCtrl,
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: CustomText(
                      AppStaticStrings.claim.tr,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubmitProofDialog extends StatefulWidget {
  const SubmitProofDialog({
    super.key,
    required this.platformCtrl,
    required this.postLinkCtrl,
    this.hint,
  });

  final TextEditingController platformCtrl;
  final TextEditingController postLinkCtrl;
  final String? hint;

  @override
  State<SubmitProofDialog> createState() => _SubmitProofDialogState();
}

class _SubmitProofDialogState extends State<SubmitProofDialog> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final pointsCtrl = Get.find<PointsController>();

    return Dialog(
      backgroundColor: AppColors.kPrimaryDarkColor3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.kPrimaryColor),
      ),
      child: Padding(
        padding: AppPadding.getPadding12(context),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(child: SizedBox.shrink()),
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
                  return pointsCtrl.selectedProofImage.value == null
                      ? ButtonTapWidget(
                          onTap: () => pointsCtrl.pickProofImage(),
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
                                  pointsCtrl.selectedProofImage.value!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: 8,
                                right: 8,
                                child: ButtonTapWidget(
                                  onTap: () => pointsCtrl.pickProofImage(),
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
                  isRequired: true,
                  fillColor: Colors.transparent,
                  hintStyle: const TextStyle(
                    color: AppColors.kWhiteTextColor,
                    fontSize: 10,
                  ),
                  title: AppStaticStrings.platform.tr,
                  hintText: widget.hint ?? "Eg. Facebook",
                  textEditingController: widget.platformCtrl,

                  inputTextStyle: const TextStyle(color: Colors.white),
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                space12H,
                CustomTextField(
                  isRequired: true,
                  fillColor: Colors.transparent,
                  hintStyle: const TextStyle(
                    color: AppColors.kWhiteTextColor,
                    fontSize: 10,
                  ),
                  title: AppStaticStrings.postLink.tr,
                  hintText: "eg. https://ig.me/xyz",
                  textEditingController: widget.postLinkCtrl,

                  inputTextStyle: const TextStyle(color: Colors.white),
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                space8H,
                Obx(
                  () => CustomButton(
                    text: AppStaticStrings.uploadEnterCompetition.tr,
                    isLoading: pointsCtrl.isSubmittingProof.value,
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;
                      if (pointsCtrl.selectedProofImage.value == null) {
                        CustomSnackbar.showError("Please select a proof image");
                        return;
                      }

                      final isSuccess = await pointsCtrl.submitProof(
                        platform: widget.platformCtrl.text.trim(),
                        postLink: widget.postLinkCtrl.text.trim(),
                        imageFile: pointsCtrl.selectedProofImage.value!,
                      );
                      if (isSuccess) {
                        widget.platformCtrl.clear();
                        widget.postLinkCtrl.clear();
                        pointsCtrl.selectedProofImage.value = null;
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
      ),
    );
  }
}

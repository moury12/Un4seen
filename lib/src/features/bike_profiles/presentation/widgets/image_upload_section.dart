import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:un4seen/src/features/bike_profiles/bike_profiles_export.dart';
import '../../../../core/core_export.dart';

class ImageUploadSection extends StatelessWidget {
  final String? initialImageUrl;
  ImageUploadSection({super.key, this.initialImageUrl});
  final controller = Get.put(BikeProfilesController());
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          AppStaticStrings.imageUpload.tr,
          fontWeight: FontWeight.bold,
          variant: TextVariant.titleMedium,
          color: AppColors.kWhiteTextColor,
        ),
        space8H,
        ButtonTapWidget(
          onTap: () {
            controller.pickImage();
          },
          child: Center(
            child: Obx(() {
              if (controller.profileImage.value != null) {
                return InteractiveViewer(
                  panEnabled: true,
                  scaleEnabled: true,
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: Image.file(
                    controller.profileImage.value!,
                    fit: BoxFit.contain,
                    // height: 100,
                  ),
                );
              } else if (initialImageUrl != null && initialImageUrl!.isNotEmpty) {
                return InteractiveViewer(
                  panEnabled: true,
                  scaleEnabled: true,
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: CustomNetworkImage(
                    imageUrl: initialImageUrl!,
                    fit: BoxFit.contain,
                    height:400,
                  ),
                );
              } else {
                return Container(
                  height: 80,
                  width: 80,
                  decoration: const BoxDecoration(
                    color: AppColors.kPrimaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                    size: 32,
                  ),
                );
              }
            }),
          ),
        ),
      ],
    );
  }
}

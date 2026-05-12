import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:un4seen/src/features/bike_profiles/bike_profiles_export.dart';
import '../../../../core/core_export.dart';

class ImageUploadSection extends StatelessWidget {
  ImageUploadSection({super.key});
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

        ButtonTapWidget(
          onTap: () {
            controller.pickImage();
          },
          child: Center(
            child: Obx(() {
              return Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  image: controller.profileImage.value != null
                      ? DecorationImage(
                          image: FileImage(controller.profileImage.value!),
                          fit: BoxFit.cover,
                        )
                      : null,
                  color: controller.profileImage.value != null
                      ? Colors.transparent
                      : AppColors.kPrimaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                  size: 32,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

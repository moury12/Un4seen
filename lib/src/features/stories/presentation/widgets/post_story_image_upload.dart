import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:un4seen/src/core/core_export.dart';
import 'package:un4seen/src/features/stories/presentation/controllers/story_controller.dart';

class PostStoryImageUpload extends StatelessWidget {
  PostStoryImageUpload({super.key});

  final controller = Get.put(StoryController());

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
        space12H,
        ButtonTapWidget(
          onTap: controller.pickImage,
          child: Center(
            child: Obx(() {
              return Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor,
                  shape: BoxShape.circle,
                  image: controller.selectedImage.value != null
                      ? DecorationImage(
                          image: FileImage(controller.selectedImage.value!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: controller.selectedImage.value == null
                    ? const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                        size: 40,
                      )
                    : null,
              );
            }),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:un4seen/src/core/core_export.dart';
import '../controllers/profile_controller.dart';
import '../widgets/field_label_widget.dart';
import '../widgets/profile_dropdown_widget.dart';
import '../widgets/profile_pill_widget.dart';

class ProfileSettingPage extends StatelessWidget {
  ProfileSettingPage({super.key});

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStaticStrings.profileSetting.tr)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppPadding.getPadding12H(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar with camera icon
              Center(
                child: GestureDetector(
                  onTap: controller.pickImage,
                  child: Stack(
                    children: [
                      Obx(
                        () => Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.kPrimaryColor,
                              width: 2,
                            ),
                            image: controller.profileImage.value != null
                                ? DecorationImage(
                                    image: FileImage(
                                      controller.profileImage.value!,
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : const DecorationImage(
                                    image: NetworkImage(
                                      'https://i.pravatar.cc/150?img=11',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: AppColors.kPrimaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              space4H,
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.kPrimaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CustomText(
                    '#SYN-2847',
                    variant: TextVariant.labelSmall,
                    color: AppColors.kWhiteTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              space4H,
              const Center(
                child: CustomText(
                  '🇳🇿 New Zealand',
                  variant: TextVariant.labelMedium,
                  color: AppColors.kTextColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              space4H,

              // Forms
              // Forms
              FieldLabelWidget(label: AppStaticStrings.fullName.tr),
              CustomTextField(
                hintText: controller.fullName.value,
                prefixIcon: const Icon(
                  Icons.person_outline,
                  color: AppColors.kPrimaryColor,
                  size: 18,
                ),

                borderColor: AppColors.kPrimaryColor,
              ),
              space4H,
              FieldLabelWidget(label: AppStaticStrings.aboutMe.tr),
              CustomTextField(
                hintText: controller.aboutMe.value,
                maxLines: 4,

                borderColor: AppColors.kPrimaryColor,
              ),
              space4H,
              FieldLabelWidget(label: AppStaticStrings.facebookUrl.tr),
              CustomTextField(
                hintText: controller.facebookUrl.value,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(AppIcons.fb),
                ),

                borderColor: AppColors.kPrimaryColor,
              ),
              space4H,
              FieldLabelWidget(label: AppStaticStrings.instagramUrl.tr),
              CustomTextField(
                hintText: controller.instagramUrl.value,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(AppIcons.ig),
                ),

                borderColor: AppColors.kPrimaryColor,
              ),
              space4H,
              FieldLabelWidget(label: AppStaticStrings.tiktokUrl.tr),
              CustomTextField(
                hintText: controller.tiktokUrl.value,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(AppIcons.tictok),
                ),

                borderColor: AppColors.kPrimaryColor,
              ),
              space4H,
              FieldLabelWidget(label: AppStaticStrings.emailAddress.tr),
              CustomTextField(
                hintText: controller.email.value,

                borderColor: AppColors.kPrimaryColor,
              ),
              space4H,
              FieldLabelWidget(label: AppStaticStrings.mobileNumber.tr),
              CustomTextField(
                hintText: controller.mobileNumber.value,

                borderColor: AppColors.kPrimaryColor,
              ),
              space4H,
              FieldLabelWidget(label: AppStaticStrings.deliveryAddress.tr),
              CustomTextField(
                hintText: AppStaticStrings.streetAddress.tr,

                borderColor: AppColors.kPrimaryColor,
              ),
              space4H,
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      hintText: AppStaticStrings.city.tr,

                      borderColor: AppColors.kPrimaryColor,
                    ),
                  ),
                  space12W,
                  Expanded(
                    child: CustomTextField(
                      hintText: AppStaticStrings.postalCode.tr,

                      borderColor: AppColors.kPrimaryColor,
                    ),
                  ),
                ],
              ),
              space4H,
              CustomTextField(
                hintText: AppStaticStrings.stateRegion.tr,

                borderColor: AppColors.kPrimaryColor,
              ),
              space4H,
              FieldLabelWidget(label: AppStaticStrings.clothingFit.tr),
              Obx(
                () => ProfileDropdownWidget(
                  value: controller.selectedClothingFit.value,
                  options: controller.clothingFitList,
                  onChanged: (v) => controller.selectedClothingFit.value = v!,
                ),
              ),
              space4H,
              FieldLabelWidget(label: AppStaticStrings.tshirtSize.tr),
              Obx(
                () => ProfileDropdownWidget(
                  value: controller.selectedTShirtSize.value,
                  options: controller.sizeList,
                  onChanged: (v) => controller.selectedTShirtSize.value = v!,
                ),
              ),
              space4H,
              FieldLabelWidget(label: AppStaticStrings.hoodieJerseySize.tr),
              Obx(
                () => ProfileDropdownWidget(
                  value: controller.selectedHoodieSize.value,
                  options: controller.sizeList,
                  onChanged: (v) => controller.selectedHoodieSize.value = v!,
                ),
              ),
              space4H,
              FieldLabelWidget(label: AppStaticStrings.bikeModel.tr),
              CustomTextField(
                hintText: 'Yamaha Yz450f',

                borderColor: AppColors.kPrimaryColor,
              ),
              space4H,
              FieldLabelWidget(label: AppStaticStrings.year.tr),
              CustomTextField(
                hintText: '2024',

                borderColor: AppColors.kPrimaryColor,
              ),
              space4H,
              FieldLabelWidget(label: AppStaticStrings.rideType.tr),
              Obx(
                () => Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: controller.rideTypeList.map((type) {
                    return ProfilePillWidget(
                      text: type,
                      isSelected: controller.selectedRideTypes.contains(type),
                      onTap: () => controller.toggleRideType(type),
                    );
                  }).toList(),
                ),
              ),
              space4H,
              FieldLabelWidget(label: AppStaticStrings.ridingLevel.tr),
              Obx(
                () => Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: controller.ridingLevelList.map((level) {
                    return ProfilePillWidget(
                      text: level,
                      isSelected: controller.selectedRidingLevels.contains(
                        level,
                      ),
                      onTap: () => controller.toggleRidingLevel(level),
                    );
                  }).toList(),
                ),
              ),
              space8H,
              CustomButton(text: AppStaticStrings.save.tr, onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

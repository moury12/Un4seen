import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      body: Obx(
        () => SafeArea(
          child: SingleChildScrollView(
            padding: AppPadding.getPadding12H(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar Section
                Center(
                  child: GestureDetector(
                    onTap: controller.pickImage,
                    child: Stack(
                      children: [
                        Container(
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
                      controller.memberNumber.value,
                      variant: TextVariant.labelSmall,
                      color: AppColors.kWhiteTextColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                space4H,
                Center(
                  child: CustomText(
                    '🇳🇿 ${controller.countryName.value}',
                    variant: TextVariant.labelMedium,
                    color: AppColors.kTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                space12H,

                // Forms
                FieldLabelWidget(label: AppStaticStrings.fullName.tr),
                Row(
                  spacing: 8,
                  children: [
                    Expanded(
                      child: CustomTextField(
                        textEditingController: controller.firstNameController,
                        prefixIcon: const Icon(
                          Icons.person_outline,
                          color: AppColors.kPrimaryColor,
                          size: 18,
                        ),
                        borderColor: AppColors.kPrimaryColor,
                      ),
                    ),
                    Expanded(
                      child: CustomTextField(
                        textEditingController: controller.lastNameController,
                        prefixIcon: const Icon(
                          Icons.person_outline,
                          color: AppColors.kPrimaryColor,
                          size: 18,
                        ),
                        borderColor: AppColors.kPrimaryColor,
                      ),
                    ),
                  ],
                ),
                space8H,
                FieldLabelWidget(label: AppStaticStrings.aboutMe.tr),
                CustomTextField(
                  textEditingController: controller.aboutMeController,
                  maxLines: 3,
                  borderColor: AppColors.kPrimaryColor,
                ),
                space8H,
                space4H,
                FieldLabelWidget(label: AppStaticStrings.facebookUrl.tr),
                CustomTextField(
                  hintText: controller.facebookUrl.value,
                  textEditingController: controller.facebookController,
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
                  textEditingController: controller.instagramController,

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
                  textEditingController: controller.tiktokController,

                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(AppIcons.tictok),
                  ),

                  borderColor: AppColors.kPrimaryColor,
                ),
                space4H,
                FieldLabelWidget(label: AppStaticStrings.emailAddress.tr),
                CustomTextField(
                  textEditingController: controller.emailController,
                  borderColor: AppColors.kPrimaryColor,
                  readOnly: true, // Usually emails aren't editable directly
                ),
                space8H,
                FieldLabelWidget(label: AppStaticStrings.mobileNumber.tr),
                CustomTextField(
                  textEditingController: controller.mobileController,
                  borderColor: AppColors.kPrimaryColor,
                ),
                space8H,
                FieldLabelWidget(label: AppStaticStrings.deliveryAddress.tr),
                CustomTextField(
                  hintText: AppStaticStrings.streetAddress.tr,
                  textEditingController: controller.streetController,
                  borderColor: AppColors.kPrimaryColor,
                ),
                space8H,
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hintText: AppStaticStrings.city.tr,
                        textEditingController: controller.cityController,
                        borderColor: AppColors.kPrimaryColor,
                      ),
                    ),
                    space12W,
                    Expanded(
                      child: CustomTextField(
                        hintText: AppStaticStrings.postalCode.tr,
                        textEditingController: controller.zipController,
                        borderColor: AppColors.kPrimaryColor,
                      ),
                    ),
                  ],
                ),
                space8H,
                CustomTextField(
                  hintText: AppStaticStrings.stateRegion.tr,
                  textEditingController: controller.stateController,
                  borderColor: AppColors.kPrimaryColor,
                ),
                space12H,

                FieldLabelWidget(label: AppStaticStrings.clothingFit.tr),
                ProfileDropdownWidget(
                  value: controller.selectedClothingFit.value,
                  options: controller.clothingFitList,
                  onChanged: (v) => controller.selectedClothingFit.value = v!,
                ),
                space8H,
                FieldLabelWidget(label: AppStaticStrings.tshirtSize.tr),
                ProfileDropdownWidget(
                  value: controller.selectedTShirtSize.value,
                  options: controller.sizeList,
                  onChanged: (v) => controller.selectedTShirtSize.value = v!,
                ),
                space8H,
                FieldLabelWidget(label: AppStaticStrings.hoodieJerseySize.tr),

                ProfileDropdownWidget(
                  value: controller.selectedHoodieSize.value,
                  options: controller.sizeList,
                  onChanged: (v) => controller.selectedHoodieSize.value = v!,
                ),
                space12H,
                FieldLabelWidget(label: AppStaticStrings.bikeModel.tr),
                CustomTextField(
                  textEditingController: controller.bikeModelController,
                  borderColor: AppColors.kPrimaryColor,
                ),
                space8H,
                FieldLabelWidget(label: AppStaticStrings.year.tr),
                CustomTextField(
                  textEditingController: controller.bikeYearController,
                  borderColor: AppColors.kPrimaryColor,
                ),
                space12H,

                FieldLabelWidget(label: AppStaticStrings.rideType.tr),
                Wrap(
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
                space12H,
                CustomButton(
                  text: AppStaticStrings.save.tr,
                  isLoading: controller.isLoading.value,
                  onPressed: controller.updateProfile,
                ),
                space24H,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

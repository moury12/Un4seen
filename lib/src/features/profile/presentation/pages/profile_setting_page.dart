import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:un4seen/src/core/core_export.dart';
import '../widgets/field_label_widget.dart';
import '../widgets/profile_text_field_widget.dart';
import '../widgets/profile_dropdown_widget.dart';
import '../widgets/profile_pill_widget.dart';

class ProfileSettingPage extends StatelessWidget {
  const ProfileSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStaticStrings.profileSetting.tr,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppPadding.getPadding12(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar with camera icon
              Center(
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
                        image: const DecorationImage(
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
              space8H,
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
                  child: const Text(
                    '#SYN-2847',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              space4H,
              const Center(
                child: Text(
                  '🇳🇿 New Zealand',
                  style: TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ),
              space24H,

              // Forms
              FieldLabelWidget(label: AppStaticStrings.fullName.tr),
              const ProfileTextFieldWidget(hint: 'Nahid Hossain', icon: Icons.person_outline),
              space12H,
              FieldLabelWidget(label: AppStaticStrings.aboutMe.tr),
              const ProfileTextFieldWidget(hint: 'I\'m a passionate and creative individual...', maxLines: 4),
              space12H,
              FieldLabelWidget(label: AppStaticStrings.facebookUrl.tr),
              const ProfileTextFieldWidget(hint: '@nahiddd1', icon: Icons.facebook),
              space12H,
              FieldLabelWidget(label: AppStaticStrings.instagramUrl.tr),
              const ProfileTextFieldWidget(hint: '@nahiddd1', icon: Icons.camera_alt_outlined),
              space12H,
              FieldLabelWidget(label: AppStaticStrings.tiktokUrl.tr),
              const ProfileTextFieldWidget(hint: '@nahiddd1', icon: Icons.music_note_outlined),
              space12H,
              FieldLabelWidget(label: AppStaticStrings.emailAddress.tr),
              const ProfileTextFieldWidget(hint: 'nahid@gmail.com'),
              space12H,
              FieldLabelWidget(label: AppStaticStrings.mobileNumber.tr),
              const ProfileTextFieldWidget(hint: '02-8312024'), // Skipping country picker for simplicity
              space12H,
              FieldLabelWidget(label: AppStaticStrings.deliveryAddress.tr),
              ProfileTextFieldWidget(hint: AppStaticStrings.streetAddress.tr),
              space12H,
              Row(
                children: [
                  Expanded(child: ProfileTextFieldWidget(hint: AppStaticStrings.city.tr)),
                  space12W,
                  Expanded(child: ProfileTextFieldWidget(hint: AppStaticStrings.postalCode.tr)),
                ],
              ),
              space12H,
              ProfileTextFieldWidget(hint: AppStaticStrings.stateRegion.tr),
              space12H,
              FieldLabelWidget(label: AppStaticStrings.clothingFit.tr),
              const ProfileDropdownWidget(value: 'Mens'),
              space12H,
              FieldLabelWidget(label: AppStaticStrings.tshirtSize.tr),
              const ProfileDropdownWidget(value: 'M'),
              space12H,
              FieldLabelWidget(label: AppStaticStrings.hoodieJerseySize.tr),
              const ProfileDropdownWidget(value: 'M'),
              space12H,
              FieldLabelWidget(label: AppStaticStrings.bikeModel.tr),
              const ProfileTextFieldWidget(hint: 'Yamaha Yz450f'),
              space12H,
              FieldLabelWidget(label: AppStaticStrings.year.tr),
              const ProfileTextFieldWidget(hint: '2024'),
              space12H,
              FieldLabelWidget(label: AppStaticStrings.rideType.tr),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  const ProfilePillWidget(text: 'MX', isSelected: true),
                  const ProfilePillWidget(text: 'Enduro', isSelected: true),
                  const ProfilePillWidget(text: 'Ebike', isSelected: true),
                  const ProfilePillWidget(text: 'Atv', isSelected: true),
                  const ProfilePillWidget(text: 'Adventure', isSelected: true),
                  const ProfilePillWidget(text: 'Road', isSelected: true),
                  const ProfilePillWidget(text: 'Cruiser', isSelected: true),
                  const ProfilePillWidget(text: 'Gokart', isSelected: true),
                  const ProfilePillWidget(text: 'MTB', isSelected: true),
                ],
              ),
              space12H,
              FieldLabelWidget(label: AppStaticStrings.ridingLevel.tr),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  const ProfilePillWidget(text: 'Beginner', isSelected: true),
                  const ProfilePillWidget(text: 'Intermediate', isSelected: true),
                  const ProfilePillWidget(text: 'Recreational', isSelected: true),
                ],
              ),
              space24H,
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:un4seen/src/core/core_export.dart';
import 'package:un4seen/src/core/routes/app_routes.dart';
import 'package:un4seen/src/features/bike_profiles/presentation/controllers/members_controller.dart';
import 'package:un4seen/src/features/profile/presentation/widgets/profile_menu_tile.dart';
import 'package:un4seen/src/features/profile/profile_export.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MembersController controller = Get.put(MembersController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStaticStrings.settings.tr,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppPadding.getPadding12H(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Account',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.kTextColor,
                ),
              ),
              space8H,
              ProfileMenuTile(
                title: AppStaticStrings.profileSetting.tr,
                icon: AppIcons.person,
                onTap: () {
                  if (Get.find<ProfileController>()
                              .userProfile
                              .value
                              .isProfileComplete ==
                          false ||
                      Get.find<ProfileController>()
                              .userProfile
                              .value
                              .isProfileComplete ==
                          null) {
                    context.push(AppRoutes.setupProfile);
                  } else {
                    context.push(AppRoutes.profileSetting);
                  }
                },
              ),
              ProfileMenuTile(
                title: AppStaticStrings.myBikeProfile.tr,
                icon: AppIcons.ride,
                onTap: () => context.push(AppRoutes.myBikeProfile),
              ),

              ProfileMenuTile(
                title: AppStaticStrings.members.tr,
                icon: AppIcons.groupPeople,
                onTap: () => context.push(
                      AppRoutes.members,
                      extra: {
                        'title': AppStaticStrings.all.tr,
                        'list':Get.find<MembersController>().members ,
                       'refresh': () => Get.find<MembersController>().fetchMembers(),
                      },
                    ),
              ),
              ProfileMenuTile(
                title: AppStaticStrings.referAndEarn.tr,
                icon: AppIcons.share,
                onTap: () => context.push(AppRoutes.referAndEarn),
              ),
              ProfileMenuTile(
                title: AppStaticStrings.changePassword.tr,
                iconWidget: const Icon(
                  Icons.lock_outline,
                  color: AppColors.kPrimaryColor,
                  size: 20,
                ),
                onTap: () => context.push(AppRoutes.changePassword),
              ),
              ProfileMenuTile(
                title: AppStaticStrings.aboutUs.tr,
                iconWidget: const Icon(
                  Icons.info_outline,
                  color: AppColors.kPrimaryColor,
                  size: 20,
                ),
                onTap: () => context.push(AppRoutes.aboutUs),
              ),
              ProfileMenuTile(
                title: AppStaticStrings.privacyPolicy.tr,
                iconWidget: const Icon(
                  Icons.privacy_tip_outlined,
                  color: AppColors.kPrimaryColor,
                  size: 20,
                ),
                onTap: () => context.push(AppRoutes.privacyPolicy),
              ),
              ProfileMenuTile(
                title: AppStaticStrings.termsAndConditions.tr,
                iconWidget: const Icon(
                  Icons.description_outlined,
                  color: AppColors.kPrimaryColor,
                  size: 20,
                ),
                onTap: () => context.push(AppRoutes.termsAndConditions),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

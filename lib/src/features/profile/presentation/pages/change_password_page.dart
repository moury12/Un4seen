import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/core_export.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: true,
              title: Text(
                AppStaticStrings.changePassword.tr,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            SliverPadding(
              padding: AppPadding.getPadding12(context),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  CustomTextField(
                    title: AppStaticStrings.oldPasswordHint.tr,
                    hintText: '********',
                    isPassword: true,
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: AppColors.kSecondaryTextColor,
                    ),
                  ),
                  space12H,
                  CustomTextField(
                    title: AppStaticStrings.newPassword.tr,
                    hintText: '********',
                    isPassword: true,
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: AppColors.kSecondaryTextColor,
                    ),
                  ),
                  space12H,
                  CustomTextField(
                    title: AppStaticStrings.confirmPasswordHint.tr,
                    hintText: '********',
                    isPassword: true,
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: AppColors.kSecondaryTextColor,
                    ),
                  ),
                  space24H,
                  CustomButton(
                    text: AppStaticStrings.updatePasswordBtn.tr,
                    onPressed: () {
                      // TODO: Implement update password logic
                    },
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/core_export.dart';
import '../../../../core/routes/app_routes.dart';
import '../controllers/auth_controller.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<AuthController>();
    final newPasswordCtrl = TextEditingController();
    final confirmPasswordCtrl = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.kTextColor,
            size: 20,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppPadding.getPadding12(context).copyWith(top: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // space16H,
              const CustomText(
                AppStaticStrings.resetYourPassword,
                variant: TextVariant.headlineMedium,
                fontWeight: FontWeight.bold,
              ),
              space8H,
              const CustomText(
                AppStaticStrings.createNewPassword,
                variant: TextVariant.bodyMedium,
                color: AppColors.kSecondaryTextColor,
              ),
              space24H,

              // const SizedBox(height: 16),
              CustomTextField(
                title: AppStaticStrings.newPassword,
                hintText: '••••••••',
                textEditingController: newPasswordCtrl,
                isPassword: true,
                isRequired: false,
                prefixIcon: const Icon(
                  Icons.lock_outline,
                  color: AppColors.kSecondaryTextColor,
                  size: 20,
                ),
              ),
              space8H,

              CustomTextField(
                title: AppStaticStrings.confirmPassword,
                hintText: '••••••••',
                textEditingController: confirmPasswordCtrl,
                isPassword: true,
                isRequired: false,
                prefixIcon: const Icon(
                  Icons.lock_outline,
                  color: AppColors.kSecondaryTextColor,
                  size: 20,
                ),
              ),

              space24H,

              Obx(
                () => CustomButton(
                  text: AppStaticStrings.updatePassword,
                  isLoading: ctrl.isLoading,
                  onPressed: () {
                    context.go(AppRoutes.login);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/core_export.dart';
import '../controllers/auth_controller.dart';

class ResetPasswordPage extends StatefulWidget {
  final String email;
  const ResetPasswordPage({super.key, required this.email});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final newPasswordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();

  @override
  void dispose() {
    newPasswordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<AuthController>();

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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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

                CustomTextField(
                  title: AppStaticStrings.newPassword,
                  hintText: '••••••••',
                  textEditingController: newPasswordCtrl,
                  isPassword: true,
                  isRequired: true,
                  validator: (value) =>
                      (value?.length ?? 0) >= 6 ? null : 'Min 6 characters',
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
                  isRequired: true,
                  validator: (value) => value == newPasswordCtrl.text
                      ? null
                      : 'Passwords must match',
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
                      if (_formKey.currentState!.validate()) {
                        ctrl.resetPassword(widget.email, newPasswordCtrl.text.trim());
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

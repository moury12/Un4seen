import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/core_export.dart';
import '../../../../core/routes/app_routes.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<AuthController>();
    final emailCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppPadding.getPadding12(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset(AppImages.logo, height: 60)),
              space24H,
              const CustomText(
                AppStaticStrings.welcomeBack,
                variant: TextVariant.headlineMedium,
                fontWeight: FontWeight.bold,
                color: AppColors.kPrimaryColor,
              ),
              space8H,
              const CustomText(
                AppStaticStrings.signInToContinue,
                variant: TextVariant.bodyMedium,
                color: AppColors.kSecondaryTextColor,
              ),
              space12H,

              CustomTextField(
                title: AppStaticStrings.email,
                hintText: 'name@example.com',
                textEditingController: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                onChanged: (v) => ctrl.email.value = v,
                isRequired: false,
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: AppColors.kSecondaryTextColor,
                  size: 20,
                ),
              ),
              space4H,

              CustomTextField(
                title: AppStaticStrings.password,
                hintText: '••••••••',
                textEditingController: passwordCtrl,
                isPassword: true,
                onChanged: (v) => ctrl.password.value = v,
                isRequired: false,
                prefixIcon: const Icon(
                  Icons.lock_outline,
                  color: AppColors.kSecondaryTextColor,
                  size: 20,
                ),
              ),

              space8H,
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    context.push(AppRoutes.emailConfirmation);
                  },
                  child: const CustomText(
                    AppStaticStrings.forgotPassword,
                    variant: TextVariant.titleMedium,
                    color: AppColors.kRedColor,
                  ),
                ),
              ),
              space12H,

              Obx(
                () => CustomButton(
                  text: AppStaticStrings.login,
                  isLoading: ctrl.isLoading,
                  onPressed: () {
                    context.go(AppRoutes.navigation);

                    // ctrl.login();
                  },
                ),
              ),

              space12H,

              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: AppPadding.getPadding12H(context),
                    child: const CustomText(
                      AppStaticStrings.orContinueWith,
                      variant: TextVariant.labelMedium,
                      color: AppColors.kSecondaryTextColor,
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),

              space12H,

              Center(
                child: RichText(
                  text: TextSpan(
                    text:
                        AppStaticStrings.dontHaveAccountRegister.split('?')[0] +
                        '? ',
                    style: const TextStyle(
                      color: AppColors.kSecondaryTextColor,
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(
                        text: AppStaticStrings.register,
                        style: const TextStyle(
                          color: AppColors.kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.push(AppRoutes.register);
                          },
                      ),
                    ],
                  ),
                ),
              ),

              space12H,

              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(appRadius),
                  ),
                  side: const BorderSide(color: Color(0xFFE5E7EB)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppIcons.google, width: 20, height: 20),
                    space8W,
                    const CustomText(
                      AppStaticStrings.continueWithGoogle,
                      variant: TextVariant.labelLarge,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

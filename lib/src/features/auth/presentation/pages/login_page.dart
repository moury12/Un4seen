import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/core_export.dart';
import '../../../../core/routes/app_routes.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController(
    text: kDebugMode ? 'tanzibamouri28@gmail.com' : '',
  );
  final passwordCtrl = TextEditingController(
    text: kDebugMode ? '12345678' : '',
  );

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppPadding.getPadding12(context),
          child: Form(
            key: _formKey,
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
                  isRequired: true,
                  validator: (value) {
                    if (!GetUtils.isEmail(value ?? '')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
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
                  isRequired: true,
                  validator: (value) {
                    if ((value?.length ?? 0) < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
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
                      if (_formKey.currentState!.validate()) {
                        ctrl.login(
                          emailCtrl.text.trim(),
                          passwordCtrl.text.trim(),
                        );
                      }
                    },
                  ),
                ),

                space12H,

                // Row(
                //   children: [
                //     const Expanded(child: Divider()),
                //     Padding(
                //       padding: AppPadding.getPadding12H(context),
                //       child: const CustomText(
                //         AppStaticStrings.orContinueWith,
                //         variant: TextVariant.labelMedium,
                //         color: AppColors.kSecondaryTextColor,
                //       ),
                //     ),
                //     const Expanded(child: Divider()),
                //   ],
                // ),

                // space12H,

                // OutlinedButton(
                //   onPressed: () {},
                //   style: OutlinedButton.styleFrom(
                //     minimumSize: const Size(double.infinity, 50),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(appRadius),
                //     ),
                //     side: const BorderSide(color: Color(0xFFE5E7EB)),
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       SvgPicture.asset(AppIcons.person, width: 20, height: 20),
                //       space8W,
                //       const CustomText(
                //         AppStaticStrings.continueWithGuest,
                //         variant: TextVariant.labelLarge,
                //         fontWeight: FontWeight.w600,
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

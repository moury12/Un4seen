import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/core_export.dart';
import '../../../../core/routes/app_routes.dart';
import '../controllers/auth_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _agreedToTerms = false;
  bool _showReferral = false;

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<AuthController>();
    final nameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();
    final confirmPasswordCtrl = TextEditingController();
    final referralCtrl = TextEditingController();

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
        // maintainBottomViewPadding: true,
        child: SingleChildScrollView(
          padding: AppPadding.getPadding12(context).copyWith(top: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                AppStaticStrings.createAccount,
                variant: TextVariant.headlineMedium,
                fontWeight: FontWeight.bold,
                color: AppColors.kPrimaryColor,
              ),
              space4H,
              const CustomText(
                AppStaticStrings.joinSyndicate,
                variant: TextVariant.bodyMedium,
                color: AppColors.kSecondaryTextColor,
              ),
              space12H,

              CustomTextField(
                title: AppStaticStrings.fullName,
                hintText: 'Sarah',
                textEditingController: nameCtrl,
                isRequired: false,
                prefixIcon: const Icon(
                  Icons.person_outline,
                  color: AppColors.kSecondaryTextColor,
                  size: 20,
                ),
              ),
              space8H,

              CustomTextField(
                title: AppStaticStrings.email,
                hintText: 'name@example.com',
                textEditingController: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                isRequired: false,
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: AppColors.kSecondaryTextColor,
                  size: 20,
                ),
              ),
              space8H,

              CustomTextField(
                title: AppStaticStrings.password,
                hintText: '••••••••',
                textEditingController: passwordCtrl,
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
              space8H,

              GestureDetector(
                onTap: () {
                  setState(() {
                    _showReferral = !_showReferral;
                  });
                },
                child: Row(
                  children: [
                    const CustomText(
                      AppStaticStrings.haveReferralCode,
                      variant: TextVariant.labelMedium,
                      color: AppColors.kPrimaryColor,
                    ),
                    Icon(
                      _showReferral
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: AppColors.kPrimaryColor,
                      size: 16,
                    ),
                  ],
                ),
              ),
              if (_showReferral) ...[
                space8H,
                CustomTextField(
                  hintText: AppStaticStrings.enterCode,
                  textEditingController: referralCtrl,
                  isRequired: false,
                ),
              ],

              space8H,

              Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: _agreedToTerms,
                      activeColor: AppColors.kPrimaryColor,
                      onChanged: (val) {
                        setState(() {
                          _agreedToTerms = val ?? false;
                        });
                      },
                    ),
                  ),
                  space8W,
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'I agree to ',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: AppColors.kSecondaryTextColor,
                                ),
                          ),
                          TextSpan(
                            text: 'Terms & Conditions',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppColors.kPrimaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              space12H,

              Obx(
                () => CustomButton(
                  text: AppStaticStrings.register,
                  isLoading: ctrl.isLoading,
                  onPressed: () {
                    context.push(AppRoutes.otpVerification);
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
                        AppStaticStrings.alreadyHaveAccountLogin.split('?')[0] +
                        '? ',
                    style: const TextStyle(
                      color: AppColors.kSecondaryTextColor,
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(
                        text: AppStaticStrings.login,
                        style: const TextStyle(
                          color: AppColors.kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.pop();
                          },
                      ),
                    ],
                  ),
                ),
              ),

              space8H,

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

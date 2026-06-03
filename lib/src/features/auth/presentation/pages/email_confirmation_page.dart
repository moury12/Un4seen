import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/core_export.dart';
import '../controllers/auth_controller.dart';

class EmailConfirmationPage extends StatefulWidget {
  const EmailConfirmationPage({super.key});

  @override
  State<EmailConfirmationPage> createState() => _EmailConfirmationPageState();
}

class _EmailConfirmationPageState extends State<EmailConfirmationPage> {
  final _formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();
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
                  AppStaticStrings.emailConfirmation,
                  variant: TextVariant.headlineMedium,
                  fontWeight: FontWeight.bold,
                ),
                space8H,
                const CustomText(
                  AppStaticStrings.enterEmailVerification,
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
                  validator: (value) =>
                      GetUtils.isEmail(value ?? '') ? null : 'Enter a valid email',
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: AppColors.kSecondaryTextColor,
                    size: 20,
                  ),
                ),

                space12H,
                Obx(
                  () => CustomButton(
                    text: AppStaticStrings.sendVerificationCode,
                    isLoading: ctrl.isLoading,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ctrl.forgotPassword(emailCtrl.text.trim());
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

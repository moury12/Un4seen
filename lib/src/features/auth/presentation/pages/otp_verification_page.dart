import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/core_export.dart';
import '../controllers/auth_controller.dart';

class OtpVerificationPage extends StatefulWidget {
  final String email;
  final bool isForResetPass;
  const OtpVerificationPage({
    super.key,
    required this.email,
    required this.isForResetPass,
  });

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AuthController>().startResendTimer();
    });
  }

  @override
  void dispose() {
    for (var ctrl in _controllers) {
      ctrl.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              space12H,
              const CustomText(
                AppStaticStrings.otpVerification,
                variant: TextVariant.headlineMedium,
                fontWeight: FontWeight.bold,
              ),
              space8H,
              const CustomText(
                AppStaticStrings.enter6DigitCode,
                variant: TextVariant.bodyMedium,
                color: AppColors.kSecondaryTextColor,
                textAlign: TextAlign.center,
              ),
              space12H,

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 48,
                    height: 56,
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,

                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.kPrimaryColor,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        contentPadding: EdgeInsets.zero,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFFE5E7EB),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: AppColors.kPrimaryColor,
                            width: 2,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 5) {
                          _focusNodes[index + 1].requestFocus();
                        } else if (value.isEmpty && index > 0) {
                          _focusNodes[index - 1].requestFocus();
                        }
                      },
                    ),
                  );
                }),
              ),

              space24H,
              Obx(() {
                final seconds = ctrl.resendSeconds.value;
                final minutesStr = (seconds ~/ 60).toString().padLeft(2, '0');
                final secondsStr = (seconds % 60).toString().padLeft(2, '0');

                return RichText(
                  text: TextSpan(
                    text: '${AppStaticStrings.resendCode.tr} ',
                    style: TextStyle(
                      color: ctrl.canResend.value
                          ? AppColors.kPrimaryColor
                          : AppColors.kSecondaryTextColor,
                      fontSize: 14,
                      fontWeight: ctrl.canResend.value
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    children: [
                      if (!ctrl.canResend.value)
                        TextSpan(
                          text: '$minutesStr:$secondsStr',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                    ],
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        if (ctrl.canResend.value) {
                          ctrl.resendOtp(widget.email);
                        }
                      },
                  ),
                );
              }),

              space12H,

              Obx(
                () => CustomButton(
                  text: AppStaticStrings.verifyCode,
                  isLoading: ctrl.isLoading,
                  onPressed: () {
                    String otp = _controllers.map((e) => e.text).join();
                    ctrl.verifyOtp(widget.email, otp, widget.isForResetPass);
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

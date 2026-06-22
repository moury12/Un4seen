// lib/src/features/profile/presentation/pages/change_password_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/core_export.dart';
import '../controllers/profile_controller.dart'; // Make sure this path targets your profile controller

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Locate our Profile Controller instance
  final ProfileController _profileController = Get.find<ProfileController>();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _profileController.changePassword(
        oldPassword: _oldPasswordController.text.trim(),
        newPassword: _newPasswordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
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
                      textEditingController: _oldPasswordController,
                      title: AppStaticStrings.oldPasswordHint.tr,
                      hintText: '********',
                      isPassword: true,
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: AppColors.kSecondaryTextColor,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your old password';
                        }
                        return null;
                      },
                    ),
                    space12H,
                    CustomTextField(
                      textEditingController: _newPasswordController,
                      title: AppStaticStrings.newPassword.tr,
                      hintText: '********',
                      isPassword: true,
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: AppColors.kSecondaryTextColor,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your new password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    space12H,
                    CustomTextField(
                      textEditingController: _confirmPasswordController,
                      title: AppStaticStrings.confirmPasswordHint.tr,
                      hintText: '********',
                      isPassword: true,
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: AppColors.kSecondaryTextColor,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your new password';
                        }
                        if (value != _newPasswordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    space24H,

                    // Reactive loading UI button configuration
                    Obx(() {
                      final bool isLoading =
                          _profileController.isPasswordLoading.value;
                      return CustomButton(
                        isLoading: isLoading,
                        text: AppStaticStrings.updatePasswordBtn.tr,
                        onPressed: _submitForm,
                      );
                    }),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// lib/src/features/profile/presentation/pages/privacy_policy_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart'; // Import HTML view renderer
import 'package:get/get.dart';
import '../../../../core/core_export.dart';
import '../controllers/app_content_controller.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppContentController());

    WidgetsBinding.instance.addPostFrameCallback((_) => controller.fetchPrivacyPolicy());

    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          final hasData = controller.privacyPolicy.value != null;
          
          if (controller.isPrivacyLoading.value && !hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: () => controller.fetchPrivacyPolicy(),
            color: AppColors.kPrimaryColor,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  title: Text(
                    AppStaticStrings.privacyPolicy.tr,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  centerTitle: true,
                ),
                if (!hasData && !controller.isPrivacyLoading.value)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: Text("No Policy data found".tr, style: const TextStyle(color: Colors.grey))),
                  )
                else
                  SliverPadding(
                    padding: AppPadding.getPadding12(context),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        CustomText(
                          AppStaticStrings.privacyPolicy.tr,
                          variant: TextVariant.headlineSmall,
                          fontWeight: FontWeight.bold,
                        ),
                        space12H,
                        // Render HTML tags directly into native flutter canvas widgets
                        HtmlWidget(
                          controller.privacyPolicy.value?.content ?? '',
                          textStyle: TextStyle(
                            color: AppColors.kSecondaryTextColor,
                            fontSize: 14,
                          ),
                        ),
                      ]),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
// lib/src/features/profile/presentation/pages/terms_and_conditions_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import '../../../../core/core_export.dart';
import '../controllers/app_content_controller.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppContentController());

    WidgetsBinding.instance.addPostFrameCallback((_) => controller.fetchTermsCondition());

    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          final hasData = controller.termsCondition.value != null;

          if (controller.isTermsLoading.value && !hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: () => controller.fetchTermsCondition(),
            color: AppColors.kPrimaryColor,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  title: Text(
                    AppStaticStrings.termsAndConditions.tr,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  centerTitle: true,
                ),
                if (!hasData && !controller.isTermsLoading.value)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: Text("No Terms data found".tr, style: const TextStyle(color: Colors.grey))),
                  )
                else
                  SliverPadding(
                    padding: AppPadding.getPadding12(context),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        CustomText(
                          AppStaticStrings.termsAndConditions.tr,
                          variant: TextVariant.headlineSmall,
                          fontWeight: FontWeight.bold,
                        ),
                        space12H,
                        HtmlWidget(
                          controller.termsCondition.value?.content ?? '',
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
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:un4seen/src/features/bike_profiles/bike_profiles_export.dart';
import '../../../../core/core_export.dart';
import '../widgets/image_upload_section.dart';

class AddNewBikePage extends StatelessWidget {
  const AddNewBikePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Custom colors based on your image
    final Color scaffoldBg = AppColors.kPrimaryDarkColor3;
    const Color borderColor = AppColors.kPrimaryDarkColor; // Light Blue Border
    const Color noteBoxBg =
        AppColors.kPrimaryDarkColor2; // Lighter Blue for Note

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            // --- HEADER SECTION ---
            Padding(
              padding: AppPadding.getPadding12(context),
              child: Row(
                children: [
                  const Icon(
                    Icons.directions_bike,
                    color: Colors.white,
                    size: 24,
                  ),
                  space12W,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          AppStaticStrings.addNewBike.tr,
                          variant: TextVariant.titleLarge,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        CustomText(
                          AppStaticStrings
                              .yourCurrentBikeWillBeMovedToRetiredBikes
                              .tr,
                          variant: TextVariant.labelSmall,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ],
                    ),
                  ),
                  // Circular Close Button
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.kPrimaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: borderColor, height: 1),

            // --- CONTENT SECTION ---
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: ImageUploadSection()),

                    _buildLabeledField(
                      "Year",
                      "e.g., 2024",
                      borderColor,
                      context,
                    ),
                    _buildLabeledField(
                      "Make",
                      "e.g., Honda, Kawasaki, GT",
                      borderColor,
                      context,
                    ),
                    _buildLabeledField(
                      "Model",
                      "e.g., CRF250R, KLX140",
                      borderColor,
                      context,
                    ),
                    _buildLabeledField(
                      "Bike Type",
                      "type here..",
                      borderColor,
                      context,
                    ),
                    _buildLabeledField(
                      "Color",
                      "e.g., Red, Matte Black, Lime Green",
                      borderColor,
                      context,
                    ),

                    CustomText(
                      "Build Note",
                      fontWeight: FontWeight.bold,
                      variant: TextVariant.titleMedium,
                      color: Colors.white,
                    ),

                    _buildLabeledField(
                      "Title",
                      "e.g., Red, Matte Black, Lime Green",
                      borderColor,
                      context,
                    ),
                    _buildLabeledField(
                      "Point 1",
                      "e.g., Red, Matte Black, Lime Green",
                      borderColor,
                      context,
                    ),

                    const Center(
                      child: Icon(Icons.add, color: Colors.white, size: 30),
                    ),

                    // Outlined Add Build Note Button
                    CustomButton(
                      text: "Add Build Note",
                      onPressed: () {},
                      isOutlined: true,
                      icon: Icons.add,
                      textColor: Colors.white,
                      borderColor: borderColor,
                    ),

                    // --- BLUE INFO NOTE BOX ---
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: noteBoxBg.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: borderColor),
                      ),
                      child: CustomText(
                        "Note: Your current bike will be automatically moved to the retired bikes section. You can add upgrades to this bike after creating it.",
                        color: Colors.white,
                        variant: TextVariant.labelSmall,
                      ),
                    ),

                    // --- MAIN ADD BIKE BUTTON ---
                    CustomButton(
                      text: "Add Bike",
                      onPressed: () {},
                      icon: Icons.add,
                      backgroundColor: AppColors.kPrimaryColor,
                    ),
                    space24H,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper to build the labeled fields with that specific blue border
  Widget _buildLabeledField(
    String label,
    String hint,
    Color borderColor,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          hintText: hint,
          title: label,
          titleStyle: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: Colors.white),
          fillColor: Colors.transparent,
          hintStyle: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(color: Colors.white),
          // If your CustomTextField doesn't support direct border color,
          // wrap it in a Theme or pass a decoration.
        ),
      ],
    );
  }
}

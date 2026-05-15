import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/core_export.dart';

class ShareIdeaDialog extends StatefulWidget {
  const ShareIdeaDialog({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const ShareIdeaDialog(),
    );
  }

  @override
  State<ShareIdeaDialog> createState() => _ShareIdeaDialogState();
}

class _ShareIdeaDialogState extends State<ShareIdeaDialog> {
  String? selectedCategory;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  final List<String> categories = [
    'Product Ideas',
    'Design Styles',
    'General Feedback',
    'I have a random idea to share',
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.kPrimaryDarkColor3,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.kPrimaryColor, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.lightbulb_outline, color: Colors.white),
                        space8W,
                        CustomText(
                          AppStaticStrings.shareYourIdea.tr,
                          variant: TextVariant.titleLarge,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    CustomText(
                      AppStaticStrings.yourIdeasMatter.tr,
                      variant: TextVariant.bodySmall,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.white),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.kPrimaryColor,
                    shape: const CircleBorder(),
                  ),
                ),
              ],
            ),
            const Divider(color: AppColors.kPrimaryColor, height: 24),
            CustomText(
              AppStaticStrings.category.tr,
              variant: TextVariant.labelMedium,
              color: Colors.white,
            ),
            space8H,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.kPrimaryColor),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedCategory,
                  hint: CustomText(
                    AppStaticStrings.selectIdeaCategory.tr,
                    color: AppColors.kTextColor.withValues(alpha: 0.5),
                  ),
                  isExpanded: true,
                  items: categories.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: CustomText(value, color: AppColors.kTextColor),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedCategory = val;
                    });
                  },
                ),
              ),
            ),
            space16H,
            CustomTextField(
              title: AppStaticStrings.title.tr,
              hintText: AppStaticStrings.whatsItAbout.tr,
              textEditingController: titleController,
              fillColor: Colors.white,
              titleStyle: const TextStyle(color: Colors.white),
            ),
            space16H,
            CustomTextField(
              title: AppStaticStrings.aboutUs.tr, // Reusing about text or just "Description"
              hintText: AppStaticStrings.tellUsMoreAboutIdea.tr,
              textEditingController: descController,
              maxLines: 4,
              fillColor: Colors.white,
              titleStyle: const TextStyle(color: Colors.white),
            ),
            space24H,
            CustomButton(
              text: AppStaticStrings.submitIdea.tr,
              onPressed: () {
                // Handle submission
                Navigator.pop(context);
              },
              backgroundColor: AppColors.kPrimaryColor,
            ),
            space12H,
            Center(
              child: CustomText(
                AppStaticStrings.adminCanPublishDesc.tr,
                variant: TextVariant.labelSmall,
                color: Colors.white.withValues(alpha: 0.7),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

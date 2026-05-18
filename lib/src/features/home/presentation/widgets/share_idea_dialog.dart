import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/core_export.dart';

class ShareIdeaDialog extends StatefulWidget {
  const ShareIdeaDialog({super.key});

  static void show(BuildContext context) {
    showDialog(context: context, builder: (context) => const ShareIdeaDialog());
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
                        const Icon(
                          Icons.lightbulb_outline,
                          color: Colors.white,
                        ),
                        space8W,
                        CustomText(
                          AppStaticStrings.shareYourIdea.tr,
                          variant: TextVariant.titleLarge,
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    CustomText(
                      AppStaticStrings.yourIdeasMatter.tr,
                      variant: TextVariant.bodySmall,
                      fontSize: 12,
                      color: Colors.white,
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
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            space8H,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.kPrimaryColor),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  style: const TextStyle(color: Colors.white),
                  dropdownColor: AppColors.kPrimaryDarkColor3,
                  value: selectedCategory,

                  hint: CustomText(
                    AppStaticStrings.selectIdeaCategory.tr,
                    color: Colors.white,
                  ),

                  isExpanded: true,
                  items: categories.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: CustomText(value, color: Colors.white),
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
            space8H,
            CustomTextField(
              title: AppStaticStrings.title.tr,
              hintText: AppStaticStrings.whatsItAbout.tr,
              textEditingController: titleController,
              fillColor: Colors.transparent,
              inputTextStyle: const TextStyle(
                fontSize: 13,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),

              titleStyle: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              hintStyle: const TextStyle(fontSize: 12, color: Colors.white),
            ),
            space8H,
            CustomTextField(
              title: AppStaticStrings.aboutUs.tr,
              inputTextStyle: const TextStyle(
                fontSize: 13,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              // Reusing about text or just "Description"
              hintText: AppStaticStrings.tellUsMoreAboutIdea.tr,
              textEditingController: descController,
              maxLines: 4,
              fillColor: Colors.transparent,
              titleStyle: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              hintStyle: const TextStyle(fontSize: 12, color: Colors.white),
            ),
            space8H,
            CustomButton(
              text: AppStaticStrings.submitIdea.tr,
              onPressed: () {
                // Handle submission
                Navigator.pop(context);
              },
              backgroundColor: AppColors.kPrimaryColor,
            ),
            space8H,
            Center(
              child: CustomText(
                AppStaticStrings.adminCanPublishDesc.tr,
                variant: TextVariant.labelSmall,
                fontSize: 12,
                color: Colors.white,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

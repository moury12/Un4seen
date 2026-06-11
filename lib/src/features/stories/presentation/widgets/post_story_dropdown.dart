import 'package:flutter/material.dart';
import 'package:un4seen/src/core/core_export.dart';

class PostStoryDropdown extends StatelessWidget {
  final String title;
  final String hintText;
  final List<String> options;
  final String selectedValue;
  final Function(String) onSelected;

  const PostStoryDropdown({
    super.key,
    required this.title,
    required this.hintText,
    required this.options,
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    const Color borderColor = AppColors.kPrimaryDarkColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title,
          fontWeight: FontWeight.bold,
          variant: TextVariant.titleMedium,
          color: Colors.white,
        ),
        space8H,
        GestureDetector(
          onTap: () => _showOptionsBottomSheet(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderColor),
              color: Colors.transparent,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  selectedValue.isEmpty ? hintText : selectedValue,
                  color: selectedValue.isEmpty
                      ? Colors.white.withValues(alpha: 0.5)
                      : Colors.white,
                  variant: TextVariant.bodyMedium,
                ),
                const Icon(Icons.keyboard_arrow_down, color: Colors.white),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showOptionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: AppColors.kPrimaryDarkColor3,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            space16H,
            CustomText(
              title,
              variant: TextVariant.titleLarge,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            space16H,
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: options.length,
                separatorBuilder: (context, index) =>
                    const Divider(color: Colors.white12),
                itemBuilder: (context, index) {
                  final option = options[index];
                  return ListTile(
                    onTap: () {
                      onSelected(option);
                      Navigator.pop(context);
                    },
                    title: CustomText(
                      option,
                      color: Colors.white,
                      variant: TextVariant.bodyLarge,
                    ),
                    trailing: selectedValue == option
                        ? const Icon(
                            Icons.check_circle,
                            color: AppColors.kPrimaryColor,
                          )
                        : null,
                  );
                },
              ),
            ),
            space16H,
          ],
        ),
      ),
    );
  }
}

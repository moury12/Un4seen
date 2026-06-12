import '../../../../src_export.dart';
import '../controllers/story_controller.dart';

class CategorySelectionSheet extends StatelessWidget {
  const CategorySelectionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StoryController>();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.kPrimaryDarkColor3,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2))),
          space16H,
          CustomText("Select Category".tr, variant: TextVariant.titleLarge, color: Colors.white, fontWeight: FontWeight.bold),
          space16H,
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: controller.categories.length,
              separatorBuilder: (context, index) => const Divider(color: Colors.white12),
              itemBuilder: (context, index) {
                final cat = controller.categories[index];
                return Obx(() => ListTile(
                  onTap: () {
                    controller.setCategory(cat);
                    Navigator.pop(context);
                  },
                  title: CustomText(cat.tr, color: Colors.white),
                  trailing: controller.selectedCategory.value == cat
                      ? const Icon(Icons.check_circle, color: AppColors.kPrimaryColor)
                      : null,
                ));
              },
            ),
          ),
          space24H,
        ],
      ),
    );
  }
}
import '../../../../src_export.dart';

class EntriesGalleryPage extends StatelessWidget {
  const EntriesGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CompetitionsController>();

    return Scaffold(
      appBar: AppBar(title: Text(AppStaticStrings.entriesGallery.tr)),
      body: Obx(() {
        if (controller.isGalleryLoading.value) {
          return _buildShimmer(context);
        }

        if (controller.entries.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.image_not_supported_outlined, size: 64, color: AppColors.kPrimaryColor.withValues(alpha: .4)),
                space16H,
                CustomText('No entries yet', color: AppColors.kSecondaryTextColor),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: AppPadding.getPadding12H(context),
          itemCount: controller.entries.length,
          itemBuilder: (context, index) {
            final entry = controller.entries[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: AppPadding.getPadding12(context),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.kPrimaryColor, AppColors.kPrimaryDarkColor2],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                spacing: 6,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Author row
                  Row(
                    spacing: 8,
                    children: [
                      CircleAvatar(
                        backgroundImage: entry.user.image.isNotEmpty
                            ? NetworkImage(entry.user.image)
                            : const NetworkImage('https://i.pravatar.cc/150'),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              entry.user.fullName,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            CustomText(
                              entry.user.memberNumber.isNotEmpty ? '#${entry.user.memberNumber}' : '',
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Design name
                  CustomText(
                    entry.designName,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),

                  // Design image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CustomNetworkImage(
                      imageUrl: entry.image,
                      width: double.infinity,
                      height: 200,
                    ),
                  ),

                  // Heart row
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: AppPadding.getPadding8(context),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () => controller.toggleHeart(index),
                          child: Icon(
                            entry.isHearted ? Icons.favorite : Icons.favorite_outline,
                            color: entry.isHearted ? Colors.red : AppColors.kPrimaryColor,
                            size: 20,
                          ),
                        ),
                        space8W,
                        CustomText(
                          '${entry.heartCount}',
                          color: AppColors.kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildShimmer(BuildContext context) {
    return ListView.builder(
      padding: AppPadding.getPadding12H(context),
      itemCount: 4,
      itemBuilder: (_, __) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        height: 320,
        decoration: BoxDecoration(
          color: AppColors.kPrimaryDarkColor2,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  const CircleAvatar(radius: 20, backgroundColor: AppColors.kPrimaryDarkColor3),
                  space8W,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 14, width: 120, color: AppColors.kPrimaryDarkColor3),
                      space4H,
                      Container(height: 10, width: 80, color: AppColors.kPrimaryDarkColor3),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(color: AppColors.kPrimaryDarkColor3),
            ),
          ],
        ),
      ),
    );
  }
}
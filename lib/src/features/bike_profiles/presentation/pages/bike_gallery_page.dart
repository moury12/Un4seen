import '../../../../src_export.dart';

class BikeGalleryPage extends StatelessWidget {
  final String bikeId;
  const BikeGalleryPage({super.key, required this.bikeId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BikeProfilesController>();

    // Initial fetch
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => controller.fetchGallery(bikeId),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStaticStrings.bikeGallery.tr,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => controller.addImagesToGallery(bikeId),
            icon: const Icon(Icons.add_a_photo, color: AppColors.kPrimaryColor),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => controller.fetchGallery(bikeId),
          child: Obx(() {
            return CustomScrollView(
              // This physics ensures the pull-to-refresh always works
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              slivers: [
                // 1. Loading State
                if (controller.isGalleryLoading.value &&
                    controller.bikeGallery.isEmpty)
                  const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  )
                // 2. Empty State
                else if (controller.bikeGallery.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_outlined,
                            size: 48,
                            color: AppColors.kSecondaryTextColor.withOpacity(
                              0.5,
                            ),
                          ),
                          space12H,
                          CustomText(
                            "No photos in gallery".tr,
                            variant: TextVariant.bodyMedium,
                            color: AppColors.kSecondaryTextColor,
                          ),
                        ],
                      ),
                    ),
                  )
                // 3. Grid Content
                else
                  SliverPadding(
                    padding: AppPadding.getPadding12(context),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1.0,
                          ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final imageUrl = controller.bikeGallery[index];
                        return _GalleryImageItem(
                          imageUrl: imageUrl,
                          onDelete: () => _showDeleteConfirmation(
                            context,
                            controller,
                            imageUrl,
                          ),
                        );
                      }, childCount: controller.bikeGallery.length),
                    ),
                  ),

                // Bottom Spacing
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
              ],
            );
          }),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    BikeProfilesController controller,
    String url,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.kPrimaryDarkColor3,
        title: CustomText(
          "Remove Image?".tr,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        content: CustomText(
          "Are you sure you want to delete this photo from your gallery?".tr,
          color: Colors.white70,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: CustomText(AppStaticStrings.cancel.tr, color: Colors.white),
          ),
          CustomButton(
            text: AppStaticStrings.delete.tr,
            isExpanding: false,
            backgroundColor: AppColors.kRedColor,
            onPressed: () {
              Navigator.pop(context);
              controller.removeImageFromGallery(bikeId, url);
            },
          ),
        ],
      ),
    );
  }
}

// Internal Helper Widget for Gallery Item
class _GalleryImageItem extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onDelete;

  const _GalleryImageItem({required this.imageUrl, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CustomNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            isImagePreview: true,
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: onDelete,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.delete_outline,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

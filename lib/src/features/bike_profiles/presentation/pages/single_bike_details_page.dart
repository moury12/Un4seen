import 'package:un4seen/src/core/widgets/gradient_container.dart';
import 'package:un4seen/src/features/bike_profiles/presentation/widgets/bike_details_container.dart';

import '../../../../src_export.dart';
import '../widgets/upgrade_category_widget.dart';

class SingleBikeDetailsPage extends StatelessWidget {
  final String bikeId;
  const SingleBikeDetailsPage({super.key, required this.bikeId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BikeProfilesController>();

    // Auto-fetch when entering
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => controller.fetchSingleBike(bikeId),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bike Details".tr,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final bike = controller.singleBikeDetails.value;
        if (bike == null) {
          return Center(child: Text("Bike not found".tr));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CustomNetworkImage(
                  imageUrl: bike.image,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              BikeDetailsContainerWidget(bike: bike),
              GradientContainer(
                onTap: () =>
                    context.push(AppRoutes.bikeGallery, extra:  bike.id),
                padding: AppPadding.getPadding12(context),
                child: Row(
                  spacing: 8,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    space8H,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            AppStaticStrings.myBikeGallery.tr,
                            color: Colors.white,
                            variant: TextVariant.titleMedium,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomText(
                            AppStaticStrings.viewAllPhotosOfThisBike.tr,
                            color: Colors.white.withValues(alpha: 0.8),
                            variant: TextVariant.labelMedium,
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 16,
                    ),
                  ],
                ),
              ),

              CustomText(
                "Upgrades".tr,
                variant: TextVariant.titleLarge,
                fontWeight: FontWeight.bold,
              ),

              ...bike.upgrades.map(
                (u) => UpgradeCategoryWidget(
                  title: u.title,
                  icon: Icons.build,
                  items: u.items,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

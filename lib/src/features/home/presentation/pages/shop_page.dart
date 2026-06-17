import 'package:un4seen/src/features/profile/presentation/controllers/shop_controller.dart';

import '../../../../src_export.dart';
import '../widgets/shop_product_card.dart';
class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ShopController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppStaticStrings.shopTitle.tr),
        actions: [Image.asset(AppIcons.logo, height: 44), space12W],
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.fetchProducts(isRefresh: true),
        child: Obx(() {
          if (controller.isLoading.value && controller.products.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                controller.loadMore();
              }
              return false;
            },
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Center(
                      child: CustomText(
                        AppStaticStrings.exclusiveUn4seenProducts.tr,
                        color: AppColors.kSecondaryTextColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: AppPadding.getPadding12H(context),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.8,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => ShopProductCard(product: controller.products[index]),
                      childCount: controller.products.length,
                    ),
                  ),
                ),
                if (controller.isMoreLoading.value)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
                const SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            ),
          );
        }),
      ),
    );
  }
}
import 'package:un4seen/src/core/utils/url_launcher_utils.dart';
import '../../../../src_export.dart';
import '../../data/models/shop_product_model.dart';

class ShopProductCard extends StatelessWidget {
  final ProductModel product;

  const ShopProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => UrlLauncherUtils.launchExternalUrl(product.productUrl),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.kPrimaryColor, AppColors.kPrimaryDarkColor2],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  CustomNetworkImage(
                    imageUrl: product.image,
                    width: double.infinity,
                    radius: 12,
                  ),
                  if (product.discountPercentage != null)
                    Positioned(
                      top: 8, right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: AppColors.kPrimaryColor, borderRadius: BorderRadius.circular(4)),
                        child: CustomText("-${product.discountPercentage}%", color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  Positioned(
                    bottom: 8, left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(4)),
                      child: CustomText(product.category, color: Colors.white, fontSize: 8),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(product.title, color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13, maxLines: 2),
                  space4H,
                  Row(
                    children: [
                      CustomText("\$${product.price}nzd", color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                      if (product.compareAtPrice != null) ...[
                        space4W,
                        CustomText("\$${product.compareAtPrice}", color: Colors.white60, fontSize: 10, decoration: TextDecoration.lineThrough),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
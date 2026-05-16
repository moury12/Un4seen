import '../../../../src_export.dart';
import '../widgets/shop_product_card.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:
        Text(AppStaticStrings.shopTitle.tr,),actions: [
          Image.asset(AppIcons.logo, height:44),
          space12W
        ],
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12H(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: CustomText(
              AppStaticStrings.exclusiveUn4seenProducts.tr, color: AppColors.kSecondaryTextColor, fontSize: 12)),
            space8H,
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.8,
              padding: EdgeInsets.zero,
              children: [
                ShopProductCard(title: AppStaticStrings.backpack.tr, category: "Gear", price: "\$49.99nzd", oldPrice: "\$99.99", image: "https://images.unsplash.com/photo-1553062407-98eeb64c6a62?q=80&w=200"),
                ShopProductCard(title: AppStaticStrings.hubstickers.tr, category: "Decals", price: "\$16.99nzd", oldPrice: "\$19.99", image: "https://images.unsplash.com/photo-1444491741275-3747c53c99b4?q=80&w=200"),
                ShopProductCard(title: "Un4seen CMG Tshirt", category: "Apparel", price: "\$44.99nzd", oldPrice: "\$59.99", image: "https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?q=80&w=200"),
                ShopProductCard(title: AppStaticStrings.forkWraps.tr, category: "Decals", price: "\$29.99nzd", oldPrice: "\$39.99", image: "https://images.unsplash.com/photo-1558981403-c5f9899a28bc?q=80&w=200"),
              ],
            ),
        space12H,
            Row(
              spacing: 8,
              children: [
                const Icon(Icons.shopping_bag_outlined, color: AppColors.kPrimaryColor),
                CustomText(AppStaticStrings.findPerfectKit.tr, fontWeight: FontWeight.bold, fontSize: 16),
                // const Spacer(),
                Container(
                  padding: AppPadding.getPadding4(context),
                  decoration: BoxDecoration(
                    color: AppColors.kPrimaryColor,shape: BoxShape.circle,
                    
                ),
                  child: CustomText("Go", fontWeight: FontWeight.bold, fontSize: 14,color: AppColors.kWhiteTextColor,),
                )
                // CustomButton(
                //   text: "Go",
                //   onPressed: () {},
                //   isExpanding: false,
                //   borderRadius: 8,
                //   textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 10),
                // ),
              ],
            ),
            space8H,
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(20, (index) => Container(
                width: 80,
                height: 60,
                decoration: BoxDecoration(border: Border.all(color: Colors.black12), borderRadius: BorderRadius.circular(4)),
                child: CustomNetworkImage(imageUrl:   "https://images.unsplash.com/photo-1558981403-c5f9899a28bc?q=80&w=200", 
          radius: 4),
              )),
            ),
            space8H,
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(gradient: LinearGradient(colors: [
        AppColors.kPrimaryColor,
        AppColors.kPrimaryDarkColor2
       ],
       begin: Alignment.topCenter,
       end: Alignment.bottomCenter
      ),  borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [const Icon(Icons.info_outline, color: Colors.white), space8W, CustomText(AppStaticStrings.howItWorks.tr, color: Colors.white, fontWeight: FontWeight.bold)]),
                  space8H,
                  _bullet(AppStaticStrings.shopDesc1.tr),
                  _bullet(AppStaticStrings.shopDesc2.tr),
                  _bullet(AppStaticStrings.shopDesc3.tr),
                ],
              ),
            ),
            space8H,
          ],
        ),
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 6, color: Colors.white),
          space12W,
          Expanded(child: CustomText(text, color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}

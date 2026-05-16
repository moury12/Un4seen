import '../../../../src_export.dart';

class ShopProductCard extends StatelessWidget {
  final String title;
  final String category;
  final String price;
  final String oldPrice;
  final String image;

  const ShopProductCard({
    super.key,
    required this.title,
    required this.category,
    required this.price,
    required this.oldPrice,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
       gradient: LinearGradient(colors: [
        AppColors.kPrimaryColor,
        AppColors.kPrimaryDarkColor2
       ],
       begin: Alignment.topCenter,
       end: Alignment.bottomCenter
      ), 
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                CustomNetworkImage(imageUrl: image, width: double.infinity, radius: 12),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: AppColors.kPrimaryColor, borderRadius: BorderRadius.circular(4)),
                    child: const CustomText("-20%", color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(4)),
                    child: CustomText(category, color: Colors.white, fontSize: 12),
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
                CustomText(title, color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14, maxLines: 2),
                space4H,
                Row(
                  children: [
                    CustomText(price, color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                    space4W,
                    CustomText(oldPrice, color: Colors.white, fontSize: 12, decoration: TextDecoration.lineThrough),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

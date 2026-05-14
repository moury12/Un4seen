import '../../../../src_export.dart';

class VoteEntryItemWidget extends StatelessWidget {
  final String title;
  final String author;
  final String synId;
  final String likes;
  final String image;

  const VoteEntryItemWidget({
    super.key,
    required this.title,
    required this.author,
    required this.synId,
    required this.likes,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(appRadius),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CustomNetworkImage(imageUrl: image, height: 40, width: 60),
          ),
          space8W,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(title, fontWeight: FontWeight.bold, color: Colors.white, fontSize: 13),
                CustomText("by $author • $synId", variant: TextVariant.labelSmall, color: Colors.white70),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.favorite, color: AppColors.kPrimaryColor, size: 14),
                space4W,
                CustomText(likes, color: AppColors.kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

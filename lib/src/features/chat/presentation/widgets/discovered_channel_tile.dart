import '../../../../src_export.dart';
import '../../data/models/search_conversation_model.dart';

class DiscoveredChannelTile extends StatelessWidget {
  final DiscoveredChannelModel model;
  const DiscoveredChannelTile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.kPrimaryColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.tag, color: AppColors.kPrimaryColor),
          space12W,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(model.name, fontWeight: FontWeight.bold),
                CustomText("${model.onlineCount} online", fontSize: 11, color: AppColors.kSecondaryTextColor),
              ],
            ),
          ),
          Container(
            padding: AppPadding.getPadding6(context),
            decoration: BoxDecoration(
              color: model.isJoined ? Colors.grey : AppColors.kPrimaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: CustomText(model.isJoined ? "Joined" : (model.isPending ? "Pending" : "Join"), fontSize: 12, color: Colors.white),
          )
       
          
        ],
      ),
    );
  }
}
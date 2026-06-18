import 'package:un4seen/src/features/chat/data/models/search_conversation_model.dart';

import '../../../../src_export.dart';

class RiderSearchTile extends StatelessWidget {
  final RiderSearchResultModel model;
  const RiderSearchTile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.kBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(model.image ?? 'https://i.pravatar.cc/150'),
            radius: 20,
          ),
          space12W,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(model.fullName, fontWeight: FontWeight.bold),
                CustomText(model.memberNumber, fontSize: 11, color: AppColors.kSecondaryTextColor),
              ],
            ),
          ),
          // CustomButton(
          //   text: "Message", 
          //   onPressed: () {}, // Route to ChatPage logic
          //   isExpanding: false, 
           
          //   borderRadius: 8, 
        
          // ),
        ],
      ),
    );
  }
}
import '../../../../src_export.dart';
import 'channel_member_item_widget.dart';

class CreateChannelDialog extends StatelessWidget {
  const CreateChannelDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.kPrimaryDarkColor3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.kPrimaryColor),
      ),
      child: Padding(
        padding: AppPadding.getPadding12(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(AppStaticStrings.createChannel.tr, color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, color: Colors.white)),
              ],
            ),
            // CustomText( color: Colors.white70, fontSize: 11),
            // space8H,
             CustomTextField(
              title: AppStaticStrings.channelName.tr,
              hintText: 'Local Rides', fillColor: Colors.transparent,
              hintStyle: TextStyle(color: Colors.white, fontSize: 12),
               titleStyle: TextStyle(color: Colors.white, fontSize: 14),
              ),
            space12H,
            Row(
              children: [
                const Icon(Icons.group_add_outlined, color: Colors.white, size: 18),
                space8W,
                CustomText(AppStaticStrings.addMembers.tr, color: Colors.white, fontWeight: FontWeight.bold,fontSize: 12,),
              ],
            ),
            space8H,
            const ChannelMemberItemWidget(name: 'Chris Lee', isAdded: false),
            space8H,
            const ChannelMemberItemWidget(name: 'Taylor Kim', isAdded: false),
            space12H,
            CustomButton(text: AppStaticStrings.createChannel.tr, onPressed: () => Navigator.pop(context)),
            space8H,
            const Center(child: CustomText('You will be the admin of this channel', color: Colors.white, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

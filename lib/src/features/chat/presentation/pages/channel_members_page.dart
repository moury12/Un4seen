import 'package:un4seen/src/features/chat/presentation/controller/chat_controller.dart';

import '../../../../core/widgets/custom_scaffold.dart';
import '../../../../src_export.dart';
import '../widgets/channel_member_item_widget.dart';

class ChannelMembersPage extends StatefulWidget {
  final String channelId;

  const ChannelMembersPage({super.key, required this.channelId});

  @override
  State<ChannelMembersPage> createState() => _ChannelMembersPageState();
}

class _ChannelMembersPageState extends State<ChannelMembersPage> {
  final controller = Get.find<ChatController>();
  final searchCtrl = TextEditingController();
  final addedMemberIds = <String>{};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.globalSearch('');
    });
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _addMember(String userId) async {
    final success = await controller.manageChannelMember(
      channelId: widget.channelId,
      targetUserId: userId,
      action: 'add',
    );

    if (success) {
      setState(() => addedMemberIds.add(userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.kTextColor),
          onPressed: () => context.pop(),
        ),
        title: CustomText(
          AppStaticStrings.addMembers.tr,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: AppPadding.getPadding12(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              textEditingController: searchCtrl,
              hintText: 'Search riders by name or member number...',
              prefixIcon: const Icon(Icons.search),
              onChanged: controller.globalSearch,
            ),
            space12H,
            Expanded(
              child: Obx(() {
                if (controller.isSearchLoading.value &&
                    controller.searchRiderResults.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.searchRiderResults.isEmpty) {
                  return Center(
                    child: CustomText(
                      'No riders found'.tr,
                      color: AppColors.kSecondaryTextColor,
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: controller.searchRiderResults.length,
                  separatorBuilder: (_, __) => space8H,
                  itemBuilder: (context, index) {
                    final rider = controller.searchRiderResults[index];
                    final isAdded = addedMemberIds.contains(rider.id);

                    return ChannelMemberItemWidget(
                      name: rider.fullName,
                      memberNumber: rider.memberNumber,
                      imageUrl: rider.image,
                      isAdded: isAdded,
                      onToggle: isAdded
                          ? null
                          : () => _addMember(rider.id),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

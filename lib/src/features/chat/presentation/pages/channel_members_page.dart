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
      controller.fetchChannelMembers(widget.channelId);
      controller.globalSearch('');
    });
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }

  String? get _currentUserId {
    if (Get.isRegistered<AuthController>()) {
      return Get.find<AuthController>().userProfile.value.id;
    }
    return null;
  }

  Future<void> _addMember(String userId) async {
    final success = await controller.manageChannelMember(
      channelId: widget.channelId,
      targetUserId: userId,
      action: 'add',
    );

    if (success) {
      setState(() => addedMemberIds.add(userId));
      controller.fetchChannelMembers(widget.channelId);
    }
  }

  Future<void> _removeMember(String userId) async {
    final success = await controller.manageChannelMember(
      channelId: widget.channelId,
      targetUserId: userId,
      action: 'remove',
    );

    if (success) {
      setState(() => addedMemberIds.remove(userId));
      controller.fetchChannelMembers(widget.channelId);
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
          AppStaticStrings.members.tr,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              labelColor: AppColors.kPrimaryColor,
              unselectedLabelColor: AppColors.kSecondaryTextColor,
              indicatorColor: AppColors.kPrimaryColor,
              tabs: [
                Tab(text: 'Members'.tr),
                Tab(text: 'Add Riders'.tr),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildMembersTab(),
                  _buildAddRidersTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMembersTab() {
    return Padding(
      padding: AppPadding.getPadding12(context),
      child: Obx(() {
        if (controller.isMembersLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.channelMembers.isEmpty) {
          return Center(
            child: CustomText(
              'No members in this channel'.tr,
              color: AppColors.kSecondaryTextColor,
            ),
          );
        }

        return ListView.separated(
          itemCount: controller.channelMembers.length,
          separatorBuilder: (_, __) => space8H,
          itemBuilder: (context, index) {
            final member = controller.channelMembers[index];
            final isMe = member.id == _currentUserId;

            return ChannelMemberItemWidget(
              name: member.fullName,
              memberNumber: member.memberNumber,
              imageUrl: member.image,
              isAdmin: member.isAdmin,
              isAdded: true, // shows "Remove" button
              onToggle: isMe ? null : () => _removeMember(member.id),
            );
          },
        );
      }),
    );
  }

  Widget _buildAddRidersTab() {
    return Padding(
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
                  final isAlreadyInChannel =
                      controller.channelMembers.any((m) => m.id == rider.id);
                  final isAdded = isAlreadyInChannel || addedMemberIds.contains(rider.id);

                  return ChannelMemberItemWidget(
                    name: rider.fullName,
                    memberNumber: rider.memberNumber,
                    imageUrl: rider.image,
                    isAdded: isAdded,
                    onToggle: isAdded ? null : () => _addMember(rider.id),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

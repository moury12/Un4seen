import 'package:un4seen/src/features/chat/presentation/controller/chat_controller.dart';

import '../../../../src_export.dart';
import 'channel_member_item_widget.dart';

class CreateChannelDialog extends StatefulWidget {
  const CreateChannelDialog({super.key});

  @override
  State<CreateChannelDialog> createState() => _CreateChannelDialogState();
}

class _CreateChannelDialogState extends State<CreateChannelDialog> {
  final controller = Get.find<ChatController>();
  final nameCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final searchCtrl = TextEditingController();
  final selectedMemberIds = <String>{};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.globalSearch('');
    });
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    descriptionCtrl.dispose();
    searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _createChannel() async {
    final name = nameCtrl.text.trim();
    if (name.isEmpty) {
      CustomSnackbar.showError('Please enter a channel name');
      return;
    }

    final success = await controller.createChannel(
      name: name,
      description: descriptionCtrl.text.trim(),
      members: selectedMemberIds.toList(),
    );

    if (success && mounted) {
      Navigator.pop(context);
    }
  }

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    AppStaticStrings.createChannel.tr,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
              CustomTextField(
                textEditingController: nameCtrl,
                title: AppStaticStrings.channelName.tr,
                inputTextStyle: const TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                hintText: 'Local Rides',
                fillColor: Colors.transparent,
                hintStyle: const TextStyle(color: Colors.white, fontSize: 12),
                titleStyle: const TextStyle(color: Colors.white, fontSize: 14),
              ),
              space12H,
              CustomTextField(
                textEditingController: descriptionCtrl,
                title: 'Description',
                inputTextStyle: const TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                ),
                hintText: 'Group for local riders to coordinate meets',
                fillColor: Colors.transparent,
                hintStyle: const TextStyle(color: Colors.white70, fontSize: 12),
                titleStyle: const TextStyle(color: Colors.white, fontSize: 14),
                maxLines: 2,
              ),
              space12H,
              Row(
                children: [
                  const Icon(
                    Icons.group_add_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                  space8W,
                  CustomText(
                    AppStaticStrings.addMembers.tr,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ],
              ),
              space8H,
              CustomTextField(
                textEditingController: searchCtrl,
                hintText: 'Search riders by name or member number...',
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                fillColor: Colors.transparent,
                hintStyle: const TextStyle(color: Colors.white70, fontSize: 12),
                onChanged: controller.globalSearch,
              ),
              space8H,
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 220),
                child: Obx(() {
                  if (controller.isSearchLoading.value &&
                      controller.searchRiderResults.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.searchRiderResults.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: CustomText(
                          'No riders found',
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: controller.searchRiderResults.length,
                    separatorBuilder: (_, __) => space8H,
                    itemBuilder: (context, index) {
                      final rider = controller.searchRiderResults[index];
                      final isAdded = selectedMemberIds.contains(rider.id);

                      return ChannelMemberItemWidget(
                        name: rider.fullName,
                        memberNumber: rider.memberNumber,
                        imageUrl: rider.image,
                        isAdded: isAdded,
                        onToggle: () {
                          setState(() {
                            if (isAdded) {
                              selectedMemberIds.remove(rider.id);
                            } else {
                              selectedMemberIds.add(rider.id);
                            }
                          });
                        },
                      );
                    },
                  );
                }),
              ),
              space12H,
              Obx(
                () => CustomButton(
                  text: AppStaticStrings.createChannel.tr,
                  onPressed: controller.isCreatingChannel.value
                      ? () {}
                      : _createChannel,
                  isLoading: controller.isCreatingChannel.value,
                ),
              ),
              space8H,
              const Center(
                child: CustomText(
                  'You will be the admin of this channel',
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

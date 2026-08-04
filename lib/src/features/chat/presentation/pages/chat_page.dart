import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:un4seen/src/core/core_export.dart';
import 'package:un4seen/src/core/utils/app_images.dart';
import 'package:un4seen/src/features/chat/data/models/chat_models.dart';
import 'package:un4seen/src/features/chat/presentation/controller/chat_controller.dart';
import 'package:un4seen/src/features/profile/presentation/profile_presentation_export.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_network_image.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_text_field.dart';

enum ChatViewType { channel, direct }

class ChatPageArgs {
  final ChatViewType type;
  final String id;
  final String title;
  final String? subtitle;
  final int onlineCount;
  final String? avatarUrl;

  const ChatPageArgs({
    required this.type,
    this.id = '',
    required this.title,
    required this.subtitle,
    this.onlineCount = 0,
    this.avatarUrl,
  });

  const ChatPageArgs.channel({
    required this.id,
    required this.title,
    this.subtitle = 'Main Syndicate channel',
    this.onlineCount = 24,
  }) : type = ChatViewType.channel,
       avatarUrl = null;

  const ChatPageArgs.direct({
    required this.id,
    required this.title,
    this.subtitle,
    this.avatarUrl,
  }) : type = ChatViewType.direct,
       onlineCount = 0;
}

String _formatChatTime(String isoDate) {
  try {
    final dt = DateTime.parse(isoDate).toLocal();
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? 'pm' : 'am';
    return '$hour:$minute $period';
  } catch (_) {
    return isoDate;
  }
}

class ChatPage extends StatefulWidget {
  final ChatPageArgs args;

  const ChatPage({super.key, required this.args});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final ChatController _controller;
  final _msgCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();

  ChatPageArgs get args => widget.args;
  bool get _isChannel => args.type == ChatViewType.channel;

  String? get _currentUserId {
    if (Get.isRegistered<ProfileController>()) {
      return Get.find<ProfileController>().userProfile.value.id;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _controller = Get.isRegistered<ChatController>()
        ? Get.find<ChatController>()
        : Get.put(ChatController());

    if (args.id.isNotEmpty) {
      _controller.fetchChatHistory(args.id, _isChannel);
      // ─── ADD THIS LINE ───
      if (_isChannel) {
        _controller.fetchChannelMembers(args.id);
      }
    }
    _scrollCtrl.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollCtrl.removeListener(_onScroll);
    _msgCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollCtrl.position.pixels >=
        _scrollCtrl.position.maxScrollExtent - 200) {
      _controller.loadNextPage(args.id, _isChannel);
    }
  }

  void _sendMessage() {
    final text = _msgCtrl.text.trim();
    if (text.isEmpty || args.id.isEmpty) return;

    _controller.sendMsg(args.id, text, _isChannel);
    _msgCtrl.clear();
  }

  Future<void> _pickAndSendFile() async {
    if (args.id.isEmpty) return;

    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      // Show uploading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text("Uploading image..."),
                ],
              ),
            ),
          ),
        ),
      );

      final fileUrl = await _controller.uploadChatFile(image.path);

      // Close uploading dialog
      if (mounted) Navigator.of(context).pop();

      if (fileUrl != null && fileUrl.isNotEmpty) {
        _controller.sendMsg(args.id, "", _isChannel, fileUrl: fileUrl);
      }
    } catch (e) {
      if (mounted) Navigator.of(context).pop();
      print("❌ File picking/upload error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5F7FF),
      appBar: AppBar(
        title: _isChannel
            ? _ChannelHeader(args: args)
            : _DirectHeader(args: args),
      ),
      body: Column(
        children: [
          const Divider(height: 1, color: AppColors.kPrimaryColor),
          Expanded(child: _buildMessageList()),
          _MessageInput(
            isChannel: _isChannel,
            title: args.title,
            controller: _msgCtrl,
            onSend: _sendMessage,
            onSendFile: _pickAndSendFile,
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return Obx(() {
      if (_controller.isChatLoading.value &&
          _controller.activeMessages.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      if (_controller.activeMessages.isEmpty) {
        return const Center(
          child: CustomText(
            'No messages yet',
            color: AppColors.kSecondaryTextColor,
          ),
        );
      }

      return ListView.builder(
        controller: _scrollCtrl,
        reverse: true,
        padding: const EdgeInsets.fromLTRB(24, 16, 16, 16),
        itemCount: _controller.activeMessages.length,
        itemBuilder: (context, index) {
          final msg = _controller.activeMessages[index];
          return _buildMessageItem(msg);
        },
      );
    });
  }

  Widget _buildMessageItem(ChatMessageModel msg) {
    final isMe = msg.sender.id == _currentUserId;
    final time = _formatChatTime(msg.createdAt.toString());

    // If it's a Channel/Group chat
    if (_isChannel) {
      return _ChannelMessage(
        messageId: msg.id,
        sender: msg.sender.fullName,
        avatarUrl: msg.sender.image.isNotEmpty
            ? msg.sender.image
            : 'https://i.pravatar.cc/150',
        message: msg.text ?? "",
        time: time,
        fileUrl: msg.file,
        isMe: isMe, // Pass isMe to the widget
      );
    }

    // If it's a Direct Message (1 to 1)
    if (isMe) {
      return _OutgoingMessage(
        message: msg.text ?? "",
        time: time,
        fileUrl: msg.file,
      );
    }

    return _DirectIncomingMessage(
      avatarUrl: msg.sender.image.isNotEmpty
          ? msg.sender.image
          : (args.avatarUrl ?? 'https://i.pravatar.cc/150'),
      message: msg.text ?? "",
      time: time,
      fileUrl: msg.file,
    );
  }
}

class _ChannelHeader extends StatelessWidget {
  final ChatPageArgs args;

  const _ChannelHeader({required this.args});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatController>();

    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: const BoxDecoration(
            color: AppColors.kPrimaryColor,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.tag, color: Colors.white, size: 24),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(args.title, fontSize: 16, fontWeight: FontWeight.bold),
              CustomText(
                args.subtitle ?? "Active Status",
                fontSize: 12,
                color: AppColors.kSecondaryTextColor,
              ),
            ],
          ),
        ),
        ButtonTapWidget(
          onTap: args.id.isNotEmpty
              ? () => context.push(AppRoutes.channelMembers, extra: args.id)
              : () => context.push(AppRoutes.channelMembers),
          child: Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              color: AppColors.kPrimaryColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.groups_2_outlined,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
        space8W,

        Obx(
          () => CustomText(
            '(${controller.channelMembers.length})',
            color: AppColors.kSecondaryTextColor,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _DirectHeader extends StatelessWidget {
  final ChatPageArgs args;

  const _DirectHeader({required this.args});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomNetworkImage(
          imageUrl: args.avatarUrl ?? 'https://i.pravatar.cc/150?u=jake',
          radius: 17,
          width: 34,
          height: 34,
        ),
        space12W,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(args.title, fontSize: 16, fontWeight: FontWeight.bold),
            Row(
              children: [
                Icon(
                  Icons.circle,
                  size: 7,
                  color: args.subtitle == "Online"
                      ? AppColors.kGreenColor
                      : args.subtitle == "Offline"
                      ? AppColors.kRedColor
                      : AppColors.kSecondaryTextColor,
                ),
                space4W,
                CustomText(
                  args.subtitle ?? "Active Status",
                  fontSize: 12,
                  color: AppColors.kTextColor,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _ChannelMessage extends StatelessWidget {
  final String messageId;
  final String sender;
  final String avatarUrl;
  final String message;
  final String time;
  final String? fileUrl;
  final bool isMe; // Added this

  const _ChannelMessage({
    required this.messageId,
    required this.sender,
    required this.avatarUrl,
    required this.message,
    required this.time,
    this.fileUrl,
    this.isMe = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        // ─── THE CORE FIX ───
        // If it's me, align to end (right), otherwise start (left)
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe) ...[
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: _Avatar(url: avatarUrl, radius: 15),
            ),
            // const SizedBox(width: 10),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: isMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                CustomText(
                  isMe ? "You" : sender,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isMe ? AppColors.kPrimaryColor : AppColors.kTextColor,
                ),
                Row(
                  mainAxisAlignment: isMe
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isMe) ...[
                      // Interaction icon on left if message is on right
                      const SizedBox(width: 20),
                    ],
                    Flexible(
                      child: _Bubble(
                        message: message,
                        time: null,
                        isMe: isMe,
                        fileUrl: fileUrl,
                        radius: BorderRadius.only(
                          topLeft: const Radius.circular(12),
                          topRight: const Radius.circular(12),
                          bottomLeft: Radius.circular(isMe ? 12 : 2),
                          bottomRight: Radius.circular(isMe ? 2 : 12),
                        ),
                      ),
                    ),
                    if (!isMe) ...[
                      space4W,
                      GestureDetector(
                        onTap: () => _showReportDialog(context, messageId),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: AppColors.kPrimaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.flag_outlined,
                            color: Colors.white,
                            size: 13,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                space4H,
                CustomText(
                  time,
                  fontSize: 11,
                  color: AppColors.kSecondaryTextColor,
                ),
              ],
            ),
          ),
          if (isMe) ...[
            const SizedBox(width: 10),
            _Avatar(url: avatarUrl, radius: 15),
          ],
        ],
      ),
    );
  }
}

class _DirectIncomingMessage extends StatelessWidget {
  final String avatarUrl;
  final String message;
  final String time;
  final String? fileUrl;

  const _DirectIncomingMessage({
    required this.avatarUrl,
    required this.message,
    required this.time,
    this.fileUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // বাম পাশে
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _Avatar(url: avatarUrl, radius: 15),
          const SizedBox(width: 10),
          Flexible(
            child: _Bubble(
              message: message,
              time: time,
              isMe: false,
              fileUrl: fileUrl,
              radius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
                bottomLeft: Radius.circular(2), // চিকন কোণা বামে
                bottomRight: Radius.circular(14),
              ),
            ),
          ),
          const SizedBox(width: 48), // ডানপাশে জায়গা রাখা
        ],
      ),
    );
  }
}

// ৩. আউটগোয়িং ডিরেক্ট মেসেজ (ডান পাশে - আপনার মেসেজ)
class _OutgoingMessage extends StatelessWidget {
  final String message;
  final String time;
  final String? fileUrl;

  const _OutgoingMessage({
    required this.message,
    required this.time,
    this.fileUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end, // ─── ডান পাশে এলাইনমেন্ট ───
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(width: 48), // বামপাশে জায়গা রাখা
          Flexible(
            child: _Bubble(
              message: message,
              time: time,
              isMe: true,
              fileUrl: fileUrl,
              radius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
                bottomLeft: Radius.circular(14),
                bottomRight: Radius.circular(2), // চিকন কোণা ডানে
              ),
            ),
          ),
          // নিজের প্রোফাইল পিকচার দেখাতে চাইলে এখানে _Avatar যোগ করতে পারেন (যেমনটা চ্যানেলে করা হয়েছে)
        ],
      ),
    );
  }
}

// ৪. বাবল উইজেট (কালার এবং টেক্সট এলাইনমেন্ট হ্যান্ডলিং)
class _Bubble extends StatelessWidget {
  final String message;
  final String? time;
  final bool isMe;
  final String? fileUrl;
  final BorderRadius radius;

  const _Bubble({
    required this.message,
    required this.time,
    required this.isMe,
    required this.radius,
    this.fileUrl,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint("fileUrl------: $fileUrl");
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          if (message.isNotEmpty)
            CustomText(
              message,
              color: AppColors.kTextColor,
              fontSize: 13,
              textAlign: isMe ? TextAlign.right : TextAlign.left,
            ),
          if (fileUrl != null && fileUrl!.isNotEmpty) ...[
            if (message.isNotEmpty) const SizedBox(height: 8),
            CustomNetworkImage(
              imageUrl: fileUrl!,
              height: 200,
              width: double.infinity,
              radius: 8,
              fit: BoxFit.cover,
            ),
          ],
          if (time != null) ...[
            const SizedBox(height: 4),
            CustomText(time!, fontSize: 9, color: Colors.black45),
          ],
        ],
      ),
    );
  }
}

class _MessageInput extends StatelessWidget {
  final bool isChannel;
  final String title;
  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onSendFile;

  const _MessageInput({
    required this.isChannel,
    required this.title,
    required this.controller,
    required this.onSend,
    required this.onSendFile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 14, 14, 14),
      decoration: const BoxDecoration(
        color: Color(0xFFB9EDFF),
        border: Border(top: BorderSide(color: AppColors.kPrimaryColor)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                // padding: const EdgeInsets.only(left: 10, right: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        textEditingController: controller,
                        fillColor: Colors.transparent,
                        borderColor: Colors.transparent,

                        onFieldSubmitted: (_) => onSend(),
                      ),
                    ),
                    IconButton(
                      icon: SvgPicture.asset(AppIcons.gallery, width: 18),
                      onPressed: onSendFile,
                    ),
                  ],
                ),
              ),
            ),
            space8W,
            ButtonTapWidget(
              onTap: onSend,
              child: Container(
                padding: AppPadding.getPadding8(context),
                decoration: const BoxDecoration(
                  color: AppColors.kPrimaryColor,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  AppIcons.sent,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                  height: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChannelsDrawer extends StatelessWidget {
  const _ChannelsDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 198,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
              color: AppColors.kPrimaryDarkColor3,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    '♕ SYNDICATE',
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  space8H,
                  CustomText(
                    'Private Channels',
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          'Channels (4)',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        CustomText(
                          '+Create a Channel - Admin Approval',
                          fontSize: 7,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: AppColors.kPrimaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 18),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: CustomTextField(
                hintText: AppStaticStrings.searchChannels.tr,
                prefixIcon: const Icon(
                  Icons.search,
                  size: 18,
                  color: AppColors.kSecondaryTextColor,
                ),
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            _DrawerChannel(
              title: AppStaticStrings.generalChat.tr,
              online: 24,
              icon: Icons.tag,
              isActive: true,
              onTap: () => context.pushReplacement(
                AppRoutes.chat,
                extra: ChatPageArgs.channel(
                  id: '',
                  title: AppStaticStrings.generalChat.tr,
                ),
              ),
            ),
            _DrawerChannel(
              title: 'Local Rides',
              online: 12,
              icon: Icons.groups_2_outlined,
              onTap: () => context.pushReplacement(
                AppRoutes.chat,
                extra: const ChatPageArgs.channel(
                  id: '',
                  title: 'Local Rides',
                  subtitle: 'Local rides channel',
                  onlineCount: 12,
                ),
              ),
            ),
            _DrawerChannel(
              title: 'Kawasaki KLX140',
              online: 18,
              icon: Icons.chat_bubble_outline,
              hasRequest: true,
              onTap: () => context.push(AppRoutes.buildsMods),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(14, 4, 14, 8),
              child: CustomText(
                'Yamaha 50 Mods & Photos',
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: CustomTextField(
                hintText: 'Search name...',
                prefixIcon: Icon(
                  Icons.search,
                  size: 18,
                  color: AppColors.kSecondaryTextColor,
                ),
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const _DrawerMember(
              name: 'Jake',
              imageUrl: 'https://i.pravatar.cc/150?u=jake',
            ),
            const _DrawerMember(
              name: 'Sarah M',
              imageUrl: 'https://i.pravatar.cc/150?u=sarah-m',
            ),
            const _DrawerMember(
              name: 'Sarah',
              imageUrl: 'https://i.pravatar.cc/150?u=sarah',
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              color: const Color(0xFFB9EDFF),
              child: const Row(
                children: [
                  _Avatar(url: 'https://i.pravatar.cc/150?u=nahid', radius: 16),
                  SizedBox(width: 10),
                  Expanded(child: _OnlineName(name: 'Nahid Hossain')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerChannel extends StatelessWidget {
  final String title;
  final int online;
  final IconData icon;
  final bool isActive;
  final bool hasRequest;
  final VoidCallback onTap;

  const _DrawerChannel({
    required this.title,
    required this.online,
    required this.icon,
    required this.onTap,
    this.isActive = false,
    this.hasRequest = false,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTapWidget(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(14, 0, 14, 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFB9EDFF),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColors.kPrimaryColor),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: AppColors.kTextColor),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title,
                    fontSize: 12,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.circle,
                        size: 7,
                        color: AppColors.kGreenColor,
                      ),
                      space4W,
                      CustomText(
                        '$online online',
                        fontSize: 10,
                        color: AppColors.kSecondaryTextColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (hasRequest)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const CustomText(
                  'Request',
                  color: Colors.white,
                  fontSize: 7,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _DrawerMember extends StatelessWidget {
  final String name;
  final String imageUrl;

  const _DrawerMember({required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ButtonTapWidget(
      onTap: () => context.push(
        AppRoutes.chat,
        extra: ChatPageArgs.direct(id: '', title: name, avatarUrl: imageUrl),
      ),
      child: Container(
        margin: const EdgeInsets.fromLTRB(14, 0, 14, 8),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFB9EDFF),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColors.kPrimaryColor),
        ),
        child: Row(
          children: [
            _Avatar(url: imageUrl, radius: 15),
            space8W,
            Expanded(child: _OnlineName(name: name)),
          ],
        ),
      ),
    );
  }
}

class _OnlineName extends StatelessWidget {
  final String name;

  const _OnlineName({required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(name, fontSize: 12, fontWeight: FontWeight.w500),
        const Row(
          children: [
            Icon(Icons.circle, size: 7, color: AppColors.kGreenColor),
            space4W,
            CustomText(
              'Online',
              fontSize: 10,
              color: AppColors.kSecondaryTextColor,
            ),
          ],
        ),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  final String url;
  final double radius;

  const _Avatar({required this.url, required this.radius});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 9.0),
      child: CircleAvatar(
        radius: radius + 1,

        backgroundColor: AppColors.kPrimaryColor,
        child: CircleAvatar(
          radius: radius,
          backgroundImage: CachedNetworkImageProvider(url),
        ),
      ),
    );
  }
}

void _showReportDialog(BuildContext context, String messageId) {
  final detailsCtrl = TextEditingController();
  String selectedReason = 'Harassment';
  final reasons = ['Harassment', 'Spam', 'Inappropriate Content', 'Other'];

  showDialog(
    context: context,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Report Message'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  value: selectedReason,
                  items: reasons
                      .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        selectedReason = val;
                      });
                    }
                  },
                  decoration: const InputDecoration(labelText: 'Reason'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: detailsCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Details',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.find<ChatController>().reportMessage(
                    messageId,
                    selectedReason,
                    detailsCtrl.text,
                  );
                  Navigator.pop(ctx);
                },
                child: const Text('Report'),
              ),
            ],
          );
        },
      );
    },
  );
}

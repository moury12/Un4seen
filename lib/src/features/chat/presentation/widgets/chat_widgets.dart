import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:un4seen/src/core/utils/app_images.dart';
import 'package:un4seen/src/features/chat/presentation/pages/chat_page.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/button_tap_widget.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_text_field.dart';

class ChannelHeader extends StatelessWidget {
  final ChatPageArgs args;

  const ChannelHeader({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
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
                args.subtitle ??"",
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
        const Icon(Icons.circle, size: 7, color: AppColors.kGreenColor),
        const SizedBox(width: 4),
        CustomText(
          '${args.onlineCount}',
          color: AppColors.kSecondaryTextColor,
          fontSize: 12,
        ),
      ],
    );
  }
}

class DirectHeader extends StatelessWidget {
  final ChatPageArgs args;

  const DirectHeader({required this.args});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 10),
      child: Row(
        children: [
          Avatar(
            url: args.avatarUrl ?? 'https://i.pravatar.cc/150?u=jake',
            radius: 17,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(args.title, fontSize: 16, fontWeight: FontWeight.bold),
              Row(
                children: [
                  const Icon(
                    Icons.circle,
                    size: 7,
                    color: AppColors.kGreenColor,
                  ),
                  space4W,
                  CustomText(
                    args.subtitle??"",
                    fontSize: 12,
                    color: AppColors.kTextColor,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChannelMessage extends StatelessWidget {
  final String sender;
  final String avatarUrl;
  final String message;
  final String time;
  final String? fileUrl;

  const ChannelMessage({
    super.key,
    required this.sender,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Avatar(url: avatarUrl, radius: 15),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(sender, fontSize: 12, fontWeight: FontWeight.w600),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: ChatBubble(
                        message: message,
                        time: null,
                        isMe: false,
                        fileUrl: fileUrl,
                        radius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                    ),
                    space4W,
                    Container(
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
        ],
      ),
    );
  }
}

class DirectIncomingMessage extends StatelessWidget {
  final String avatarUrl;
  final String message;
  final String time;
  final String? fileUrl;

  const DirectIncomingMessage({
    super.key,
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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Avatar(url: avatarUrl, radius: 15),
          const SizedBox(width: 10),
          Flexible(
            child: ChatBubble(
              message: message,
              time: time,
              isMe: false,
              fileUrl: fileUrl,
              radius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
                bottomLeft: Radius.circular(2),
                bottomRight: Radius.circular(14),
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}

class OutgoingMessage extends StatelessWidget {
  final String message;
  final String time;
  final String? fileUrl;

  const OutgoingMessage({
    super.key,
    required this.message,
    required this.time,
    this.fileUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 88, bottom: 14),
      child: Align(
        alignment: Alignment.centerRight,
        child: ChatBubble(
          message: message,
          time: time,
          isMe: true,
          fileUrl: fileUrl,
          radius: const BorderRadius.only(
            topLeft: Radius.circular(14),
            topRight: Radius.circular(14),
            bottomLeft: Radius.circular(14),
            bottomRight: Radius.circular(2),
          ),
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final String? time;
  final bool isMe;
  final String? fileUrl;
  final BorderRadius radius;

  const ChatBubble({
    super.key,
    required this.message,
    required this.time,
    required this.isMe,
    required this.radius,
    this.fileUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.62,
      ),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 9),
      decoration: BoxDecoration(
        color: isMe ? AppColors.kPrimaryColor : Colors.white,
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (message.isNotEmpty)
            CustomText(
              message,
              color: isMe ? Colors.white : AppColors.kTextColor,
              fontSize: 13,
            ),
          if (fileUrl != null && fileUrl!.isNotEmpty) ...[
            if (message.isNotEmpty) const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                fileUrl!,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
          if (time != null) ...[
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.bottomRight,
              child: CustomText(
                time!,
                fontSize: 10,
                color: isMe ? Colors.white : AppColors.kSecondaryTextColor,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class MessageInput extends StatelessWidget {
  final bool isChannel;
  final String title;
  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onSendFile;

  const MessageInput({
    super.key,
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

class ChannelsDrawer extends StatelessWidget {
  const ChannelsDrawer({super.key});

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
            DrawerChannel(
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
            DrawerChannel(
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
            DrawerChannel(
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
            const DrawerMember(
              name: 'Jake',
              imageUrl: 'https://i.pravatar.cc/150?u=jake',
            ),
            const DrawerMember(
              name: 'Sarah M',
              imageUrl: 'https://i.pravatar.cc/150?u=sarah-m',
            ),
            const DrawerMember(
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
                  Avatar(url: 'https://i.pravatar.cc/150?u=nahid', radius: 16),
                  SizedBox(width: 10),
                  Expanded(child: OnlineName(name: 'Nahid Hossain')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerChannel extends StatelessWidget {
  final String title;
  final int online;
  final IconData icon;
  final bool isActive;
  final bool hasRequest;
  final VoidCallback onTap;

  const DrawerChannel({
    super.key,
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

class DrawerMember extends StatelessWidget {
  final String name;
  final String imageUrl;

  const DrawerMember({super.key, required this.name, required this.imageUrl});

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
            Avatar(url: imageUrl, radius: 15),
            space8W,
            Expanded(child: OnlineName(name: name)),
          ],
        ),
      ),
    );
  }
}

class OnlineName extends StatelessWidget {
  final String name;

  const OnlineName({super.key, required this.name});

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

class Avatar extends StatelessWidget {
  final String url;
  final double radius;

  const Avatar({super.key, required this.url, required this.radius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius + 1,
      backgroundColor: AppColors.kPrimaryColor,
      child: CircleAvatar(radius: radius, backgroundImage: NetworkImage(url)),
    );
  }
}

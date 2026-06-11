import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:un4seen/src/core/utils/app_images.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/button_tap_widget.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_text_field.dart';

enum ChatViewType { channel, direct }

class ChatPageArgs {
  final ChatViewType type;
  final String title;
  final String subtitle;
  final int onlineCount;
  final String? avatarUrl;

  const ChatPageArgs({
    required this.type,
    required this.title,
    required this.subtitle,
    this.onlineCount = 0,
    this.avatarUrl,
  });

  const ChatPageArgs.channel({
    required String title,
    String subtitle = 'Main Syndicate channel',
    int onlineCount = 24,
  }) : this(
         type: ChatViewType.channel,
         title: title,
         subtitle: subtitle,
         onlineCount: onlineCount,
       );

  const ChatPageArgs.direct({
    required String title,
    String subtitle = 'Online',
    String? avatarUrl,
  }) : this(
         type: ChatViewType.direct,
         title: title,
         subtitle: subtitle,
         avatarUrl: avatarUrl,
       );
}

class ChatPage extends StatelessWidget {
  final ChatPageArgs args;

  const ChatPage({super.key, required this.args});

  bool get _isChannel => args.type == ChatViewType.channel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5F7FF),
      // drawer: _isChannel ? const _ChannelsDrawer() : null,
      appBar: AppBar(
        title: _isChannel
            ? _ChannelHeader(args: args)
            : _DirectHeader(args: args),
      ),
      body: Column(
        children: [
          const Divider(height: 1, color: AppColors.kPrimaryColor),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 16, 16, 16),
              children: _isChannel ? _channelMessages() : _directMessages(),
            ),
          ),
          _MessageInput(isChannel: _isChannel, title: args.title),
        ],
      ),
    );
  }

  List<Widget> _channelMessages() {
    return const [
      _ChannelMessage(
        sender: 'Sarah M',
        avatarUrl: 'https://i.pravatar.cc/150?u=sarah-m',
        message: 'Welcome to the Syndicate chat! 🔥',
        time: '10:00 AM',
      ),
      _ChannelMessage(
        sender: 'Jake',
        avatarUrl: 'https://i.pravatar.cc/150?u=jake',
        message: 'Who is hitting the trails this weekend?',
        time: '10:15 AM',
      ),
      _ChannelMessage(
        sender: 'Sarah',
        avatarUrl: 'https://i.pravatar.cc/150?u=sarah',
        message: 'I am down! Venice Beach at 2pm?',
        time: '10:20 AM',
      ),
      _OutgoingMessage(message: 'Hello', time: '3:00 pm'),
    ];
  }

  List<Widget> _directMessages() {
    return [
      const Center(
        child: CustomText(
          'Today',
          fontSize: 11,
          color: AppColors.kSecondaryTextColor,
        ),
      ),
      space12H,
      const _OutgoingMessage(message: 'Hello', time: '3:00 pm'),
      _DirectIncomingMessage(
        avatarUrl: args.avatarUrl ?? 'https://i.pravatar.cc/150?u=jake',
        message: 'How can we help you',
        time: '3:01 pm',
      ),
      const _OutgoingMessage(
        message:
            'I need a emergency appointment......... are you available now.',
        time: '3:01 pm',
      ),
      _DirectIncomingMessage(
        avatarUrl: args.avatarUrl ?? 'https://i.pravatar.cc/150?u=jake',
        message:
            'Yes we are available for you , at first book an appointment and come , you can use google map also if you have any problem.',
        time: '3.02 pm',
      ),
    ];
  }
}

class _ChannelHeader extends StatelessWidget {
  final ChatPageArgs args;

  const _ChannelHeader({required this.args});

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
                args.subtitle,
                fontSize: 12,
                color: AppColors.kSecondaryTextColor,
              ),
            ],
          ),
        ),
        ButtonTapWidget(
          onTap: () => context.push(AppRoutes.channelMembers),
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

class _DirectHeader extends StatelessWidget {
  final ChatPageArgs args;

  const _DirectHeader({required this.args});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 10),
      child: Row(
        children: [
          _Avatar(
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
                    args.subtitle,
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

class _ChannelMessage extends StatelessWidget {
  final String sender;
  final String avatarUrl;
  final String message;
  final String time;

  const _ChannelMessage({
    required this.sender,
    required this.avatarUrl,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Avatar(url: avatarUrl, radius: 15),
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
                      child: _Bubble(
                        message: message,
                        time: null,
                        isMe: false,
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

class _DirectIncomingMessage extends StatelessWidget {
  final String avatarUrl;
  final String message;
  final String time;

  const _DirectIncomingMessage({
    required this.avatarUrl,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _Avatar(url: avatarUrl, radius: 15),
          const SizedBox(width: 10),
          Flexible(
            child: _Bubble(
              message: message,
              time: time,
              isMe: false,
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

class _OutgoingMessage extends StatelessWidget {
  final String message;
  final String time;

  const _OutgoingMessage({required this.message, required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 88, bottom: 14),
      child: Align(
        alignment: Alignment.centerRight,
        child: _Bubble(
          message: message,
          time: time,
          isMe: true,
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

class _Bubble extends StatelessWidget {
  final String message;
  final String? time;
  final bool isMe;
  final BorderRadius radius;

  const _Bubble({
    required this.message,
    required this.time,
    required this.isMe,
    required this.radius,
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
          CustomText(
            message,
            color: isMe ? Colors.white : AppColors.kTextColor,
            fontSize: 13,
          ),
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

class _MessageInput extends StatelessWidget {
  final bool isChannel;
  final String title;

  const _MessageInput({required this.isChannel, required this.title});

  @override
  Widget build(BuildContext context) {
    final hint = isChannel ? 'Message #$title...' : 'Message';

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
                    const Expanded(
                      child: CustomTextField(
                        fillColor: Colors.transparent,
                        borderColor: Colors.transparent,
                      ),
                    ),
                    IconButton(
                      icon: SvgPicture.asset(AppIcons.gallery, width: 18),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            space8W,
            Container(
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
        extra: ChatPageArgs.direct(title: name, avatarUrl: imageUrl),
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
    return CircleAvatar(
      radius: radius + 1,
      backgroundColor: AppColors.kPrimaryColor,
      child: CircleAvatar(radius: radius, backgroundImage: NetworkImage(url)),
    );
  }
}

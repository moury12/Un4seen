import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:un4seen/src/core/core_export.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/widgets/custom_scaffold.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_text_field.dart';
import 'chat_page.dart';
import '../widgets/channel_list_item_widget.dart';
import '../widgets/create_channel_dialog.dart';

class ChannelsPage extends StatelessWidget {
  const ChannelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
     title: Text("Private Channels"),
     
        actions: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.kPrimaryColor,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.add, color: AppColors.kWhiteTextColor,size: 30,),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const CreateChannelDialog(),
                );
              },
            ),
          ),
          space12W
        ],
      ),
      body: Padding(
        padding: AppPadding.getPadding12(context),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             CustomText(
               "${AppStaticStrings.channels.tr} (4)",
              variant: TextVariant.headlineSmall, color: AppColors.kTextColor
             ),
             CustomText("+Create a Channel - Admin Approval Required", variant: TextVariant.labelSmall, color: AppColors.kTextColor),
          
          space12H,  CustomTextField(
              hintText: AppStaticStrings.searchChannels.tr,
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.kSecondaryTextColor,
              ),
            ),
            space12H,
            Expanded(
              child: ListView(                padding: EdgeInsets.zero,

                children: [
                  ChannelListItemWidget(
                    img: "assets/icons/hash_con.svg",
                    title: AppStaticStrings.generalChat.tr,
                    subtitle: "24 ${AppStaticStrings.online.tr}",
                    onTap: () => context.push(
                      AppRoutes.chat,
                      extra: ChatPageArgs.channel(
                        title: AppStaticStrings.generalChat.tr,
                      ),
                    ),
                  ),
                  space8H,
                  ChannelListItemWidget(
                    img: AppIcons.groupPeople,
                    title: 'Local Rides',
                    subtitle: "12 ${AppStaticStrings.online.tr}",
                    onTap: () => context.push(
                      AppRoutes.chat,
                      extra: const ChatPageArgs.channel(
                        title: 'Local Rides',
                        subtitle: 'Local rides channel',
                        onlineCount: 12,
                      ),
                    ),
                  ),
                  space8H,
                  ChannelListItemWidget(
                    img: "assets/icons/chat_icon.svg",
                    title: 'Kawasaki KLX140',
                    subtitle: "10 ${AppStaticStrings.online.tr}",
                    isActive: true,
                    onTap: () => context.push(AppRoutes.buildsMods),
                  ),
                ],
              ),
            ),
          CustomText(
               "Yamaha 50 Mods & Photos",
              variant: TextVariant.headlineSmall, color: AppColors.kTextColor
             ),
             space12H,
             CustomTextField(
              hintText: AppStaticStrings.searchChannels.tr,
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.kSecondaryTextColor,
              ),
            ),
            space12H,
          Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ChannelListItemWidget(
                    profileImg: "https://i.pravatar.cc/150?img=1",
                    title: "user 2",
                    subtitle: " ${AppStaticStrings.online.tr}",
                    onTap: () => context.push(
                      AppRoutes.chat,
                      extra: ChatPageArgs.direct(
                        title: "User Name",
                      ),
                    ),
                  ),
                  space8H,
                  ChannelListItemWidget(
                    profileImg: "https://i.pravatar.cc/150?img=1",
                    title: 'User1',
                    subtitle: " ${AppStaticStrings.online.tr}",
                    onTap: () => context.push(
                      AppRoutes.chat,
                      extra: ChatPageArgs.direct(
                        title: "User Name",
                      ),)
                  ),
                  
                ],
              ),
            ),
        
          space12H,  ],
        ),
      ),
    );
  }
}

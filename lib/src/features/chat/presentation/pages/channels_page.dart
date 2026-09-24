import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:un4seen/src/core/core_export.dart';
import '../../../../core/routes/app_routes.dart';
import '../controller/chat_controller.dart';
import '../controller/support_chat_controller.dart';
import 'chat_page.dart';
import '../widgets/channel_list_item_widget.dart';
import '../widgets/create_channel_dialog.dart';

class ChannelsPage extends StatelessWidget {
  const ChannelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatController());
    final supportController = Get.put(SupportChatController());

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Un4seen Chats"),
        actions: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.kPrimaryColor,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.add,
                color: AppColors.kWhiteTextColor,
                size: 30,
              ),
              onPressed: () => showDialog(
                context: context,
                builder: (context) => const CreateChannelDialog(),
              ),
            ),
          ),
          space12W,
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.wait([
            controller.fetchSidebar(),
            supportController.fetchSupportChat(),
          ]);
        },
        color: AppColors.kPrimaryColor,
        child: Obx(() {
          // Determine if we should show initial loading
          final bool isInitialLoading =
              controller.isChannelsLoading.value &&
              controller.groupsList.isEmpty &&
              controller.dmsList.isEmpty;

          return CustomScrollView(
            // AlwaysScrollableScrollPhysics is key to allowing pull-to-refresh when empty
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              // ─── 1. GROUPS SECTION ───
              SliverPadding(
                padding: AppPadding.getPadding12(context),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        "${AppStaticStrings.channels.tr} (${controller.groupsList.length})",
                        variant: TextVariant.headlineSmall,
                        color: AppColors.kTextColor,
                      ),
                      const CustomText(
                        "+Create a Channel - Admin Approval Required",
                        variant: TextVariant.labelSmall,
                        color: AppColors.kTextColor,
                      ),
                      space12H,
                      ButtonTapWidget(
                        onTap: () {
                          context.push(AppRoutes.chatSearch);
                        },
                        child: CustomTextField(
                          isEnable: false,
                          hintText: AppStaticStrings.searchChannels.tr,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: AppColors.kSecondaryTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              if (isInitialLoading)
                const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              else if (controller.groupsList.isEmpty)
                SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: CustomText(
                        "No channels joined".tr,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )
              else ...[
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final group = controller.groupsList[index];
                        return ChannelListItemWidget(
                          img: "assets/icons/hash_con.svg",
                          title: group.name,
                          fromChannel: true,
                          channelId: group.id,
                          subtitle:
                              "${group.onlineCount} ${AppStaticStrings.online.tr}",
                          onTap: () => context.push(
                            AppRoutes.chat,
                            extra: ChatPageArgs.channel(
                              id: group.id,
                              title: group.name,
                              onlineCount: group.onlineCount,
                            ),
                          ),
                        );
                      },
                      childCount: controller.groupsList.length > 2
                          ? 2
                          : controller.groupsList.length,
                    ),
                  ),
                ),
                if (controller.groupsList.length > 2)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: ButtonTapWidget(
                        onTap: () => context.push(AppRoutes.allChannels),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomText(
                              AppStaticStrings.viewAll.tr,
                              fontWeight: FontWeight.bold,
                              color: AppColors.kPrimaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],

              // ─── 1.5. SUPPORT CHAT SECTION (PLACED BEFORE DIRECT MESSAGES) ───
              SliverPadding(
                padding: AppPadding.getPadding12H(context),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      space12H,
                      const CustomText(
                        "Support Chat",
                        variant: TextVariant.headlineSmall,
                        color: AppColors.kTextColor,
                      ),
                      const CustomText(
                        "Direct assistance & help from Un4seen Admin",
                        variant: TextVariant.labelSmall,
                        color: AppColors.kTextColor,
                      ),
                      space8H,
                      Obx(() {
                        final session = supportController.session.value;
                        final String lastMsg =
                            session?.lastMessage ??
                            (supportController.messages.isNotEmpty
                                ? supportController.messages.last.text
                                : "Tap to open support chat");
                        final String status = session?.status ?? "Open";
                        final int unread = session?.unreadCountUser ?? 0;

                        return ButtonTapWidget(
                          onTap: () => context.push(AppRoutes.supportChat),
                          child: Container(
                            padding: AppPadding.getPadding12(context),
                            decoration: BoxDecoration(
                              color: AppColors.kPrimaryColor.withValues(
                                alpha: .2,
                              ),
                              borderRadius: BorderRadius.circular(appRadius),
                              border: Border.all(
                                color: AppColors.kPrimaryColor,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: const BoxDecoration(
                                    color: AppColors.kPrimaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.support_agent,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const CustomText(
                                            "Admin Support",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: AppColors.kTextColor,
                                          ),
                                          const SizedBox(width: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 6,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.green.withValues(
                                                alpha: 0.2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: CustomText(
                                              status.capitalizeFirst ?? status,
                                              color: Colors.green,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      CustomText(
                                        lastMsg,
                                        fontSize: 12,
                                        color: AppColors.kSecondaryTextColor,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                if (unread > 0)
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: const BoxDecoration(
                                      color: AppColors.kRedColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: CustomText(
                                      '$unread',
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppColors.kSecondaryTextColor,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      space12H,
                    ],
                  ),
                ),
              ),

              // ─── 2. DIRECT MESSAGES SECTION ───
              SliverPadding(
                padding: AppPadding.getPadding12H(context),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // space12H,
                      const CustomText(
                        "Direct Messages",
                        variant: TextVariant.headlineSmall,
                        color: AppColors.kTextColor,
                      ),
                      space8H,
                      ButtonTapWidget(
                        onTap: () {
                          context.push(AppRoutes.chatSearch);
                        },
                        child: CustomTextField(
                          hintText: "Search name...".tr,
                          isEnable: false,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: AppColors.kSecondaryTextColor,
                          ),
                        ),
                      ),
                      space8H,
                    ],
                  ),
                ),
              ),

              if (controller.dmsList.isEmpty && !isInitialLoading)
                SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: CustomText(
                        "No messages yet".tr,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final dm = controller.dmsList[index];
                      return ChannelListItemWidget(
                        profileImg: dm.image,
                        title: dm.name,
                        subtitle: dm.isOnline ? "Online".tr : "Offline".tr,
                        onTap: () => context.push(
                          AppRoutes.chat,
                          extra: ChatPageArgs.direct(
                            id: dm.userId,
                            title: dm.name,
                            subtitle: dm.isOnline ? "Online" : "Offline",
                            avatarUrl: dm.image,
                          ),
                        ),
                      );
                    }, childCount: controller.dmsList.length),
                  ),
                ),

              const SliverToBoxAdapter(child: SizedBox(height: 40)),
            ],
          );
        }),
      ),
    );
  }
}

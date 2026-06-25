import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:un4seen/src/core/core_export.dart';
import '../../../../core/routes/app_routes.dart';
import '../controller/chat_controller.dart';
import 'chat_page.dart';
import '../widgets/channel_list_item_widget.dart';
import '../widgets/create_channel_dialog.dart';

class ChannelsPage extends StatelessWidget {
  const ChannelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatController());

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
        onRefresh: () => controller.fetchSidebar(),
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
                    delegate: SliverChildBuilderDelegate((context, index) {
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
                    }, childCount: controller.groupsList.length > 2 ? 2 : controller.groupsList.length),
                  ),
                ),
                if (controller.groupsList.length > 2)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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

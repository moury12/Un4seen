import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:un4seen/src/core/core_export.dart';
import '../../../../core/routes/app_routes.dart';
import '../controller/chat_controller.dart';
import 'chat_page.dart';
import '../widgets/channel_list_item_widget.dart';

class AllChannelsPage extends StatelessWidget {
  const AllChannelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatController>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(AppStaticStrings.channels.tr),
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.fetchSidebar(),
        color: AppColors.kPrimaryColor,
        child: Obx(() {
          final bool isInitialLoading =
              controller.isChannelsLoading.value &&
              controller.groupsList.isEmpty;

          if (isInitialLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.groupsList.isEmpty) {
            return CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverFillRemaining(
                  child: Center(
                    child: CustomText(
                      "No channels joined".tr,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            );
          }

          return CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                  }, childCount: controller.groupsList.length),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

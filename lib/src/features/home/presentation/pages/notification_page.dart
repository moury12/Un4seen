// lib/src/features/profile/presentation/pages/notifications_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/core_export.dart';
import '../controllers/notification_controller.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Put instances to initialize scroll telemetry listeners safely
    final controller = Get.put(NotificationController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Obx(() {
        // Full screen blocking loader triggers exclusively on first bootstrap
        if (controller.isLoading.value && controller.notifications.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: () => controller.fetchNotifications(isRefresh: true),
          color: AppColors.kPrimaryColor,
          child: CustomScrollView(
            controller: controller.scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              if (controller.notifications.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text(
                      "No notifications found".tr,
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: AppPadding.getPadding12(context),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final notification = controller.notifications[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          elevation: 0.5,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            leading: CircleAvatar(
                              backgroundColor: AppColors.kPrimaryColor.withOpacity(0.1),
                              child: const Icon(Icons.notifications, color: AppColors.kPrimaryColor),
                            ),
                            title: CustomText(
                              notification.title,
                              variant: TextVariant.bodyLarge,
                              fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: CustomText(
                                notification.message,
                                variant: TextVariant.bodyMedium,
                                color: AppColors.kSecondaryTextColor,
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: controller.notifications.length,
                    ),
                  ),
                ),
              // Dynamic inline pagination spinner pinned at list bottom
              if (controller.isLoadingMore.value)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
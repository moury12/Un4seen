import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/core_export.dart';
import '../controllers/home_controller.dart';
import '../widgets/item_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(
        title: const CustomText('Home', variant: TextVariant.headlineSmall),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_outlined),
            onPressed: ctrl.refresh,
          ),
        ],
      ),
      body: Obx(() {
        if (ctrl.isLoading.value) return const AppLoader();

        if (ctrl.errorMessage.isNotEmpty) {
          return EmptyStateWidget(
            message: ctrl.errorMessage.value,
            icon: Icons.error_outline,
            onRetry: ctrl.refresh,
            retryLabel: AppStaticStrings.retry,
          );
        }

        if (ctrl.items.isEmpty) {
          return const EmptyStateWidget(message: 'No items found');
        }

        return RefreshIndicator(
          onRefresh: ctrl.fetchItems,
          child: ListView.builder(
            padding: AppPadding.getPadding12H(context),
            itemCount: ctrl.items.length,
            itemBuilder: (context, i) {
              final item = ctrl.items[i];
              return ItemCard(
                item: item,
                onTap: () => context.go('/home/detail/${item.id}'),
              );
            },
          ),
        );
      }),
    );
  }
}

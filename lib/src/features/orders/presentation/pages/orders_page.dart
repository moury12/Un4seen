import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:un4seen/src/core/theme/app_colors.dart';
import 'package:un4seen/src/core/utils/app_constants.dart';
import 'package:un4seen/src/core/utils/app_images.dart';
import 'package:un4seen/src/core/utils/app_strings.dart';
import 'package:un4seen/src/core/widgets/custom_scaffold.dart';
import 'package:un4seen/src/core/utils/url_launcher_utils.dart';
import '../controllers/orders_controller.dart';
import '../../data/models/shopify_order_model.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  String _formatDate(String dateStr) {
    try {
      final dateTime = DateTime.parse(dateStr);
      final months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];
      return "${months[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year}";
    } catch (e) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<OrdersController>()
        ? Get.find<OrdersController>()
        : Get.put(OrdersController());

    return CustomScaffold(
      appBar: AppBar(
        title: const Text(
          AppStaticStrings.myOrders,
          style: TextStyle(
            color: Color(0xFF1A1A2E),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A2E)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.kPrimaryColor,
            ),
          );
        }

        if (controller.ordersList.isEmpty) {
          return RefreshIndicator(
            onRefresh: () => controller.fetchOrders(),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                const Center(
                  child: Text(
                    'No orders found.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => controller.fetchOrders(),
          child: ListView.builder(
            padding: AppPadding.getPadding12H(context),
            itemCount: controller.ordersList.length,
            itemBuilder: (context, index) {
              final order = controller.ordersList[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: _buildOrderCard(context, order),
              );
            },
          ),
        );
      }),
    );
  }

  Widget _buildOrderCard(BuildContext context, ShopifyOrder order) {
    final title = order.items.isNotEmpty
        ? order.items.map((e) => e.title).join(', ')
        : 'No items';
    
    final orderDetail = 'Order ${order.orderNumber} • ${_formatDate(order.date)}';
    
    String estimatedDelivery = 'Not available';
    try {
      final orderDate = DateTime.parse(order.date);
      final deliveryDate = orderDate.add(const Duration(days: 7));
      estimatedDelivery = _formatDate(deliveryDate.toIso8601String());
    } catch (_) {}

    final lowercaseTitle = title.toLowerCase();
    final isGraphicsKit = lowercaseTitle.contains('graphics') || lowercaseTitle.contains('kit');
    
    final List<_OrderStepModel> steps = isGraphicsKit
        ? [
            _OrderStepModel(title: 'Order Placed', icon: AppIcons.cell),
            _OrderStepModel(title: 'In Print Que', icon: AppIcons.cell),
            _OrderStepModel(title: 'Lamination & Cut Process', icon: AppIcons.checked),
            _OrderStepModel(title: 'Packaging', icon: AppIcons.checked),
            _OrderStepModel(title: 'Ready', icon: AppIcons.checked),
            _OrderStepModel(title: 'Shipped', icon: AppIcons.car),
          ]
        : [
            _OrderStepModel(title: 'Order Placed', icon: AppIcons.cell),
            _OrderStepModel(title: 'In Production', icon: AppIcons.cell),
            _OrderStepModel(title: 'Ready', icon: AppIcons.checked),
            _OrderStepModel(title: 'Shipped', icon: AppIcons.car),
          ];

    final isDelivered = order.orderStatus.toLowerCase() == 'delivered';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.kPrimaryColor,
            AppColors.kPrimaryDarkColor,
            AppColors.kPrimaryDarkColor2,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      orderDetail,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  order.orderStatus.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.kPrimaryColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ...List.generate(steps.length, (index) {
            final step = steps[index];
            final isLast = index == steps.length - 1;
            final isStepCompleted = isDelivered || index <= order.currentStep;
            final isStepCurrent = !isDelivered && index == order.currentStep;

            return IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isStepCurrent ? Colors.white : AppColors.kPrimaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            step.icon,
                            width: 20,
                            height: 20,
                            colorFilter: ColorFilter.mode(
                              isStepCurrent ? Colors.black : Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      if (!isLast)
                        Expanded(
                          child: Container(
                            width: 2,
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          step.title,
                          style: TextStyle(
                            color: Colors.white.withOpacity(isStepCompleted ? 1 : 0.6),
                            fontSize: 13,
                            fontWeight: isStepCompleted ? FontWeight.w500 : FontWeight.normal,
                          ),
                        ),
                        if (!isLast) const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 20),
          Center(
            child: Text(
              'Estimated delivery: $estimatedDelivery',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 13,
              ),
            ),
          ),
          if (order.trackingInfo != null && order.trackingInfo!.url.isNotEmpty) ...[
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                onPressed: () => UrlLauncherUtils.launchExternalUrl(order.trackingInfo!.url),
                icon: const Icon(Icons.track_changes, color: AppColors.kPrimaryColor),
                label: Text(
                  'Track Order (${order.trackingInfo!.company})',
                  style: const TextStyle(color: AppColors.kPrimaryColor),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _OrderStepModel {
  final String title;
  final String icon;

  _OrderStepModel({required this.title, required this.icon});
}

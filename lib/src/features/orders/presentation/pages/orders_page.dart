import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_scaffold.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: const Text(AppStaticStrings.myOrders),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildOrderCard(
            title: AppStaticStrings.syndicateTShirt,
            orderId: 'Order #O8D-2104 • Apr 20, 2025',
            status: 'SHIPPED',
            steps: ['Order Placed', 'In Production', 'Ready', 'Shipped'],
            currentStep: 3,
          ),
          const SizedBox(height: 20),
          _buildOrderCard(
            title: AppStaticStrings.yamahaGraphicsKit,
            orderId: 'Order #O8D-2104 • Apr 20, 2025',
            status: 'IN MAKING',
            steps: ['Order Placed', 'In Making', 'Lamination & Cut', 'Packaging', 'Ready', 'Shipped'],
            currentStep: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard({
    required String title,
    required String orderId,
    required String status,
    required List<String> steps,
    required int currentStep,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.kPrimaryColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Text(
                      orderId,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...List.generate(steps.length, (index) {
            final isCompleted = index <= currentStep;
            final isLast = index == steps.length - 1;
            return Row(
              children: [
                Column(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: isCompleted ? AppColors.kPrimaryColor : Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isCompleted ? AppColors.kPrimaryColor : Colors.white24,
                        ),
                      ),
                      child: isCompleted
                          ? const Icon(Icons.check, color: Colors.white, size: 12)
                          : null,
                    ),
                    if (!isLast)
                      Container(
                        width: 2,
                        height: 20,
                        color: isCompleted ? AppColors.kPrimaryColor : Colors.white24,
                      ),
                  ],
                ),
                const SizedBox(width: 12),
                Text(
                  steps[index],
                  style: TextStyle(
                    color: isCompleted ? Colors.white : Colors.white38,
                    fontSize: 14,
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

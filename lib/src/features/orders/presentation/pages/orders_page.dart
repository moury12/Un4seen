import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:un4seen/src/core/theme/app_colors.dart';
import 'package:un4seen/src/core/utils/app_constants.dart';
import 'package:un4seen/src/core/utils/app_images.dart';
import 'package:un4seen/src/core/utils/app_strings.dart';
import 'package:un4seen/src/core/widgets/custom_scaffold.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: const Text(
          AppStaticStrings.myOrders,
          style: TextStyle(
            color: Color(0xFF1A1A2E), // Dark color as per image
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
      body: ListView(
        padding: AppPadding.getPadding12H(context),
        children: [
          _buildOrderCard(
            title: AppStaticStrings.syndicateTShirt,
            orderDetail: 'Order #ORD-2834 • Apr 20, 2026',
            status: 'SHIPPED',
            estimatedDelivery: 'Apr 28, 2026',
            steps: [
              _OrderStepModel(
                title: 'Order Placed',
                icon: AppIcons.cell,
                isCompleted: true,
              ),
              _OrderStepModel(
                title: 'In Production',
                icon: AppIcons.cell,
                isCompleted: true,
              ),
              _OrderStepModel(
                title: 'Ready',
                icon: AppIcons.checked,
                isCompleted: true,
              ),
              _OrderStepModel(
                title: 'Shipped',
                icon: AppIcons.car,
                isCompleted: true,
                isCurrent: true,
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildOrderCard(
            title: 'Yamaha Graphics Kit- Quik Blue',
            orderDetail: 'Order #41899 • Apr 18th, 2026',
            status: 'DELIVERED',
            estimatedDelivery: 'Apr 28, 2026',
            steps: [
              _OrderStepModel(
                title: 'Order Placed',
                icon: AppIcons.cell,
                isCompleted: true,
              ),
              _OrderStepModel(
                title: 'In Print Que is its own step. After design proof',
                icon: AppIcons.cell,
                isCompleted: true,
              ),
              _OrderStepModel(
                title: 'Lamination & Cut Process',
                icon: AppIcons.checked,
                isCompleted: true,
              ),
              _OrderStepModel(
                title: 'Packaging',
                icon: AppIcons.checked,
                isCompleted: true,
              ),
              _OrderStepModel(
                title: 'Ready',
                icon: AppIcons.checked,
                isCompleted: true,
              ),
              _OrderStepModel(
                title: 'Shipped',
                icon: AppIcons.car,
                isCompleted: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard({
    required String title,
    required String orderDetail,
    required String status,
    required String estimatedDelivery,
    required List<_OrderStepModel> steps,
  }) {
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
          // Header
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
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

          // Stepper
          ...List.generate(steps.length, (index) {
            final step = steps[index];
            final isLast = index == steps.length - 1;

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
                          color: step.isCurrent
                              ? Colors.white
                              : AppColors.kPrimaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            step.icon,
                            width: 20,
                            height: 20,
                            colorFilter: ColorFilter.mode(
                              step.isCurrent ? Colors.black : Colors.white,
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
                        const SizedBox(
                          height: 10,
                        ), // Alignment with icon center
                        Text(
                          step.title,
                          style: TextStyle(
                            color: Colors.white.withOpacity(
                              step.isCompleted ? 1 : 0.6,
                            ),
                            fontSize: 13,
                            fontWeight: step.isCompleted
                                ? FontWeight.w500
                                : FontWeight.normal,
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
        ],
      ),
    );
  }
}

class _OrderStepModel {
  final String title;
  final String icon;
  final bool isCompleted;
  final bool isCurrent;

  _OrderStepModel({
    required this.title,
    required this.icon,
    this.isCompleted = false,
    this.isCurrent = false,
  });
}

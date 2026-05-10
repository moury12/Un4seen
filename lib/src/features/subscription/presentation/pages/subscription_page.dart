import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_scaffold.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  bool isAnnual = true;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: const Text(AppStaticStrings.goSyndicate),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              AppStaticStrings.unlockEverythingNoLimits,
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                _buildPlanToggle(
                  title: AppStaticStrings.annual,
                  price: '\$363.99',
                  subtitle: 'Only \$6.99/week',
                  isSelected: isAnnual,
                  onTap: () => setState(() => isAnnual = true),
                ),
                const SizedBox(width: 15),
                _buildPlanToggle(
                  title: AppStaticStrings.weekly,
                  price: '\$16.99',
                  subtitle: 'Only \$6.99/week',
                  isSelected: !isAnnual,
                  onTap: () => setState(() => isAnnual = false),
                ),
              ],
            ),
            const SizedBox(height: 30),
            _buildWhatIncluded(),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kPrimaryColor,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                isAnnual
                    ? AppStaticStrings.startAnnualSubscription
                    : AppStaticStrings.startWeeklySubscription,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanToggle({
    required String title,
    required String price,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.kPrimaryColor : AppColors.kPrimaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? AppColors.kPrimaryColor : AppColors.kPrimaryColor.withOpacity(0.3),
            ),
          ),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white70,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                price,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: isSelected ? Colors.white70 : Colors.white38,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWhatIncluded() {
    final items = [
      'FREE Syndicate Members Pack (RRP \$119.95)',
      'Member group chats & channels, stories, bike profiles, competitions, idea sharing, test ride opportunities, and polls.',
      'Syndicate Pricing Site-wide',
      'Weekly Giveaways',
      'Giveaways - Brand new bikes, Graphics Kits, iPhones, Dirt Bikes, Apple TV, Apparel, Key Chains & so much more!',
      'Shred Points',
      'Exclusive of coupons in featured brands',
      'Full Bike Graphics Kit (RRP \$1119.99 NZD)',
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStaticStrings.whatsIncluded,
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle, color: AppColors.kPrimaryColor, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

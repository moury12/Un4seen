import 'package:flutter/material.dart';
import '../../../../core/core_export.dart';

class SubscriptionFeaturesSectionWidget extends StatelessWidget {
  const SubscriptionFeaturesSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final features = [
      {
        'title': 'FREE Syndicate Members Pack (RRP \$199.99)',
        'subtitle':
            'You\'ll receive a members-only hat, a custom T-shirt printed with your Syndicate member number, keychain, a sticker pack, and a lanyard & membership card just pay freight 🧢🔥',
      },
      {
        'title':
            'Member group chats & channels, stories, bike profiles, competitions, idea sharing, test rider opportunities, and polls.',
      },
      {
        'title': 'Syndicate Pricing Site-wide',
        'subtitle': 'Members only Discounted Pricing',
      },
      {'title': 'Weekly giveaways'},
      {
        'title':
            'Giveaway\'s - Brand new bikes, Graphics Kits, Phones, Shirt Prints, keychain, Apparel, Key Chains & so much more',
      },
      {
        'title': 'Shred Points',
        'subtitle': 'Complete tasks & Earn rewards claim store credits',
      },
      {'title': 'Exclusive discounts to featured brands'},
      {
        'title':
            'Full Size Graphics Kit RRP: \$389.99 NZD\nSyndicate Members Pricing: \$296.39 NZD',
      },
    ];

    return Container(
      padding: AppPadding.getPadding12(context),
      decoration: BoxDecoration(
        color: const Color(0xFF01527D),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStaticStrings.whatsIncluded,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          ...features.map((feature) => _FeatureItem(feature: feature)),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final Map<String, String> feature;

  const _FeatureItem({required this.feature});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              color: AppColors.kPrimaryColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: Colors.white, size: 14),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      height: 1.4,
                    ),
                    children: _parseFeatureTitle(feature['title']!),
                  ),
                ),
                if (feature.containsKey('subtitle')) ...[
                  const SizedBox(height: 4),
                  Text(
                    feature['subtitle']!,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<TextSpan> _parseFeatureTitle(String title) {
    if (title.startsWith('FREE')) {
      return [
        const TextSpan(
          text: 'FREE',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(text: title.substring(4)),
      ];
    }
    return [TextSpan(text: title)];
  }
}

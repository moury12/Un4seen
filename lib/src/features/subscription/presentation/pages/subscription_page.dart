import 'package:un4seen/src/src_export.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  bool isAnnual = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStaticStrings.goSyndicate,
          style: TextStyle(
            color: Color(0xFF1A1A2E),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A2E)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12H(context),
        child: Column(
          children: [
            const Text(
              AppStaticStrings.unlockEverythingNoLimits,
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
            space12H,
            Row(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: PricingCardWidget(
                    title: AppStaticStrings.annual,
                    originalPrice: '\$884',
                    currentPrice: 'Only \$363.99',
                    unit: 'NZD/year',
                    isSelected: isAnnual,
                    showBadge: true,
                    onTap: () => setState(() => isAnnual = true),
                  ),
                ),
                Expanded(
                  child: PricingCardWidget(
                    title: AppStaticStrings.weekly,
                    originalPrice: '\$16.99',
                    currentPrice: 'Only \$6.99',
                    unit: 'NZD/week Per Person',
                    isSelected: !isAnnual,
                    onTap: () => setState(() => isAnnual = false),
                  ),
                ),
              ],
            ),
            space8H,
            if (!isAnnual) const CoffeeInfoBoxWidget(),
            space8H,
            const SubscriptionFeaturesSectionWidget(),
            space8H,
            SubscriptionActionButton(isAnnual: isAnnual, onPressed: () {}),
            Text(
              isAnnual
                  ? 'Billed annually, auto-renewed'
                  : 'Then \$6.99 NZD per week, auto-renewed',
              style: const TextStyle(color: Colors.black45, fontSize: 12),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

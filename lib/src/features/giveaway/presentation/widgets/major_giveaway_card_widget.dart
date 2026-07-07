import 'dart:async';

import 'package:flutter_svg/svg.dart';

import '../../../../src_export.dart';

class MajorGiveawayCardWidget extends StatefulWidget {
  final GiveawayItem giveaway;
  const MajorGiveawayCardWidget({super.key, required this.giveaway});

  @override
  State<MajorGiveawayCardWidget> createState() => _MajorGiveawayCardWidgetState();
}

class _MajorGiveawayCardWidgetState extends State<MajorGiveawayCardWidget> {
  late Timer _timer;
  late DateTime _now;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _now = DateTime.now();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final diff = widget.giveaway.endDate.difference(_now);
    final isNegative = diff.isNegative;

    final String mo = isNegative ? '00' : (diff.inDays ~/ 30).toString().padLeft(2, '0');
    final String d = isNegative ? '00' : (diff.inDays % 30).toString().padLeft(2, '0');
    final String h = isNegative ? '00' : (diff.inHours % 24).toString().padLeft(2, '0');
    final String m = isNegative ? '00' : (diff.inMinutes % 60).toString().padLeft(2, '0');

    return Container(
      decoration: BoxDecoration(
        color: AppColors.kPrimaryDarkColor2,
        borderRadius: BorderRadius.circular(appRadius16),
        border: Border.all(color: AppColors.kPrimaryColor.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(appRadius16),
                ),
                child: CustomNetworkImage(
                  imageUrl: widget.giveaway.image,
                  height: 200,
                  width: double.infinity,
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.kPrimaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CustomText(
                    AppStaticStrings.majorGiveaway.tr,
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: AppPadding.getPadding12(context),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.kPrimaryColor.withValues(alpha: 0.8),
                  AppColors.kPrimaryDarkColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(appRadius16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.timer_outlined,
                          color: Colors.white,
                          size: 14,
                        ),
                        space8W,
                        CustomText(
                          "DRAW IN: Only $mo Months Away",
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ),
                space12H,
                // --- DYNAMIC MAJOR COUNTDOWN ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 12,
                  children: [
                    CountdownUnitWidget(value: mo, label: "MO"),
                    CountdownUnitWidget(value: d, label: "D"),
                    CountdownUnitWidget(value: h, label: "H"),
                    CountdownUnitWidget(value: m, label: "M"),
                  ],
                ),
                space12H,
                CustomText(
                  widget.giveaway.title,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                CustomText(
                  widget.giveaway.prizeDescription,
                  color: Colors.white70,
                  fontSize: 12,
                ),
                space12H,
                const CustomText(
                  "GRAND PRIZE",
                  color: AppColors.kPrimaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  widget.giveaway.title,
                  variant: TextVariant.headlineSmall,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                space8H,
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: CustomText(
                    "${AppStaticStrings.rrp.tr} \$${widget.giveaway.valueInNzd} nzd",
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                space12H,
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.kPrimaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppIcons.crown,
                            height: 20,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                          space8W,
                          Expanded(
                            child: CustomText(
                              AppStaticStrings.automaticEntryTitle.tr,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      space4H,
                      CustomText(
                        AppStaticStrings.automaticEntryDesc.tr,
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

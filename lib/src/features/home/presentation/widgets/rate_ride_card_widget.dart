import '../../../../src_export.dart';

class RateRideCardWidget extends StatefulWidget {
  final RideModel ride;
  final int index;
  const RateRideCardWidget({
    super.key,
    required this.ride,
    required this.index,
  });

  @override
  State<RateRideCardWidget> createState() => _RateRideCardWidgetState();
}

class _RateRideCardWidgetState extends State<RateRideCardWidget> {
  double _currentRating = 0;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.ride.myRating.toDouble();
  }

  @override
  void didUpdateWidget(covariant RateRideCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.ride.myRating != widget.ride.myRating) {
      _currentRating = widget.ride.myRating.toDouble();
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RateMyRideController>();
    final ride = widget.ride;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4F7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Image in 16:9 ratio with top rounded corners and User info overlay
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: CustomNetworkImage(
                    imageUrl: ride.image,
                    width: double.infinity,
                    radius: 0,
                  ),
                ),
                // Gradient overlay at top for text legibility
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.6),
                          Colors.transparent,
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.45, 1.0],
                      ),
                    ),
                  ),
                ),
                // User info overlay on top-left
                Positioned(
                  top: 12,
                  left: 12,
                  child: Row(
                    children: [
                      CustomNetworkImage(
                        imageUrl: ride.user.image,
                        height: 36,
                        width: 36,
                        radius: 99,
                      ),
                      space8W,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            ride.user.fullName,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          CustomText(
                            ride.user.memberNumber.startsWith('#')
                                ? ride.user.memberNumber
                                : "#${ride.user.memberNumber}",
                            color: AppColors.kPrimaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 2. Rating section below image
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  AppStaticStrings.yourRating.tr,
                  color: AppColors.kTextColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: AppColors.kPrimaryColor,
                    inactiveTrackColor: const Color(0xFFE2E8F0),
                    thumbColor: Colors.white,
                    overlayColor: AppColors.kPrimaryColor.withValues(
                      alpha: 0.12,
                    ),
                    trackHeight: 5,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 10,
                      elevation: 2,
                    ),
                  ),
                  child: Slider(
                    value: _currentRating,
                    min: 0,
                    max: 10,
                    divisions: 10,
                    onChanged: (v) {
                      setState(() {
                        _currentRating = v;
                      });
                    },
                    onChangeEnd: (v) {
                      controller.submitVote(widget.index, v.toInt());
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText("0", color: Colors.grey, fontSize: 11),
                    CustomText(
                      "${_currentRating.toInt()} / 10",
                      color: AppColors.kPrimaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                    const CustomText("10", color: Colors.grey, fontSize: 11),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

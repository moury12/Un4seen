import 'package:flutter_svg/flutter_svg.dart';
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
        color: AppColors.kPrimaryDarkColor3,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          CustomNetworkImage(
            imageUrl: ride.image,
            height: 450,
            width: double.infinity,
            radius: 16,
          ),

          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withAlpha(204)],
                ),
              ),
            ),
          ),
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(80),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  CustomNetworkImage(
                    imageUrl: ride.user.image,
                    height: 32,
                    width: 32,
                    radius: 99,
                  ),
                  // const CircleAvatar(
                  //   radius: 16,
                  //   backgroundImage: NetworkImage(
                  //     'https://i.pravatar.cc/150?u=jake',
                  //   ),
                  // ),
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
                        "${ride.user.memberNumber}",
                        color: AppColors.kPrimaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  CustomText(
                    "${ride.bikeModel} - ${ride.description}",
                    color: Colors.white,
                    fontSize: 13,
                    maxLines: 2,
                  ),
                  space12H,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        AppStaticStrings.yourRating.tr,
                        color: Colors.white,
                        fontSize: 11,
                      ),
                      Row(
                        children: List.generate(
                          ride.averageRating.ceil(),
                          (index) => Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: SvgPicture.asset(
                              AppIcons.fire,
                              height: 12,
                              colorFilter: const ColorFilter.mode(
                                AppColors.kPrimaryColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  space8H,
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: AppColors.kPrimaryColor,
                      inactiveTrackColor: Colors.white24,
                      thumbColor: Colors.white,
                      trackHeight: 4,
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
                      const CustomText(
                        "0",
                        color: Colors.white70,
                        fontSize: 10,
                      ),
                      CustomText(
                        "${_currentRating.toInt()} / 10",
                        color: AppColors.kPrimaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      const CustomText(
                        "10",
                        color: Colors.white70,
                        fontSize: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

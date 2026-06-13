import 'package:flutter_svg/svg.dart';

import '../../../../src_export.dart';

class BikeOfTheWeekWidget extends StatelessWidget {
  const BikeOfTheWeekWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      final homeData = controller.homeFeedData.value;
      if (homeData == null || homeData.bikeOfTheWeek == null) {
        return const SizedBox.shrink();
      }
      final ride = homeData.bikeOfTheWeek!;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.emoji_events_outlined,
                color: AppColors.kPrimaryColor,
                size: 22,
              ),
              space4W,
              CustomText(
                AppStaticStrings.bikeOfTheWeek.tr,
                variant: TextVariant.titleLarge,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          space12H,
          ClipPath(
            clipper: BikeOfTheWeekShapeClipper(radius: 16, slantAmount: 6),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.kPrimaryDarkColor.withValues(alpha: .5),
                border: Border.all(
                  color: AppColors.kPrimaryDarkColor2,
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  ClipPath(
                    clipper: BikeOfTheWeekShapeClipper(
                      radius: 16,
                      slantAmount: 6,
                    ),
                    child: CustomNetworkImage(
                      imageUrl: ride.image,
                      height: 200,
                      width: double.infinity,
                    ),
                  ),
                  Padding(
                    padding: AppPadding.getPadding12(context),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CustomNetworkImage(
                              imageUrl: ride.user.image,
                              height: 36,
                              width: 36,
                              radius: 99,
                            ),
                            space8W,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    "${ride.user.fullName} ${ride.user.memberNumber}",
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  CustomText(
                                    "${ride.rideType} • ${AppStaticStrings.customBuild.tr} ${ride.user.country}",
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ],
                              ),
                            ),
                            SvgPicture.asset(
                              AppIcons.fire,
                              height: 20,
                              colorFilter: const ColorFilter.mode(
                                AppColors.kPrimaryColor,
                                BlendMode.srcIn,
                              ),
                            ),
                            space4W,
                            CustomText(
                              "${ride.averageRating}",
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ],
                        ),
                        space12H,
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ButtonTapWidget(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.emoji_events,
                                    color: AppColors.kGoldColor,
                                    size: 16,
                                  ),
                                  space8W,
                                  CustomText(
                                    AppStaticStrings.bonusShredPointsAwarded.tr,
                                    color: AppColors.kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}

class BikeOfTheWeekShapeClipper extends CustomClipper<Path> {
  final double slantAmount;
  final double radius;

  BikeOfTheWeekShapeClipper({required this.slantAmount, required this.radius});

  @override
  Path getClip(Size size) {
    final path = Path();

    // ১. উপরের বাম কোণা থেকে শুরু
    path.moveTo(0, slantAmount + radius);
    path.quadraticBezierTo(0, slantAmount, radius, slantAmount);

    // ২. উপরের ডান কোণা (এটিকে আমরা নিচু করেছি slantAmount দিয়ে)
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);

    // ৩. নিচের ডান কোণা
    path.lineTo(size.width, size.height - radius);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - radius,
      size.height,
    );

    // ৪. নিচের বাম কোণা
    path.lineTo(radius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - radius);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

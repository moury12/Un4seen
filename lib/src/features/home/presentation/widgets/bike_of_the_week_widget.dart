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
          // ── Header Section ──────────────────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.emoji_events,
                color: AppColors.kPrimaryColor,
                size: 38,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Transform(
                      transform: Matrix4.skewX(-0.25),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.kPrimaryColor,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: const Text(
                          "WEEKLY WINNER ///",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                            fontSize: 10,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: "BIKE ",
                            style: TextStyle(
                              color: AppColors.kPrimaryColor,
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic,
                              fontSize: 22,
                              letterSpacing: -0.5,
                            ),
                          ),
                          TextSpan(
                            text: "OF THE WEEK",
                            style: TextStyle(
                              color: Color(0xFF0F172A),
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic,
                              fontSize: 22,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 28,
                width: 1.5,
                color: AppColors.kPrimaryColor.withValues(alpha: 0.6),
              ),
              const SizedBox(width: 6),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "REAL RIDES",
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 7.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                      height: 1.15,
                    ),
                  ),
                  Text(
                    "REAL PEOPLE",
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 7.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                      height: 1.15,
                    ),
                  ),
                  Text(
                    "UN4SEEN",
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 7.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                      height: 1.15,
                    ),
                  ),
                ],
              ),
            ],
          ),
          space8H,

          // ── Main Bike Card ──────────────────────────────────────────
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF6B9BBF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bike Image (16:9 with rounded corners)
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: CustomNetworkImage(
                      imageUrl: ride.image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // User Info Row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    children: [
                      ClipOval(
                        child: CustomNetworkImage(
                          imageUrl: ride.user.image,
                          height: 40,
                          width: 40,
                          radius: 99,
                          fit: BoxFit.cover,
                        ),
                      ),
                      space8W,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                              "${ride.user.fullName} ${ride.user.memberNumber}",
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            const SizedBox(height: 2),
                            CustomText(
                              "${ride.rideType} • ${AppStaticStrings.customBuild.tr} ${ride.user.country}",
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 11,
                            ),
                          ],
                        ),
                      ),
                      SvgPicture.asset(
                        AppIcons.fire,
                        height: 20,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFF00D2FF),
                          BlendMode.srcIn,
                        ),
                      ),
                      space4W,
                      CustomText(
                        "${ride.averageRating}",
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Bonus Shred Points Awarded Pill
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.emoji_events,
                        color: Color(0xFFF59E0B),
                        size: 18,
                      ),
                      space8W,
                      CustomText(
                        AppStaticStrings.bonusShredPointsAwarded.tr,
                        color: AppColors.kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

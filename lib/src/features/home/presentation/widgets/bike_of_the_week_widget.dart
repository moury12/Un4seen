import 'package:flutter_svg/svg.dart';

import '../../../../src_export.dart';

class BikeOfTheWeekWidget extends StatelessWidget {
  const BikeOfTheWeekWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
              border: Border.all(color: AppColors.kPrimaryDarkColor2, width: 1),
            ),
            child: Column(
              children: [
                ClipPath(
                  clipper: BikeOfTheWeekShapeClipper(
                    radius: 16,
                    slantAmount: 6,
                  ),
                  child: const CustomNetworkImage(
                    imageUrl:
                        'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?q=80&w=600',
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
                          const CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage(
                              'https://i.pravatar.cc/150?img=5',
                            ),
                          ),
                          space8W,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  "Jake Thompson #SYN-2847",
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                CustomText(
                                  "MX • ${AppStaticStrings.customBuild.tr} 🇳🇿 New Zealand",
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ],
                            ),
                          ),
                          SvgPicture.asset(
                            AppIcons.fire,
                            height: 20,
                            // colorFilter: ColorFilter.mode(
                            //   AppColors.kPrimaryColor,
                            //   BlendMode.srcIn,
                            // ),
                          ),
                          space4W,
                          CustomText(
                            "23",
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),

                          // CustomButton(
                          //   text: AppStaticStrings.follow.tr,
                          //   onPressed: () {},
                          //   isExpanding: false,
                          //   borderRadius: 20,
                          //   textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 10, fontWeight: FontWeight.bold),
                          // ),
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

import 'package:flutter_svg/flutter_svg.dart';
import '../../../../src_export.dart';

class RateRideCardWidget extends StatelessWidget {
  const RateRideCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kPrimaryDarkColor3,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          const CustomNetworkImage(
            imageUrl: 'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?q=80&w=600',
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
            child: Row(
              children: [
                const CircleAvatar(radius: 16, backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=jake')),
                space8W,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText("Jake Thompson 🇺🇸", color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                    CustomText("#SYN-2847  MX", color: AppColors.kPrimaryColor, fontSize: 10, fontWeight: FontWeight.bold),
                  ],
                ),
              ],
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
                  CustomText("2022 Yamaha YZ250f - Decals - Seat Cover", color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
                  space8H,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppIcons.fire, height: 20, colorFilter: const ColorFilter.mode(AppColors.kPrimaryColor, BlendMode.srcIn)),
                      space8W,
                      CustomText("46 ${AppStaticStrings.flames.tr}", color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                    ],
                  ),
                  space12H,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(AppStaticStrings.yourRating.tr, color: Colors.white, fontSize: 11),
                      Row(
                        children: List.generate(4, (index) => Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: SvgPicture.asset(AppIcons.fire, height: 12, colorFilter: const ColorFilter.mode(AppColors.kPrimaryColor, BlendMode.srcIn)),
                        )),
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
                    child: Slider(value: 0.4, onChanged: (v) {}),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText("0", color: Colors.white70, fontSize: 10),
                      CustomText("4 / 10", color: AppColors.kPrimaryColor, fontSize: 12, fontWeight: FontWeight.bold),
                      CustomText("10", color: Colors.white70, fontSize: 10),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 12,
            top: 200,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(color: Colors.black45, shape: BoxShape.circle),
              child: const Icon(Icons.chevron_right, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

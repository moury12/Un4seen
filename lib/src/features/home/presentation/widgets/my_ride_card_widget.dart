import 'package:flutter_svg/flutter_svg.dart';
import '../../../../src_export.dart';

class MyRideCardWidget extends StatelessWidget {
  final RideModel ride;
  final int index;

  const MyRideCardWidget({
    super.key,
    required this.ride,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RateMyRideController>();

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
            right: 12,
            child: IconButton(
              onPressed: () {
                _showDeleteDialog(context, controller);
              },
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              style: IconButton.styleFrom(
                backgroundColor: Colors.black.withAlpha(80),
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
                      const CustomText(
                        "Average Rating",
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
                  CustomText(
                    "${ride.averageRating.toStringAsFixed(1)} / 10",
                    color: AppColors.kPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, RateMyRideController controller) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Ride"),
          content: const Text("Are you sure you want to delete this ride?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                controller.deleteMyRide(ride.id);
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}

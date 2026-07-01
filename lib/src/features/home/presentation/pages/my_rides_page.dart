import '../../../../src_export.dart';
import '../widgets/my_ride_card_widget.dart';

class MyRidesPage extends StatefulWidget {
  const MyRidesPage({super.key});

  @override
  State<MyRidesPage> createState() => _MyRidesPageState();
}

class _MyRidesPageState extends State<MyRidesPage> {
  final controller = Get.find<RateMyRideController>();

  @override
  void initState() {
    super.initState();
    controller.fetchMyRides();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("My Ride Uploads"),
      ),
      body: Obx(() {
        if (controller.isMyRidesLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (controller.myRides.isEmpty) {
          return Center(child: CustomText("No rides uploaded yet.", color: AppColors.kTextColor));
        }

        return ListView.builder(
          padding: AppPadding.getPadding12(context),
          itemCount: controller.myRides.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: MyRideCardWidget(
                ride: controller.myRides[index],
                index: index,
              ),
            );
          },
        );
      }),
    );
  }
}

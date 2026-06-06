import 'dart:async';
import 'package:get/get.dart';
import '../../../../core/services/api_service.dart';
import '../../data/models/giveaway_page_model.dart';

class GiveawayController extends GetxController {
  final ApiService _api = Get.find<ApiService>();
  Timer? _timer;

  final RxBool isLoading = false.obs;
  final Rxn<GiveawayPageModel> pageData = Rxn<GiveawayPageModel>();

  // Observables for Weekly Countdown
  final weeklyDays = '00'.obs;
  final weeklyHours = '00'.obs;
  final weeklyMins = '00'.obs;
  final weeklySecs = '00'.obs;

  // Observables for Major Countdown
  final majorMonths = '00'.obs;
  final majorDays = '00'.obs;
  final majorHours = '00'.obs;
  final majorMins = '00'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPageData();
  }

  Future<void> fetchPageData() async {
    try {
      isLoading.value = true;
      final response = await _api.get('/giveaways/page-data');
      if (response.data['success']) {
        pageData.value = GiveawayPageModel.fromJson(response.data['data']);
        _startCountdownLogic();
      }
    } catch (e) {
      print('❌ Error fetching giveaways: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _startCountdownLogic() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();

      // 1. Weekly Logic
      if (pageData.value?.currentWeekly != null) {
        _updateTimerValues(
          pageData.value!.currentWeekly!.endDate.difference(now),
          isWeekly: true,
        );
      }

      // 2. Major Logic (Taking the first major giveaway in list)
      if (pageData.value?.majorGiveaways.isNotEmpty ?? false) {
        _updateTimerValues(
          pageData.value!.majorGiveaways.first.endDate.difference(now),
          isWeekly: false,
        );
      }
    });
  }

  void _updateTimerValues(Duration diff, {required bool isWeekly}) {
    if (diff.isNegative) {
      if (isWeekly) {
        weeklyDays.value = '00';
        weeklyHours.value = '00';
        weeklyMins.value = '00';
        weeklySecs.value = '00';
      } else {
        majorMonths.value = '00';
        majorDays.value = '00';
        majorHours.value = '00';
        majorMins.value = '00';
      }
      return;
    }

    if (isWeekly) {
      weeklyDays.value = diff.inDays.toString().padLeft(2, '0');
      weeklyHours.value = (diff.inHours % 24).toString().padLeft(2, '0');
      weeklyMins.value = (diff.inMinutes % 60).toString().padLeft(2, '0');
      weeklySecs.value = (diff.inSeconds % 60).toString().padLeft(2, '0');
    } else {
      // Simplified: showing months as roughly days / 30
      majorMonths.value = (diff.inDays ~/ 30).toString().padLeft(2, '0');
      majorDays.value = (diff.inDays % 30).toString().padLeft(2, '0');
      majorHours.value = (diff.inHours % 24).toString().padLeft(2, '0');
      majorMins.value = (diff.inMinutes % 60).toString().padLeft(2, '0');
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}

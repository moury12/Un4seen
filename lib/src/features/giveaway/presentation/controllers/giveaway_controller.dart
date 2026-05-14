import 'dart:async';
import 'package:get/get.dart';

class GiveawayController extends GetxController {
  Timer? _timer;

  // Weekly Timer Observables
  final weeklyDays = '00'.obs;
  final weeklyHours = '00'.obs;
  final weeklyMins = '00'.obs;
  final weeklySecs = '00'.obs;

  // Major Timer Observables (e.g., 3 months away)
  final majorMonths = '03'.obs;
  final majorDays = '00'.obs;
  final majorHours = '00'.obs;
  final majorMins = '00'.obs;

  @override
  void onInit() {
    super.onInit();
    _startCountdown();
  }

  void _startCountdown() {
    // Example Target Date: 3 Days, 14 Hours, 32 Mins, 42 Seconds from now
    DateTime targetDate = DateTime.now().add(
      const Duration(days: 3, hours: 14, minutes: 32, seconds: 42),
    );

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      final difference = targetDate.difference(now);

      if (difference.isNegative) {
        timer.cancel();
        _resetWeeklyToZero();
      } else {
        weeklyDays.value = difference.inDays.toString().padLeft(2, '0');
        weeklyHours.value = (difference.inHours % 24).toString().padLeft(2, '0');
        weeklyMins.value = (difference.inMinutes % 60).toString().padLeft(2, '0');
        weeklySecs.value = (difference.inSeconds % 60).toString().padLeft(2, '0');
        
        // Major Giveaway mock update (slower calculation usually)
        majorDays.value = (difference.inDays % 30).toString().padLeft(2, '0');
        majorHours.value = (difference.inHours % 24).toString().padLeft(2, '0');
        majorMins.value = (difference.inMinutes % 60).toString().padLeft(2, '0');
      }
    });
  }

  void _resetWeeklyToZero() {
    weeklyDays.value = '00';
    weeklyHours.value = '00';
    weeklyMins.value = '00';
    weeklySecs.value = '00';
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}

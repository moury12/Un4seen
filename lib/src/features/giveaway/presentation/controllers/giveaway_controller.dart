import 'dart:async';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;
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

  static const String _nzTz = 'Pacific/Auckland';
  late final tz.Location _nzLocation;

  @override
  void onInit() {
    super.onInit();
    // Initialize timezone database and get NZ location once
    tz_data.initializeTimeZones();
    _nzLocation = tz.getLocation(_nzTz);
    fetchPageData();
  }

  Future<void> fetchPageData() async {
    try {
      isLoading.value = true;
      final response = await _api.get('/giveaways/page-data');
      if (response.data['success']) {
        pageData.value = GiveawayPageModel.fromJson(response.data['data']);
        // Calculate initial values immediately (do not wait for first timer tick)
        _calculateCountdowns();
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
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _calculateCountdowns();
    });
  }

  void _calculateCountdowns() {
    // "Now" expressed in Pacific/Auckland — this accounts for NZ DST automatically.
    final tz.TZDateTime nowNz = tz.TZDateTime.now(_nzLocation);

    // 1. Weekly Logic
    if (pageData.value?.currentWeekly != null) {
      final DateTime endUtc = pageData.value!.currentWeekly!.endDate;
      // Convert the stored UTC instant into a NZ TZDateTime so the
      // difference is computed in the same timezone frame.
      final tz.TZDateTime endNz = tz.TZDateTime.from(endUtc, _nzLocation);
      _updateWeekly(endNz.difference(nowNz));
    }

    // 2. Major Logic
    if (pageData.value?.majorGiveaways.isNotEmpty ?? false) {
      final DateTime endUtc = pageData.value!.majorGiveaways.first.endDate;
      final tz.TZDateTime endNz = tz.TZDateTime.from(endUtc, _nzLocation);
      _updateMajor(nowNz, endNz);
    }
  }

  // ── Weekly Countdown ────────────────────────────────────────────────────────

  void _updateWeekly(Duration diff) {
    if (diff.isNegative || diff == Duration.zero) {
      weeklyDays.value = '00';
      weeklyHours.value = '00';
      weeklyMins.value = '00';
      weeklySecs.value = '00';
      return;
    }
    weeklyDays.value = diff.inDays.toString().padLeft(2, '0');
    weeklyHours.value = (diff.inHours % 24).toString().padLeft(2, '0');
    weeklyMins.value = (diff.inMinutes % 60).toString().padLeft(2, '0');
    weeklySecs.value = (diff.inSeconds % 60).toString().padLeft(2, '0');
  }

  // ── Major Countdown (calendar-aware months) ─────────────────────────────────

  void _updateMajor(tz.TZDateTime nowNz, tz.TZDateTime endNz) {
    if (!endNz.isAfter(nowNz)) {
      majorMonths.value = '00';
      majorDays.value = '00';
      majorHours.value = '00';
      majorMins.value = '00';
      return;
    }

    // Calendar-accurate month difference (does not assume 30-day months)
    int months = (endNz.year - nowNz.year) * 12 + (endNz.month - nowNz.month);

    // The "same date" in 'months' calendar months from now
    tz.TZDateTime afterMonths = _addMonths(nowNz, months);

    // If advancing by 'months' months overshoots the end, step back one month
    if (afterMonths.isAfter(endNz)) {
      months--;
      afterMonths = _addMonths(nowNz, months);
    }

    final Duration remaining = endNz.difference(afterMonths);
    final int days = remaining.inDays;
    final int hours = remaining.inHours % 24;
    final int mins = remaining.inMinutes % 60;

    majorMonths.value = months.clamp(0, 99).toString().padLeft(2, '0');
    majorDays.value = days.clamp(0, 99).toString().padLeft(2, '0');
    majorHours.value = hours.clamp(0, 23).toString().padLeft(2, '0');
    majorMins.value = mins.clamp(0, 59).toString().padLeft(2, '0');
  }

  /// Adds [months] calendar months to [dt], clamping the day to the last valid
  /// day of the resulting month (e.g. Jan 31 + 1 month → Feb 28/29).
  tz.TZDateTime _addMonths(tz.TZDateTime dt, int months) {
    int year = dt.year;
    int month = dt.month + months;
    while (month > 12) {
      month -= 12;
      year++;
    }
    while (month < 1) {
      month += 12;
      year--;
    }
    final int lastDay = DateTime(year, month + 1, 0).day;
    final int day = dt.day.clamp(1, lastDay);
    return tz.TZDateTime(
      _nzLocation,
      year,
      month,
      day,
      dt.hour,
      dt.minute,
      dt.second,
    );
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}

import '../home_export.dart';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:un4seen/src/core/services/api_service.dart';
import 'package:un4seen/src/features/home/data/models/ride_model.dart';
import 'package:un4seen/src/features/giveaway/data/models/giveaway_page_model.dart';

// ── Models ─────────────────────────────────────────────────

class HomeFeedUser {
  final String fullName;
  final String image;
  final bool isSyndicateMember;

  HomeFeedUser({
    required this.fullName,
    required this.image,
    required this.isSyndicateMember,
  });

  factory HomeFeedUser.fromJson(Map<String, dynamic> json) {
    return HomeFeedUser(
      fullName: json['fullName'] ?? '',
      image: json['image'] ?? '',
      isSyndicateMember: json['isSyndicateMember'] ?? false,
    );
  }
}

class ThisWeekStats {
  final int pointsEarned;
  final int newStoriesPosted;

  ThisWeekStats({
    required this.pointsEarned,
    required this.newStoriesPosted,
  });

  factory ThisWeekStats.fromJson(Map<String, dynamic> json) {
    return ThisWeekStats(
      pointsEarned: json['pointsEarned'] ?? 0,
      newStoriesPosted: json['newStoriesPosted'] ?? 0,
    );
  }
}

class HomeFeedModel {
  final HomeFeedUser? user;
  final GiveawayItem? weeklyGiveaway;
  final RideModel? bikeOfTheWeek;
  final GiveawayItem? majorGiveaway;
  final List<GiveawayItem> recentWinners;
  final ThisWeekStats? thisWeekStats;

  HomeFeedModel({
    this.user,
    this.weeklyGiveaway,
    this.bikeOfTheWeek,
    this.majorGiveaway,
    required this.recentWinners,
    this.thisWeekStats,
  });

  factory HomeFeedModel.fromJson(Map<String, dynamic> json) {
    return HomeFeedModel(
      user: json['user'] != null ? HomeFeedUser.fromJson(json['user']) : null,
      weeklyGiveaway: json['weeklyGiveaway'] != null ? GiveawayItem.fromJson(json['weeklyGiveaway']) : null,
      bikeOfTheWeek: json['bikeOfTheWeek'] != null ? RideModel.fromJson(json['bikeOfTheWeek']) : null,
      majorGiveaway: json['majorGiveaway'] != null ? GiveawayItem.fromJson(json['majorGiveaway']) : null,
      recentWinners: (json['recentWinners'] as List?)
              ?.map((e) => GiveawayItem.fromJson(e))
              .toList() ??
          [],
      thisWeekStats: json['thisWeekStats'] != null ? ThisWeekStats.fromJson(json['thisWeekStats']) : null,
    );
  }
}

// ── DataSource ────────────────────────────────────────────
abstract class HomeRemoteDataSource {
  Future<HomeFeedModel> getHomeFeed();
  Future<String> getTodayQuote();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiService _api = Get.find<ApiService>();

  @override
  Future<HomeFeedModel> getHomeFeed() async {
    final response = await _api.get('/user/home-feed');
    if (response.data['success'] == true) {
      return HomeFeedModel.fromJson(response.data['data']);
    } else {
      throw Exception(response.data['message'] ?? 'Failed to fetch home feed');
    }
  }

  @override
  Future<String> getTodayQuote() async {
    try {
      final response = await _api.get('/motivational-quotes/today');
      if (response.data['success'] == true && response.data['data'] != null) {
        return response.data['data']['text'] ?? '';
      }
    } catch (e) {
      // Return empty string on failure to let the UI fallback
    }
    return '';
  }
}

// ── Repository abstract ───────────────────────────────────
abstract class HomeRepository {
  Future<HomeFeedModel> getHomeFeed();
  Future<String> getTodayQuote();
}

// ── Repository impl ───────────────────────────────────────
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<HomeFeedModel> getHomeFeed() {
    return remoteDataSource.getHomeFeed();
  }

  @override
  Future<String> getTodayQuote() {
    return remoteDataSource.getTodayQuote();
  }
}

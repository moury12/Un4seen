class PointsDashboardModel {
  final UserStats userStats;
  final DailyLogin dailyLogin;
  final ProfileCompletion profileCompletion;
  final List<CommunityMilestone> communityMilestones;
  final List<IndividualMilestone> individualMilestones;
  final List<RecentActivity> recentActivity;

  PointsDashboardModel({
    required this.userStats,
    required this.dailyLogin,
    required this.profileCompletion,
    required this.communityMilestones,
    required this.individualMilestones,
    required this.recentActivity,
  });

  factory PointsDashboardModel.fromJson(Map<String, dynamic> json) {
    return PointsDashboardModel(
      userStats: UserStats.fromJson(json['userStats']),
      dailyLogin: DailyLogin.fromJson(json['dailyLogin']),
      profileCompletion: ProfileCompletion.fromJson(json['profileCompletion']),
      communityMilestones: (json['communityMilestones'] as List)
          .map((e) => CommunityMilestone.fromJson(e))
          .toList(),
      individualMilestones: (json['individualMilestones'] as List)
          .map((e) => IndividualMilestone.fromJson(e))
          .toList(),
      recentActivity: (json['recentActivity'] as List)
          .map((e) => RecentActivity.fromJson(e))
          .toList(),
    );
  }
}

class UserStats {
  final int totalPoints;
  final String memberNumber;
  final String fullName;
  final String referralCode;

  UserStats({required this.totalPoints, required this.memberNumber, required this.fullName, required this.referralCode});

  factory UserStats.fromJson(Map<String, dynamic> json) {
    return UserStats(
      totalPoints: json['totalPoints'] ?? 0,
      memberNumber: json['memberNumber'] ?? '',
      fullName: json['fullName'] ?? '',
      referralCode: json['referralCode'] ?? '',
    );
  }
}

class DailyLogin {
  final bool canClaimDaily;
  final int points;
  DailyLogin({required this.canClaimDaily, required this.points});
  factory DailyLogin.fromJson(Map<String, dynamic> json) => DailyLogin(canClaimDaily: json['canClaimDaily'] ?? false, points: json['points'] ?? 0);
}

class ProfileCompletion {
  final bool isComplete;
  final bool isClaimed;
  final int points;
  ProfileCompletion({required this.isComplete, required this.isClaimed, required this.points});
  factory ProfileCompletion.fromJson(Map<String, dynamic> json) => ProfileCompletion(isComplete: json['isComplete'] ?? false, isClaimed: json['isClaimed'] ?? false, points: json['points'] ?? 0);
}

class CommunityMilestone {
  final String id;
  final String title;
  final String description;
  final String image;
  final double progress;
  final bool isUnlocked;
  final bool isClaimed;

  CommunityMilestone({required this.id, required this.title, required this.description, required this.image, required this.progress, required this.isUnlocked, required this.isClaimed});

  factory CommunityMilestone.fromJson(Map<String, dynamic> json) {
    return CommunityMilestone(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      progress: double.tryParse(json['progress'].toString()) ?? 0.0,
      isUnlocked: json['isUnlocked'] ?? false,
      isClaimed: json['isClaimed'] ?? false,
    );
  }
}

class IndividualMilestone {
  final String id;
  final String title;
  final String description;
  final double progress;
  final int pointsRequired;
  final bool isUnlocked;
  final bool isClaimed;

  IndividualMilestone({required this.id, required this.title, required this.description, required this.progress, required this.pointsRequired, required this.isUnlocked, required this.isClaimed});

  factory IndividualMilestone.fromJson(Map<String, dynamic> json) {
    return IndividualMilestone(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      progress: (double.tryParse(json['progress'].toString()) ?? 0.0) / 100,
      pointsRequired: json['pointsRequired'] ?? 0,
      isUnlocked: json['isUnlocked'] ?? false,
      isClaimed: json['isClaimed'] ?? false,
    );
  }
}

class RecentActivity {
  final String description;
  final int points;
  final String createdAt;

  RecentActivity({required this.description, required this.points, required this.createdAt});

  factory RecentActivity.fromJson(Map<String, dynamic> json) {
    return RecentActivity(
      description: json['description'] ?? '',
      points: json['points'] ?? 0,
      createdAt: json['createdAt'] ?? '',
    );
  }
}
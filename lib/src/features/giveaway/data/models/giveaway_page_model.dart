class GiveawayPageModel {
  final GiveawayItem? currentWeekly;
  final List<GiveawayItem> majorGiveaways;
  final List<GiveawayItem> upcoming;

  GiveawayPageModel({
    this.currentWeekly,
    required this.majorGiveaways,
    required this.upcoming,
  });

  factory GiveawayPageModel.fromJson(Map<String, dynamic> json) {
    return GiveawayPageModel(
      currentWeekly: json['currentWeekly'] != null
          ? GiveawayItem.fromJson(json['currentWeekly'])
          : null,
      majorGiveaways:
          (json['majorGiveaway'] as List?)
              ?.map((e) => GiveawayItem.fromJson(e))
              .toList() ??
          [],
      upcoming:
          (json['upcoming'] as List?)
              ?.map((e) => GiveawayItem.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class GiveawayWinner {
  final String id;
  final String fullName;
  final String memberNumber;
  final String image;

  GiveawayWinner({
    required this.id,
    required this.fullName,
    required this.memberNumber,
    required this.image,
  });

  factory GiveawayWinner.fromJson(Map<String, dynamic> json) {
    return GiveawayWinner(
      id: json['_id'] ?? '',
      fullName: "${json['firstName'] ?? ''} ${json['lastName'] ?? ''}".trim(),
      memberNumber: json['memberNumber'] ?? '',
      image: json['image'] ?? '',
    );
  }
}

class GiveawayItem {
  final String id;
  final int weekNumber;
  final String title;
  final String prizeDescription;
  final String image;
  final num valueInNzd;
  final DateTime endDate;
  final bool isMajorGiveaway;
  final GiveawayWinner? winner;

  GiveawayItem({
    required this.id,
    required this.weekNumber,
    required this.title,
    required this.prizeDescription,
    required this.image,
    required this.valueInNzd,
    required this.endDate,
    required this.isMajorGiveaway,
    this.winner,
  });

  factory GiveawayItem.fromJson(Map<String, dynamic> json) {
    return GiveawayItem(
      id: json['_id'] ?? '',
      weekNumber: json['weekNumber'] ?? 0,
      title: json['title'] ?? '',
      prizeDescription: json['prizeDescription'] ?? '',
      image: json['image'] ?? '',
      valueInNzd: json['valueInNzd'] ?? 0,
      endDate: DateTime.parse(
        json['endDate'] ?? DateTime.now().toIso8601String(),
      ),
      isMajorGiveaway: json['isMajorGiveaway'] ?? false,
      winner: json['winner'] != null ? GiveawayWinner.fromJson(json['winner']) : null,
    );
  }
}

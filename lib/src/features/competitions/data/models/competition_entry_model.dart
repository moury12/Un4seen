class CompetitionEntryModel {
  final String id;
  final String competitionId;
  final EntryUser user;
  final String designName;
  final String image;
  int heartCount;
  bool isHearted;

  CompetitionEntryModel({
    required this.id,
    required this.competitionId,
    required this.user,
    required this.designName,
    required this.image,
    required this.heartCount,
    required this.isHearted,
  });

  factory CompetitionEntryModel.fromJson(Map<String, dynamic> json) {
    return CompetitionEntryModel(
      id: json['_id'] ?? '',
      competitionId: json['competition'] ?? '',
      designName: json['designName'] ?? '',
      image: json['image'] ?? '',
      heartCount: json['heartCount'] ?? 0,
      isHearted: json['isHearted'] ?? false,
      user: EntryUser.fromJson(json['user'] ?? {}),
    );
  }
}

class EntryUser {
  final String id;
  final String fullName;
  final String memberNumber;
  final String image;

  EntryUser({
    required this.id,
    required this.fullName,
    required this.memberNumber,
    required this.image,
  });

  factory EntryUser.fromJson(Map<String, dynamic> json) {
    return EntryUser(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? 'Unknown',
      memberNumber: json['memberNumber'] ?? '',
      image: json['image'] ?? '',
    );
  }
}

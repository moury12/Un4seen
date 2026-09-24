class AnnouncementModel {
  final String id;
  final AnnouncementUser user;
  final String content;
  final String contentType;
  final AnnouncementMusic? music;
  final String title;
  final String caption;
  final List<String> hearts;
  int heartCount;
  final bool isPremium;
  final bool isDeleted;
  final String? expiresAt;
  final String? createdAt;
  final String? updatedAt;
  final bool isOwnStory;
  final bool isOwnAnnouncement;
  bool isHearted;
  bool isSaved;
  final String timeAgo;

  AnnouncementModel({
    required this.id,
    required this.user,
    required this.content,
    required this.contentType,
    this.music,
    required this.title,
    required this.caption,
    required this.hearts,
    required this.heartCount,
    required this.isPremium,
    required this.isDeleted,
    this.expiresAt,
    this.createdAt,
    this.updatedAt,
    required this.isOwnStory,
    required this.isOwnAnnouncement,
    required this.isHearted,
    required this.isSaved,
    required this.timeAgo,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> userJson =
        (json['user'] != null && json['user'] is Map)
        ? Map<String, dynamic>.from(json['user'])
        : {};

    final Map<String, dynamic>? musicJson =
        (json['music'] != null && json['music'] is Map)
        ? Map<String, dynamic>.from(json['music'])
        : null;

    final List<String> parsedHearts = [];
    if (json['hearts'] != null && json['hearts'] is List) {
      for (var item in json['hearts']) {
        if (item != null) parsedHearts.add(item.toString());
      }
    }

    return AnnouncementModel(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      user: AnnouncementUser.fromJson(userJson),
      content: json['content']?.toString() ?? '',
      contentType: json['contentType']?.toString() ?? 'image',
      music: musicJson != null ? AnnouncementMusic.fromJson(musicJson) : null,
      title: json['title']?.toString() ?? '',
      caption: json['caption']?.toString() ?? '',
      hearts: parsedHearts,
      heartCount: json['heartCount'] is int
          ? json['heartCount']
          : int.tryParse(json['heartCount']?.toString() ?? '') ?? 0,
      isPremium: json['isPremium'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      expiresAt: json['expiresAt']?.toString(),
      createdAt: json['createdAt']?.toString(),
      updatedAt: json['updatedAt']?.toString(),
      isOwnStory: json['isOwnStory'] ?? false,
      isOwnAnnouncement: json['isOwnAnnouncement'] ?? false,
      isHearted: json['isHearted'] ?? false,
      isSaved: json['isSaved'] ?? false,
      timeAgo: json['timeAgo']?.toString() ?? '',
    );
  }
}

class AnnouncementUser {
  final String id;
  final String firstName;
  final String lastName;
  final String fullName;
  final String role;
  final String memberNumber;
  final String image;

  AnnouncementUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.role,
    required this.memberNumber,
    required this.image,
  });

  factory AnnouncementUser.fromJson(Map<String, dynamic> json) {
    final String fName = json['firstName']?.toString() ?? '';
    final String lName = json['lastName']?.toString() ?? '';
    final String computedFullName =
        json['fullName']?.toString() ?? "$fName $lName".trim();

    return AnnouncementUser(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      firstName: fName,
      lastName: lName,
      fullName: computedFullName.isNotEmpty
          ? computedFullName
          : "Un4seen Admin",
      role: json['role']?.toString() ?? '',
      memberNumber: json['memberNumber']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
    );
  }
}

class AnnouncementMusic {
  final String id;
  final String title;
  final String audioUrl;
  final String category;

  AnnouncementMusic({
    required this.id,
    required this.title,
    required this.audioUrl,
    required this.category,
  });

  factory AnnouncementMusic.fromJson(Map<String, dynamic> json) {
    return AnnouncementMusic(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      audioUrl: json['audioUrl']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
    );
  }
}

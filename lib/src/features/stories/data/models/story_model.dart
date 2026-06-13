class StoryModel {
  final String id;
  final StoryUser user;
  final String content;
  final String contentType;
  final StoryMusic? music;
  final String category;
  final int heartCount;
  final bool isHearted;
  final bool isSaved;
  final String timeAgo;

  StoryModel({
    required this.id,
    required this.user,
    required this.content,
    required this.contentType,
    this.music,
    required this.category,
    required this.heartCount,
    required this.isHearted,
    required this.isSaved,
    required this.timeAgo,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      id: json['_id'] ?? '',
      content: json['content'] ?? '',
      contentType: json['contentType'] ?? 'image',
      category: json['category'] ?? 'Bikes',
      heartCount: json['heartCount'] ?? 0,
      isHearted: json['isHearted'] ?? false,
      isSaved: json['isSaved'] ?? false,
      timeAgo: json['timeAgo'] ?? 'Just now',
      user: StoryUser.fromJson(json['user'] ?? {}),
      music: json['music'] != null ? StoryMusic.fromJson(json['music']) : null,
    );
  }
}

class StoryUser {
  final String id;
  final String fullName;
  final String memberNumber;
  final String image;

  StoryUser({required this.id, required this.fullName, required this.memberNumber, required this.image});

  factory StoryUser.fromJson(Map<String, dynamic> json) {
    return StoryUser(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? (json['firstName'] != null ? "${json['firstName']} ${json['lastName']}" : "Unknown"),
      memberNumber: json['memberNumber'] ?? '',
      image: json['image'] ?? '',
    );
  }
}

class StoryMusic {
  final String title;
  final String audioUrl;

  StoryMusic({required this.title, required this.audioUrl});

  factory StoryMusic.fromJson(Map<String, dynamic> json) {
    return StoryMusic(
      title: json['title'] ?? '',
      audioUrl: json['audioUrl'] ?? '',
    );
  }
}
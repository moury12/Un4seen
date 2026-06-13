class StoryModel {
  final String id;
  final StoryUser user;
  final String content;
  final String contentType;
  final StoryMusic? music;
  final String category;
  int heartCount;
  bool isHearted;
  bool isSaved;
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
    // Handle nested story object if coming from "my-saved" endpoint
    final Map<String, dynamic> data = json.containsKey('story') ? json['story'] : json;
    
    return StoryModel(
      id: data['_id'] ?? '',
      content: data['content'] ?? '',
      contentType: data['contentType'] ?? 'image',
      category: data['category'] ?? 'Bikes',
      heartCount: data['heartCount'] ?? 0,
      isHearted: data['isHearted'] ?? false,
      isSaved: data['isSaved'] ?? false,
      timeAgo: json['timeAgo'] ?? 'Just now',
      user: StoryUser.fromJson(data['user'] ?? {}),
      music: data['music'] != null ? StoryMusic.fromJson(data['music']) : null,
    );
  }
}
// ... StoryUser and StoryMusic classes stay the same
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
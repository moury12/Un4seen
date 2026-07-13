class StoryModel {
  final String id;
  final StoryUser user;
  final String content;
  final String contentType;
  final StoryMusic? music;
  final String category;
  int heartCount;
  bool isHearted;
  bool isOwnStory;
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
    required this.isOwnStory,
    required this.timeAgo,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    // 1. Identify if the data is nested (for "my-saved" endpoint)
    // We check if 'story' exists and is actually a Map
    final bool hasNestedStory = json['story'] != null && json['story'] is Map;
    
    // 2. Safely extract the Map. If nested, use json['story'], otherwise use the root json.
    final Map<String, dynamic> data = hasNestedStory 
        ? Map<String, dynamic>.from(json['story']) 
        : json;

    return StoryModel(
      // Use ?.toString() and ?? '' to prevent any Null type errors
      id: data['_id']?.toString() ?? json['_id']?.toString() ?? '',
      content: data['content']?.toString() ?? '',
      contentType: data['contentType']?.toString() ?? 'image',
      category: data['category']?.toString() ?? 'Bikes',
      heartCount: data['heartCount'] is int ? data['heartCount'] : 0,
      
      // In saved stories, these flags are at the root level (json), not inside 'story' (data)
      isHearted: json['isHearted'] ?? data['isHearted'] ?? false,
      isOwnStory: json['isOwnStory'] ?? data['isOwnStory'] ?? false,
      isSaved: json['isSaved'] ?? data['isSaved'] ?? hasNestedStory, 
      
      // Pick timeAgo from the root json first, then fallback to nested data
      timeAgo: json['timeAgo']?.toString() ?? data['timeAgo']?.toString() ?? 'Just now',
      
      // Handle User object safely
      user: StoryUser.fromJson(
        (data['user'] != null && data['user'] is Map) 
            ? Map<String, dynamic>.from(data['user']) 
            : {}
      ),
      
      // Handle Music object safely
      music: (data['music'] != null && data['music'] is Map)
          ? StoryMusic.fromJson(Map<String, dynamic>.from(data['music']))
          : null,
    );
  }
}

class StoryUser {
  final String id;
  final String fullName;
  final String memberNumber;
  final String image;

  StoryUser({
    required this.id, 
    required this.fullName, 
    required this.memberNumber, 
    required this.image
  });

  factory StoryUser.fromJson(Map<String, dynamic> json) {
    // Check for nested name structure (firstName/lastName) vs fullName
    String name = "Unknown";
    if (json['fullName'] != null) {
      name = json['fullName'];
    } else if (json['firstName'] != null) {
      name = "${json['firstName']} ${json['lastName'] ?? ''}".trim();
    }

    return StoryUser(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      fullName: name,
      memberNumber: json['memberNumber']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
    );
  }
}

class StoryMusic {
  final String title;
  final String audioUrl;

  StoryMusic({required this.title, required this.audioUrl});

  factory StoryMusic.fromJson(Map<String, dynamic> json) {
    return StoryMusic(
      title: json['title']?.toString() ?? '',
      audioUrl: json['audioUrl']?.toString() ?? '',
    );
  }
}
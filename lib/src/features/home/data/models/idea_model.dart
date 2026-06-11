import 'ride_model.dart';

class IdeaFeedModel {
  final List<IdeaModel> result;
  final PaginationMeta meta;

  IdeaFeedModel({required this.result, required this.meta});

  factory IdeaFeedModel.fromJson(Map<String, dynamic> json) {
    return IdeaFeedModel(
      result: (json['result'] as List).map((e) => IdeaModel.fromJson(e)).toList(),
      meta: PaginationMeta.fromJson(json['meta']),
    );
  }
}

class IdeaModel {
  final String id;
  final IdeaUser user;
  final String title;
  final String description;
  final String category;
  int upvoteCount;
  bool isUpvoted;
  final String createdAt;

  IdeaModel({
    required this.id,
    required this.user,
    required this.title,
    required this.description,
    required this.category,
    required this.upvoteCount,
    required this.isUpvoted,
    required this.createdAt,
  });

  factory IdeaModel.fromJson(Map<String, dynamic> json) {
    return IdeaModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      upvoteCount: json['upvoteCount'] ?? 0,
      isUpvoted: json['isUpvoted'] ?? false,
      createdAt: json['createdAt'] ?? '',
      user: IdeaUser.fromJson(json['user'] ?? {}),
    );
  }
}

class IdeaUser {
  final String fullName;
  final String image;

  IdeaUser({required this.fullName, required this.image});

  factory IdeaUser.fromJson(Map<String, dynamic> json) {
    return IdeaUser(
      fullName: "${json['firstName'] ?? ''} ${json['lastName'] ?? ''}".trim(),
      image: json['image'] ?? '',
    );
  }
}

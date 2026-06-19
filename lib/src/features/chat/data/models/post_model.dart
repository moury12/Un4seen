// lib/src/features/chat/data/models/post_model.dart

import 'dart:convert';

import 'package:get/get.dart';

class PostFeedResponse {
  final List<PostModel> result;
  final int totalPage;
  final int page;

  PostFeedResponse({required this.result, required this.totalPage, required this.page});

  factory PostFeedResponse.fromJson(Map<String, dynamic> json) {
    return PostFeedResponse(
      page: json['meta']['page'] ?? 1,
      totalPage: json['meta']['totalPage'] ?? 1,
      result: (json['result'] as List? ?? [])
          .map((e) => PostModel.fromJson(e))
          .toList(),
    );
  }
}

class PostModel {
  final String id;
  final PostUser user;
  final String channel;
  final String text;
  final String? image;
  final List<String> likes;
  final String timeAgo;
  final List<PostComment> recentComments;
  
  // 1. Convert these fields into Rx observables
  final RxInt likeCount;
  final RxBool isLiked;

  PostModel({
    required this.id,
    required this.user,
    required this.channel,
    required this.text,
    this.image,
    required this.likes,
    required this.likeCount,
    required this.isLiked,
    required this.timeAgo,
    required this.recentComments,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['_id'] ?? '',
      user: PostUser.fromJson(json['user'] ?? {}),
      channel: json['channel'] ?? '',
      text: json['text'] ?? '',
      image: json['image'],
      likes: List<String>.from(json['likes'] ?? []),
      timeAgo: json['timeAgo'] ?? '',
      // 2. Wrap incoming raw data type states inside .obs
      likeCount: ((json['likeCount'] ?? 0) as int).obs,
      isLiked: ((json['isLiked'] ?? false) as bool).obs,
      recentComments: (json['recentComments'] as List? ?? [])
          .map((e) => PostComment.fromJson(e))
          .toList(),
    );
  }
}
class PostUser {
  final String id;
  final String firstName;
  final String lastName;
  final String? memberNumber;
  final String? image;

  String get fullName => '$firstName $lastName'.trim();

  PostUser({required this.id, required this.firstName, required this.lastName, this.memberNumber, this.image});

  factory PostUser.fromJson(Map<String, dynamic> json) {
    return PostUser(
      id: json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      memberNumber: json['memberNumber'],
      image: json['image'],
    );
  }
}

class PostComment {
  final String id;
  final String post;
  final PostUser user;
  final String text;
  final String createdAt;

  PostComment({required this.id, required this.post, required this.user, required this.text, required this.createdAt});

  factory PostComment.fromJson(Map<String, dynamic> json) {
    return PostComment(
      id: json['_id'] ?? '',
      post: json['post'] ?? '',
      user: PostUser.fromJson(json['user'] ?? {}),
      text: json['text'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }
}
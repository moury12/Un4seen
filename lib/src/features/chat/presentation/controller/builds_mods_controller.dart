// lib/src/features/chat/presentation/controllers/builds_mods_controller.dart

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';
import '../../../../core/services/api_service.dart';
import '../../data/models/post_model.dart';

// lib/src/features/chat/presentation/controllers/builds_mods_controller.dart

class BuildsModsController extends GetxController {
  final ApiService _api = Get.find<ApiService>();
  final ImagePicker _picker = ImagePicker();

  // 1. Accept channelId dynamically
  final String channelId;
  BuildsModsController({required this.channelId});

  final posts = <PostModel>[].obs;
  final isLoading = false.obs;
  // ... rest of your variables remain exactly the same ...
  final isFetchingMore = false.obs;
  final isSubmittingPost = false.obs;
  final hasMore = true.obs;

  // Form states
  final postTextController = TextEditingController();
  final rxImageFile = Rxn<File>();

  // Dynamic comment input field tracking map [postId -> Controller]
  final commentControllers = <String, TextEditingController>{};

  final scrollController = ScrollController();
  int _page = 1;
  final int _limit = 5;

  @override
  void onInit() {
    super.onInit();
    fetchFeed(isRefresh: true);
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      fetchFeed();
    }
  }

  TextEditingController getCommentController(String postId) {
    return commentControllers.putIfAbsent(
      postId,
      () => TextEditingController(),
    );
  }

  Future<void> pickPostImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      rxImageFile.value = File(pickedFile.path);
    }
  }

  Future<void> fetchFeed({bool isRefresh = false}) async {
    if (isLoading.value ||
        isFetchingMore.value ||
        (!hasMore.value && !isRefresh))
      return;

    if (isRefresh) {
      _page = 1;
      hasMore.value = true;
      isLoading.value = true;
    } else {
      isFetchingMore.value = true;
    }

    try {
      final res = await _api.get(
        '/posts/$channelId/feed?page=$_page&limit=$_limit',
      );
      if (res.data['success'] == true) {
        final feedData = PostFeedResponse.fromJson(res.data['data']);

        if (isRefresh) {
          posts.assignAll(feedData.result);
        } else {
          posts.addAll(feedData.result);
        }

        if (_page >= feedData.totalPage) {
          hasMore.value = false;
        } else {
          _page++;
        }
      }
    } catch (e) {
      print("❌ Error fetching feeds: $e");
    } finally {
      isLoading.value = false;
      isFetchingMore.value = false;
    }
  }

  Future<void> createPost() async {
    final text = postTextController.text.trim();
    if (text.isEmpty && rxImageFile.value == null) {
      Get.snackbar(
        'Alert',
        'Please add some text or an image to share your build!',
      );
      return;
    }

    try {
      isSubmittingPost.value = true;

      // Match target FormData payload signature mapping layout
      final Map<String, dynamic> dataPayload = {
        "channel": channelId,
        "text": text,
      };

      final formData = dio.FormData.fromMap({"data": jsonEncode(dataPayload)});

      if (rxImageFile.value != null) {
        formData.files.add(
          MapEntry(
            "image",
            await dio.MultipartFile.fromFile(
              rxImageFile.value!.path,
              filename: "upload.png",
            ),
          ),
        );
      }

      final res = await _api.post('/posts/create', data: formData);
      if (res.data['success'] == true) {
        postTextController.clear();
        rxImageFile.value = null;
        Get.snackbar('Success', 'Post shared!');
        fetchFeed(isRefresh: true);
      }
    } catch (e) {
      print("❌ Create Post Error: $e");
    } finally {
      isSubmittingPost.value = false;
    }
  }

// lib/src/features/chat/presentation/controllers/builds_mods_controller.dart

Future<void> toggleLike(String postId) async {
  // Find the targeting post object item references directly
  final post = posts.firstWhereOrNull((p) => p.id == postId);
  if (post == null) return;

  // Optimistic UI updates targeting direct reactive observable mutations
  if (post.isLiked.value) {
    post.isLiked.value = false;
    post.likeCount.value -= 1;
  } else {
    post.isLiked.value = true;
    post.likeCount.value += 1;
  }

  try {
    await _api.patch('/posts/$postId/like');
  } catch (e) {
    // Revert state safely back if the API endpoint errors out
    if (post.isLiked.value) {
      post.isLiked.value = false;
      post.likeCount.value -= 1;
    } else {
      post.isLiked.value = true;
      post.likeCount.value += 1;
    }
    print("❌ Error processing post like payload sync: $e");
  }
}

  Future<void> addComment(String postId) async {
    final controller = getCommentController(postId);
    final commentText = controller.text.trim();
    if (commentText.isEmpty) return;

    try {
      final res = await _api.post(
        '/posts/comment',
        data: {"post": postId, "text": commentText},
      );

      if (res.data['success'] == true) {
        controller.clear();
        // Insert new comment instantly inside targeting post architecture array list
        final index = posts.indexWhere((p) => p.id == postId);
        if (index != -1) {
          final updatedPost = posts[index];
          final newComment = PostComment.fromJson(res.data['data']);
          updatedPost.recentComments.add(newComment);
          posts[index] = updatedPost;
          posts.refresh();
        }
      }
    } catch (e) {
      print("❌ Add Comment Error: $e");
    }
  }

  @override
  void onClose() {
    postTextController.dispose();
    scrollController.dispose();
    commentControllers.forEach((_, c) => c.dispose());
    super.onClose();
  }
}

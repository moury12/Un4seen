// lib/src/features/bike_profiles/presentation/controllers/members_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:un4seen/src/features/profile/data/models/user_profile_model.dart';
import '../../../../core/services/api_service.dart';

class MembersController extends GetxController {
  final ApiService _api = Get.find<ApiService>();

  final members = <UserProfileModel>[].obs;
  final isLoading = false.obs;
  final isFetchingMore = false.obs;
  final hasMore = true.obs;

  int _page = 1;
  final int _limit = 10;
  String _searchTerm = '';

  final scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    fetchMembers(isRefresh: true);

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        fetchMembers();
      }
    });
  }

  Future<void> fetchMembers({bool isRefresh = false}) async {
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
      final endpoint =
          '/user/all-members?page=$_page&limit=$_limit&searchTerm=$_searchTerm';
      final response = await _api.get(endpoint);

      if (response.data['success']) {
        final data = response.data['data']['result'] as List;
        final meta = response.data['data']['meta'];

        final newMembers = data
            .map((e) => UserProfileModel.fromJson(e))
            .toList();

        if (isRefresh) {
          members.assignAll(newMembers);
        } else {
          members.addAll(newMembers);
        }

        if (_page >= meta['totalPage']) {
          hasMore.value = false;
        } else {
          _page++;
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load members');
    } finally {
      isLoading.value = false;
      isFetchingMore.value = false;
    }
  }

  void searchMembers(String query) {
    _searchTerm = query;
    fetchMembers(isRefresh: true);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}

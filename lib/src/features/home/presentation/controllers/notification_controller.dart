// lib/src/features/profile/presentation/controllers/notification_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:un4seen/src/features/home/data/models/notification_model.dart';
import '../../../../core/services/api_service.dart';

class NotificationController extends GetxController {
  final ApiService _api = Get.find<ApiService>();
  final ScrollController scrollController = ScrollController();

  final RxList<NotificationItem> notifications = <NotificationItem>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;

  int _currentPage = 1;
  int _totalPage = 1;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications(isRefresh: true);
    scrollController.addListener(_scrollListener);
  }

  Future<void> fetchNotifications({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPage = 1;
      _totalPage = 1;
    }

    // Prevent duplicate calls if already tracking pagination jobs
    if (isLoading.value || isLoadingMore.value) return;

    try {
      if (isRefresh) {
        isLoading.value = true;
      } else {
        isLoadingMore.value = true;
      }

      final url = '/notification?page=$_currentPage&limit=10&sort=-createdAt';
      final response = await _api.get(url);

      if (response.data['success'] == true) {
        final dataContainer = response.data['data'];
        
        if (dataContainer != null) {
          final meta = NotificationMeta.fromJson(dataContainer['meta'] ?? {});
          _totalPage = meta.totalPage;

          final List rawItems = dataContainer['result'] ?? [];
          final items = rawItems.map((e) => NotificationItem.fromJson(e)).toList();

          if (isRefresh) {
            notifications.assignAll(items);
          } else {
            notifications.addAll(items);
          }
        }
      }
    } catch (e) {
      print("❌ Notification Network Task Error: $e");
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  void _scrollListener() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
      if (!isLoadingMore.value && _currentPage < _totalPage) {
        _currentPage++;
        fetchNotifications(isRefresh: false);
      }
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
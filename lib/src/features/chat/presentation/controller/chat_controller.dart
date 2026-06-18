import 'dart:developer';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:un4seen/src/core/services/socket_service.dart';
import 'package:un4seen/src/core/widgets/custom_snackbar.dart';
import 'package:un4seen/src/features/chat/data/models/chat_models.dart';
import 'package:un4seen/src/features/chat/data/models/search_conversation_model.dart';

import '../../../../core/services/api_service.dart';

class ChatController extends GetxController {
  final ApiService _api = Get.find<ApiService>();
  final SocketService _socket = Get.find<SocketService>();

  final RxList<ChatMessageModel> activeMessages = <ChatMessageModel>[].obs;
  final RxList<String> onlineUserIds = <String>[].obs;
  final RxList<ChatGroupModel> groupsList = <ChatGroupModel>[].obs;
  final RxList<DirectMessageModel> dmsList = <DirectMessageModel>[].obs;
  final RxBool isChannelsLoading = false.obs;
  final RxBool isChatLoading = false.obs;
  final RxBool isCreatingChannel = false.obs;
  final RxList<RiderSearchResultModel> searchRiderResults =
      <RiderSearchResultModel>[].obs;
  final RxList<DiscoveredChannelModel> discoveredChannels =
      <DiscoveredChannelModel>[].obs;
  final RxBool isSearchLoading = false.obs;
  String? activeChatId;
  bool activeChatIsChannel = false;
  String? activeDmChannelId;

  final RxList<ChannelMemberModel> channelMembers = <ChannelMemberModel>[].obs;
  final RxBool isMembersLoading = false.obs;
  final RxBool isUploadingFile = false.obs;

  int currentPage = 1;
  bool hasMoreMessages = true;
  final RxBool isLoadMoreLoading = false.obs;

  // ── Search Logic ───────────────────────────────────────
  Future<void> globalSearch(String query) async {
    try {
      isSearchLoading.value = true;
      final responses = await Future.wait([
        _api.get('/channels/search-riders?searchTerm=$query'),
        _api.get('/channels/search-all?searchTerm=$query'),
      ]);

      if (responses[0].data['success']) {
        final List riders = responses[0].data['data'] ?? [];
        searchRiderResults.assignAll(
          riders.map((e) => RiderSearchResultModel.fromJson(e)).toList(),
        );
      }

      if (responses[1].data['success']) {
        final List channels = responses[1].data['data'] ?? [];
        discoveredChannels.assignAll(
          channels.map((e) => DiscoveredChannelModel.fromJson(e)).toList(),
        );
      }
    } finally {
      isSearchLoading.value = false;
    }
  }

  Future<bool> createChannel({
    required String name,
    required String description,
    required List<String> members,
    bool isPrivate = true,
  }) async {
    try {
      isCreatingChannel.value = true;
      final res = await _api.post(
        '/channels/create',
        data: {
          'name': name,
          'description': description,
          'members': members,
          'isPrivate': isPrivate,
        },
      );

      if (res.data['success'] == true) {
        CustomSnackbar.showSuccess(res.data['message'] ?? 'Group created');
        await fetchSidebar();
        return true;
      }

      CustomSnackbar.showError(
        res.data['message'] ?? 'Failed to create channel',
      );
      return false;
    } catch (e) {
      CustomSnackbar.showError(e.toString());
      return false;
    } finally {
      isCreatingChannel.value = false;
    }
  }

  Future<bool> manageChannelMember({
    required String channelId,
    required String targetUserId,
    required String action,
  }) async {
    try {
      final res = await _api.patch(
        '/channels/manage-members',
        data: {
          'channelId': channelId,
          'targetUserId': targetUserId,
          'action': action,
        },
      );

      if (res.data['success'] == true) {
        CustomSnackbar.showSuccess(res.data['message'] ?? 'Member updated');
        return true;
      }

      CustomSnackbar.showError(
        res.data['message'] ?? 'Failed to update member',
      );
      return false;
    } catch (e) {
      CustomSnackbar.showError(e.toString());
      return false;
    }
  }

  Future<void> fetchSidebar() async {
    try {
      isChannelsLoading.value = true;
      final res = await _api.get('/channels/sidebar');
      if (res.data['success']) {
        final sidebarData = ChatSidebarModel.fromJson(res.data['data']);
        groupsList.assignAll(sidebarData.groups);
        dmsList.assignAll(sidebarData.directMessages);
      }
    } catch (e) {
      print(
        "❌ Sidebar Error: $e | lib/src/features/chat/presentation/controllers/chat_controller.dart",
      );
    } finally {
      isChannelsLoading.value = false;
    }
  }

  void _initSocketListeners() {
    _socket.listenToEvent('RECEIVE_GROUP_MESSAGE', (data) {
      log("---------- receive group msg -----------");
      log(data);
      final msg = ChatMessageModel.fromJson(data);
      if (activeChatIsChannel && msg.channel == activeChatId) {
        activeMessages.insert(0, msg);
      }
      fetchSidebar();
    });

    _socket.listenToEvent('RECEIVE_PRIVATE_MESSAGE', (data) {
      final msg = ChatMessageModel.fromJson(data);
      if (!activeChatIsChannel && activeChatId != null) {
        if (activeDmChannelId == null && msg.channel.isNotEmpty) {
          activeDmChannelId = msg.channel;
        }
        final dm = dmsList.firstWhereOrNull((e) => e.userId == activeChatId);
        final isMatch =
            (activeDmChannelId != null && msg.channel == activeDmChannelId) ||
            (dm != null && msg.channel == dm.id) ||
            (msg.sender.id == activeChatId);
        if (isMatch) {
          activeMessages.insert(0, msg);
        }
      }
      fetchSidebar();
    });

    _socket.listenToEvent('GET_ONLINE_USERS', (data) {
      onlineUserIds.assignAll(List<String>.from(data));
    });

    _socket.listenToEvent('USER_STATUS_CHANGED', (data) {
      if (data is Map) {
        final userId = data['userId']?.toString();
        final isOnline = data['isOnline'] == true;
        if (userId != null) {
          if (isOnline) {
            if (!onlineUserIds.contains(userId)) {
              onlineUserIds.add(userId);
            }
          } else {
            onlineUserIds.remove(userId);
          }
        }
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    _initSocketListeners();
    fetchSidebar();
  }

  Future<void> fetchChatHistory(String id, bool isChannel) async {
    if (id.isEmpty) return;

    try {
      isChatLoading.value = true;
      activeMessages.clear();
      activeChatId = id;
      activeChatIsChannel = isChannel;
      activeDmChannelId = null;
      currentPage = 1;
      hasMoreMessages = true;

      if (isChannel) _socket.socket?.emit('JOIN_CHANNEL', id);

      final endpoint = isChannel
          ? '/channels/$id/messages' // Keep limit/page if needed, otherwise default
          : '/channels/private-history/$id?page=1&limit=120';

      final res = await _api.get(endpoint);
      if (res.data['success']) {
        final List results = res.data['data']['result'] ?? [];
        if (!isChannel && results.isNotEmpty) {
          activeDmChannelId = results.first['channel']?.toString();
        }
        final messages = results
            .map((e) => ChatMessageModel.fromJson(e))
            .toList();
        activeMessages.assignAll(messages);

        final meta = res.data['data']['meta'];
        if (meta != null) {
          final totalPage = meta['totalPage'] ?? 1;
          final page = meta['page'] ?? 1;
          hasMoreMessages = page < totalPage;
        } else {
          hasMoreMessages = results.length >= 120;
        }
      }
    } catch (e) {
      print(
        "❌ Chat History Error: $e | lib/src/features/chat/presentation/controller/chat_controller.dart",
      );
    } finally {
      isChatLoading.value = false;
    }
  }

  Future<void> loadNextPage(String id, bool isChannel) async {
    if (isLoadMoreLoading.value || !hasMoreMessages || id.isEmpty) return;

    try {
      isLoadMoreLoading.value = true;
      final nextPage = currentPage + 1;
      
      final endpoint = isChannel
          ? '/channels/$id/messages?page=$nextPage&limit=120' // If group has pages
          : '/channels/private-history/$id?page=$nextPage&limit=120';

      final res = await _api.get(endpoint);
      if (res.data['success']) {
        final List results = res.data['data']['result'] ?? [];
        if (results.isNotEmpty) {
          final newMessages = results
              .map((e) => ChatMessageModel.fromJson(e))
              .toList();
          
          activeMessages.addAll(newMessages);
          currentPage = nextPage;
        }

        final meta = res.data['data']['meta'];
        if (meta != null) {
          final totalPage = meta['totalPage'] ?? 1;
          final page = meta['page'] ?? 1;
          hasMoreMessages = page < totalPage;
        } else {
          hasMoreMessages = results.length >= 120;
        }
      }
    } catch (e) {
      print("❌ Load More Error: $e");
    } finally {
      isLoadMoreLoading.value = false;
    }
  }

  void sendMsg(String id, String text, bool isChannel, {String? fileUrl}) {
    final Map<String, dynamic> body = {
      if (isChannel) "channelId": id else "to": id,
      "text": text,
      if (fileUrl != null && fileUrl.isNotEmpty) "file": fileUrl,
    };
    log("------- sending msg ----------");
    final event = isChannel ? 'SEND_GROUP_MESSAGE' : 'SEND_PRIVATE_MESSAGE';
    _socket.socket?.emit(event, body);
  }

  Future<void> fetchChannelMembers(String channelId) async {
    try {
      isMembersLoading.value = true;
      channelMembers.clear();
      final res = await _api.get('/channels/$channelId/members');
      if (res.data['success'] == true) {
        final List list = res.data['data'] ?? [];
        channelMembers.assignAll(
          list.map((e) => ChannelMemberModel.fromJson(e)).toList(),
        );
      }
    } catch (e) {
      print("❌ Error fetching channel members: $e");
    } finally {
      isMembersLoading.value = false;
    }
  }

  Future<String?> uploadChatFile(String filePath) async {
    try {
      isUploadingFile.value = true;
      final fileName = filePath.split('/').last;
      final formData = dio.FormData.fromMap({
        'file': await dio.MultipartFile.fromFile(filePath, filename: fileName),
      });

      final res = await _api.post('/channels/upload-file', data: formData);
      if (res.data['success'] == true) {
        return res.data['data'];
      } else {
        CustomSnackbar.showError(
          res.data['message'] ?? 'Failed to upload file',
        );
      }
    } catch (e) {
      print("❌ Error uploading chat file: $e");
      CustomSnackbar.showError('Error uploading file: $e');
    } finally {
      isUploadingFile.value = false;
    }
    return null;
  }

  bool isUserOnline(String userId) {
    return onlineUserIds.contains(userId);
  }
}

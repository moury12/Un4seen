import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:un4seen/src/core/services/api_service.dart';
import 'package:un4seen/src/core/services/socket_service.dart';
import 'package:un4seen/src/core/widgets/custom_snackbar.dart';
import 'package:un4seen/src/features/chat/data/models/support_chat_model.dart';

class SupportChatController extends GetxController {
  final ApiService _api = Get.find<ApiService>();
  final SocketService _socketService = Get.put(SocketService());
  final ImagePicker _picker = ImagePicker();

  final RxList<SupportMessageModel> messages = <SupportMessageModel>[].obs;
  final Rxn<SupportSessionModel> session = Rxn<SupportSessionModel>();

  final RxBool isLoading = false.obs;
  final RxBool isSending = false.obs;
  final Rx<File?> selectedFile = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchSupportChat();
    setupSocketListeners();
  }

  void setupSocketListeners() {
    _socketService.initSocket();

    _socketService.listenToEvent('RECEIVE_SUPPORT_MESSAGE', (data) {
      log("📩 [Socket] RECEIVE_SUPPORT_MESSAGE event received");
      _handleSocketMessage(data);
    });

    _socketService.listenToEvent('NEW_SUPPORT_MESSAGE_ALERT', (data) {
      log("🔔 [Socket] NEW_SUPPORT_MESSAGE_ALERT event received");
      _handleSocketMessage(data);
    });

    _socketService.listenToEvent('SUPPORT_STATUS_CHANGED', (data) {
      log("🔄 [Socket] SUPPORT_STATUS_CHANGED event received");
      if (data != null) {
        if (data is Map && data['session'] != null) {
          session.value = SupportSessionModel.fromJson(
            Map<String, dynamic>.from(data['session']),
          );
        } else if (data is Map &&
            data['status'] != null &&
            session.value != null) {
          final old = session.value!;
          session.value = SupportSessionModel(
            id: old.id,
            status: data['status'].toString(),
            unreadCountUser: old.unreadCountUser,
            unreadCountAdmin: old.unreadCountAdmin,
            isDeleted: old.isDeleted,
            lastMessageAt: old.lastMessageAt,
            lastMessage: old.lastMessage,
            createdAt: old.createdAt,
            updatedAt: old.updatedAt,
            assignedAdmin: old.assignedAdmin,
          );
        }
      }
    });
  }

  void _handleSocketMessage(dynamic data) {
    if (data == null || data is! Map) return;

    try {
      final msgJson = data['message'] != null && data['message'] is Map
          ? Map<String, dynamic>.from(data['message'])
          : (data['_id'] != null ? Map<String, dynamic>.from(data) : null);

      if (msgJson != null) {
        final newMsg = SupportMessageModel.fromJson(msgJson);
        final bool exists = messages.any((m) => m.id == newMsg.id);
        if (!exists) {
          messages.add(newMsg);
          messages.refresh();
        }
      }

      if (data['session'] != null && data['session'] is Map) {
        session.value = SupportSessionModel.fromJson(
          Map<String, dynamic>.from(data['session']),
        );
      }
    } catch (e) {
      log("Error handling socket message: $e");
    }
  }

  Future<void> fetchSupportChat() async {
    try {
      isLoading.value = true;
      final response = await _api.get('/support-chat/my-chat');

      if (response.data != null && response.data['success'] == true) {
        final data = response.data['data'];
        if (data != null && data is Map) {
          // Parse result list
          if (data['result'] != null && data['result'] is List) {
            final List list = data['result'];
            final parsedMessages = list
                .map((e) => SupportMessageModel.fromJson(e))
                .toList();
            // Sort ascending by createdAt
            parsedMessages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
            messages.assignAll(parsedMessages);
          }

          // Parse session object
          if (data['session'] != null && data['session'] is Map) {
            session.value = SupportSessionModel.fromJson(
              Map<String, dynamic>.from(data['session']),
            );
          }
        }
      }
    } catch (e) {
      log("Error fetching support chat history: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickFile() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedFile.value = File(image.path);
    }
  }

  void removeSelectedFile() {
    selectedFile.value = null;
  }

  Future<bool> sendMessage(String text) async {
    if (text.trim().isEmpty && selectedFile.value == null) {
      return false;
    }

    try {
      isSending.value = true;

      final Map<String, dynamic> payload = {"text": text.trim()};

      final Map<String, dynamic> formMap = {'data': jsonEncode(payload)};

      if (selectedFile.value != null) {
        formMap['file'] = await dio.MultipartFile.fromFile(
          selectedFile.value!.path,
        );
      }

      dio.FormData formData = dio.FormData.fromMap(formMap);

      final response = await _api.post(
        '/support-chat/send-message',
        data: formData,
      );

      if (response.data != null && response.data['success'] == true) {
        final data = response.data['data'];
        if (data != null && data is Map) {
          if (data['message'] != null && data['message'] is Map) {
            final sentMsg = SupportMessageModel.fromJson(
              Map<String, dynamic>.from(data['message']),
            );
            if (!messages.any((m) => m.id == sentMsg.id)) {
              messages.add(sentMsg);
              messages.refresh();
            }
          }
          if (data['session'] != null && data['session'] is Map) {
            session.value = SupportSessionModel.fromJson(
              Map<String, dynamic>.from(data['session']),
            );
          }
        }

        selectedFile.value = null;
        return true;
      } else {
        CustomSnackbar.showError(
          response.data?['message'] ?? 'Failed to send message',
        );
      }
    } catch (e) {
      log("Error sending support message: $e");
      CustomSnackbar.showError('Failed to send message. Please try again.');
    } finally {
      isSending.value = false;
    }
    return false;
  }
}

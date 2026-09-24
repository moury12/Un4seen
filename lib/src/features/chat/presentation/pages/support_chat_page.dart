import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:un4seen/src/core/core_export.dart';
import 'package:un4seen/src/core/widgets/custom_network_image.dart';
import 'package:un4seen/src/core/widgets/custom_scaffold.dart';
import 'package:un4seen/src/features/chat/presentation/controller/support_chat_controller.dart';

class SupportChatPage extends StatefulWidget {
  const SupportChatPage({super.key});

  @override
  State<SupportChatPage> createState() => _SupportChatPageState();
}

class _SupportChatPageState extends State<SupportChatPage> {
  late final SupportChatController controller;
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<SupportChatController>()
        ? Get.find<SupportChatController>()
        : Get.put(SupportChatController());

    controller.messages.listen((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 150), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'open':
        return Colors.green;
      case 'in-progress':
      case 'in_progress':
        return Colors.orange;
      case 'resolved':
        return Colors.blue;
      case 'closed':
      default:
        return Colors.grey;
    }
  }

  String _formatStatusLabel(String status) {
    switch (status.toLowerCase()) {
      case 'open':
        return 'Open';
      case 'in-progress':
      case 'in_progress':
        return 'In Progress';
      case 'resolved':
        return 'Resolved';
      case 'closed':
        return 'Closed';
      default:
        return status.capitalizeFirst ?? status;
    }
  }

  String _formatTime(String isoDate) {
    try {
      final dt = DateTime.parse(isoDate).toLocal();
      return DateFormat('h:mm a').format(dt);
    } catch (_) {
      return isoDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: AppColors.kPrimaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.support_agent,
                color: Colors.black,
                size: 22,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    'Support Chat',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  Obx(() {
                    final status = controller.session.value?.status ?? 'open';
                    final color = _getStatusColor(status);
                    return Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        CustomText(
                          _formatStatusLabel(status),
                          color: color,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ── Messages Area ─────────────────────────────
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value && controller.messages.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.kPrimaryColor,
                    ),
                  );
                }

                if (controller.messages.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.headset_mic_outlined,
                            size: 64,
                            color: AppColors.kSecondaryTextColor,
                          ),
                          const SizedBox(height: 16),
                          const CustomText(
                            'No messages yet. Ask admin for support!',
                            color: AppColors.kSecondaryTextColor,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(12),
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final msg = controller.messages[index];
                    final isUser = msg.isFromUser;

                    return Align(
                      alignment: isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.78,
                        ),
                        child: Column(
                          crossAxisAlignment: isUser
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            if (!isUser) ...[
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (msg.sender.image.isNotEmpty)
                                    ClipOval(
                                      child: CustomNetworkImage(
                                        imageUrl: msg.sender.image,
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  else
                                    const Icon(
                                      Icons.admin_panel_settings,
                                      color: AppColors.kPrimaryColor,
                                      size: 18,
                                    ),
                                  const SizedBox(width: 6),
                                  CustomText(
                                    msg.sender.fullName,
                                    fontSize: 12,
                                    color: AppColors.kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                            ],
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isUser
                                    ? AppColors.kPrimaryColor
                                    : AppColors.kPrimaryDarkColor2,
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(14),
                                  topRight: const Radius.circular(14),
                                  bottomLeft: isUser
                                      ? const Radius.circular(14)
                                      : const Radius.circular(2),
                                  bottomRight: isUser
                                      ? const Radius.circular(2)
                                      : const Radius.circular(14),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (msg.file != null &&
                                      msg.file!.isNotEmpty) ...[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: CustomNetworkImage(
                                        imageUrl: msg.file!,
                                        width: double.infinity,
                                        height: 180,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                  if (msg.text.isNotEmpty)
                                    CustomText(
                                      msg.text,
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      height: 1.3,
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            CustomText(
                              _formatTime(msg.createdAt),
                              fontSize: 10,
                              color: AppColors.kSecondaryTextColor,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),

            // ── Attachment Preview (if selected) ───────────
            Obx(() {
              final file = controller.selectedFile.value;
              if (file == null) return const SizedBox.shrink();

              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                color: AppColors.kPrimaryDarkColor,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.file(
                        file,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: CustomText(
                        'Image attached',
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.redAccent,
                        size: 20,
                      ),
                      onPressed: controller.removeSelectedFile,
                    ),
                  ],
                ),
              );
            }),

            // ── Message Input Bar ──────────────────────────
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: AppColors.kPrimaryDarkColor,
                border: Border(
                  top: BorderSide(color: Colors.black, width: 0.5),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.image,
                      color: AppColors.kPrimaryColor,
                      size: 26,
                    ),
                    onPressed: controller.pickFile,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.kPrimaryDarkColor2,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.black12, width: 0.8),
                      ),
                      child: TextField(
                        controller: _textController,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Ask for support...',
                          hintStyle: TextStyle(
                            color: AppColors.kSecondaryTextColor,
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Obx(() {
                    return controller.isSending.value
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.kPrimaryColor,
                            ),
                          )
                        : Container(
                            decoration: const BoxDecoration(
                              color: AppColors.kPrimaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.send,
                                color: Colors.black,
                                size: 18,
                              ),
                              onPressed: () async {
                                final text = _textController.text;
                                _textController.clear();
                                final success = await controller.sendMessage(
                                  text,
                                );
                                if (success) {
                                  _scrollToBottom();
                                }
                              },
                            ),
                          );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

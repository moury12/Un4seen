
class ChatSidebarModel {
  final List<ChatGroupModel> groups;
  final List<DirectMessageModel> directMessages;

  ChatSidebarModel({required this.groups, required this.directMessages});

  factory ChatSidebarModel.fromJson(Map<String, dynamic> json) {
    return ChatSidebarModel(
      groups: (json['groups'] as List?)
              ?.map((e) => ChatGroupModel.fromJson(e))
              .toList() ?? [],
      directMessages: (json['directMessages'] as List?)
              ?.map((e) => DirectMessageModel.fromJson(e))
              .toList() ?? [],
    );
  }
}

class ChatGroupModel {
  final String id;
  final String name;
  final int onlineCount;

  ChatGroupModel({required this.id, required this.name, required this.onlineCount});

  factory ChatGroupModel.fromJson(Map<String, dynamic> json) {
    return ChatGroupModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      onlineCount: json['onlineCount'] ?? 0,
    );
  }
}

class DirectMessageModel {
  final String id; // Channel ID
  final String userId; // Target User ID
  final String name;
  final String image;
  final bool isOnline;

  DirectMessageModel({
    required this.id, required this.userId, required this.name, 
    required this.image, required this.isOnline
  });

  factory DirectMessageModel.fromJson(Map<String, dynamic> json) {
    return DirectMessageModel(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      isOnline: json['isOnline'] ?? false,
    );
  }
}

class ChatMessageModel {
  final String id;
  final String text;
  final String? file;
  final ChatSender sender;
  final String createdAt;
  final String channel;

  ChatMessageModel({
    required this.id, required this.text, this.file,
    required this.sender, required this.createdAt, required this.channel,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['_id'] ?? '',
      text: json['text'] ?? '',
      file: json['file'],
      channel: json['channel'] ?? '',
      createdAt: json['createdAt'] ?? '',
      sender: ChatSender.fromJson(json['sender'] ?? {}),
    );
  }
}

class ChatSender {
  final String id;
  final String fullName;
  final String image;
  final String memberNumber;

  ChatSender({required this.id, required this.fullName, required this.image, required this.memberNumber});

  factory ChatSender.fromJson(Map<String, dynamic> json) {
    return ChatSender(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? "${json['firstName'] ?? ''} ${json['lastName'] ?? ''}".trim(),
      image: json['image'] ?? '',
      memberNumber: json['memberNumber'] ?? '',
    );
  }
}
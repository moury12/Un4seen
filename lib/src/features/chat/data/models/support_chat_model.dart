class SupportMessageModel {
  final String id;
  final String supportSession;
  final SupportUser sender;
  final String senderRole; // "user" or "admin"
  final String text;
  final String? file;
  final bool isRead;
  final String createdAt;
  final String updatedAt;

  SupportMessageModel({
    required this.id,
    required this.supportSession,
    required this.sender,
    required this.senderRole,
    required this.text,
    this.file,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SupportMessageModel.fromJson(Map<String, dynamic> json) {
    return SupportMessageModel(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      supportSession: json['supportSession']?.toString() ?? '',
      sender: SupportUser.fromJson(
        json['sender'] is Map ? Map<String, dynamic>.from(json['sender']) : {},
      ),
      senderRole: json['senderRole']?.toString() ?? 'user',
      text: json['text']?.toString() ?? '',
      file: json['file']?.toString(),
      isRead: json['isRead'] ?? false,
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
    );
  }

  bool get isFromUser => senderRole.toLowerCase() == 'user';
}

class SupportUser {
  final String id;
  final String firstName;
  final String lastName;
  final String fullName;
  final String role;
  final String memberNumber;
  final String image;

  SupportUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.role,
    required this.memberNumber,
    required this.image,
  });

  factory SupportUser.fromJson(Map<String, dynamic> json) {
    final String fName = json['firstName']?.toString() ?? '';
    final String lName = json['lastName']?.toString() ?? '';
    final String computedFullName =
        json['fullName']?.toString() ?? "$fName $lName".trim();

    return SupportUser(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      firstName: fName,
      lastName: lName,
      fullName: computedFullName.isNotEmpty ? computedFullName : "Support",
      role: json['role']?.toString() ?? '',
      memberNumber: json['memberNumber']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
    );
  }
}

class SupportSessionModel {
  final String id;
  final String status; // "open", "in-progress", "resolved", "closed"
  final int unreadCountUser;
  final int unreadCountAdmin;
  final bool isDeleted;
  final String lastMessageAt;
  final String lastMessage;
  final String createdAt;
  final String updatedAt;
  final dynamic assignedAdmin;

  SupportSessionModel({
    required this.id,
    required this.status,
    required this.unreadCountUser,
    required this.unreadCountAdmin,
    required this.isDeleted,
    required this.lastMessageAt,
    required this.lastMessage,
    required this.createdAt,
    required this.updatedAt,
    this.assignedAdmin,
  });

  factory SupportSessionModel.fromJson(Map<String, dynamic> json) {
    return SupportSessionModel(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      status: json['status']?.toString() ?? 'open',
      unreadCountUser: json['unreadCountUser'] is int
          ? json['unreadCountUser']
          : int.tryParse(json['unreadCountUser']?.toString() ?? '') ?? 0,
      unreadCountAdmin: json['unreadCountAdmin'] is int
          ? json['unreadCountAdmin']
          : int.tryParse(json['unreadCountAdmin']?.toString() ?? '') ?? 0,
      isDeleted: json['isDeleted'] ?? false,
      lastMessageAt: json['lastMessageAt']?.toString() ?? '',
      lastMessage: json['lastMessage']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
      assignedAdmin: json['assignedAdmin'],
    );
  }
}

class NotificationMeta {
  final int page;
  final int limit;
  final int total;
  final int totalPage;

  NotificationMeta({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
  });

  factory NotificationMeta.fromJson(Map<String, dynamic> json) {
    return NotificationMeta(
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      total: json['total'] ?? 0,
      totalPage: json['totalPage'] ?? 1,
    );
  }
}

class NotificationItem {
  final String id;
  final String user;
  final String title;
  final String message;
  final String type;
  final bool isRead;
  final DateTime createdAt;

  NotificationItem({
    required this.id,
    required this.user,
    required this.title,
    required this.message,
    required this.type,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['_id'] ?? '',
      user: json['user'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      type: json['type'] ?? 'general',
      isRead: json['isRead'] ?? false,
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : DateTime.now(),
    );
  }
}
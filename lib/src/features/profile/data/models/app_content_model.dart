// lib/src/features/profile/data/models/legal_and_notification_models.dart

class AppContentModel {
  final String id;
  final String content; // Will now hold the complete, unparsed HTML string

  AppContentModel({required this.id, required this.content});

  factory AppContentModel.fromJson(Map<String, dynamic> json, String contentKey) {
    return AppContentModel(
      id: json['_id'] ?? '',
      content: json[contentKey] ?? '', // Retain raw HTML fields directly
    );
  }
}
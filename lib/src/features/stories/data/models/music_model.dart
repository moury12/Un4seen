class MusicModel {
  final String id;
  final String title;
  final String audioUrl;
  final String category;
  bool isFavorite;

  MusicModel({
    required this.id,
    required this.title,
    required this.audioUrl,
    required this.category,
    this.isFavorite = false,
  });

  factory MusicModel.fromJson(Map<String, dynamic> json) {
    return MusicModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      audioUrl: json['audioUrl'] ?? '',
      category: json['category'] ?? '',
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}
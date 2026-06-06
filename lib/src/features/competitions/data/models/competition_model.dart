class CompetitionModel {
  final String id;
  final String title;
  final String description;
  final String image;
  final String grandPrize;
  final List<String> rules;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final String statusLabel;
  final bool canSubmit;
  final bool canVote;
  final int participantCount;

  CompetitionModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.grandPrize,
    required this.rules,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.statusLabel,
    required this.canSubmit,
    required this.canVote,
    required this.participantCount,
  });

  factory CompetitionModel.fromJson(Map<String, dynamic> json) {
    return CompetitionModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      grandPrize: json['grandPrize'] ?? '',
      rules: List<String>.from(json['rules'] ?? []),
      startDate: DateTime.parse(json['startDate'] ?? DateTime.now().toIso8601String()),
      endDate: DateTime.parse(json['endDate'] ?? DateTime.now().toIso8601String()),
      status: json['status'] ?? '',
      statusLabel: json['statusLabel'] ?? '',
      canSubmit: json['canSubmit'] ?? false,
      canVote: json['canVote'] ?? false,
      participantCount: json['participantCount'] ?? 0,
    );
  }
}

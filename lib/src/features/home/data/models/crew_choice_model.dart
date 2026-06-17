class CrewChoiceModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final String iconStyle;
  final String status;
  final String timeLabel;
  final int totalVotes;
  final bool hasVoted;
  final int mySelectionIndex;
  final List<PollOption> options;

  CrewChoiceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.iconStyle,
    required this.status,
    required this.timeLabel,
    required this.totalVotes,
    required this.hasVoted,
    required this.mySelectionIndex,
    required this.options,
  });

  factory CrewChoiceModel.fromJson(Map<String, dynamic> json) {
    return CrewChoiceModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      iconStyle: json['iconStyle'] ?? '',
      status: json['status'] ?? '',
      timeLabel: json['timeLabel'] ?? '',
      totalVotes: json['totalVotes'] ?? 0,
      hasVoted: json['hasVoted'] ?? false,
      mySelectionIndex: json['mySelectionIndex'] ?? -1,
      options: (json['options'] as List?)
              ?.map((e) => PollOption.fromJson(e))
              .toList() ?? [],
    );
  }
}

class PollOption {
  final String label;
  final int voteCount;
  final double percentage;

  PollOption({required this.label, required this.voteCount, required this.percentage});

  factory PollOption.fromJson(Map<String, dynamic> json) {
    return PollOption(
      label: json['label'] ?? '',
      voteCount: json['voteCount'] ?? 0,
      percentage: (double.tryParse(json['percentage'].toString()) ?? 0.0) / 100,
    );
  }
}
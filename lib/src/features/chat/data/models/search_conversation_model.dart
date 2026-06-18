class RiderSearchResultModel {
  final String id;
  final String fullName;
  final String memberNumber;
  final String? image;
  final String status;

  RiderSearchResultModel({
    required this.id,
    required this.fullName,
    required this.memberNumber,
    this.image,
    required this.status,
  });

  factory RiderSearchResultModel.fromJson(Map<String, dynamic> json) {
    return RiderSearchResultModel(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      memberNumber: json['memberNumber'] ?? '',
      image: json['image'],
      status: json['status'] ?? '',
    );
  }
}

class DiscoveredChannelModel {
  final String id;
  final String name;
  final int onlineCount;
  final bool isJoined;
  final bool isPending;

  DiscoveredChannelModel({
    required this.id,
    required this.name,
    required this.onlineCount,
    required this.isJoined,
    required this.isPending,
  });

  factory DiscoveredChannelModel.fromJson(Map<String, dynamic> json) {
    return DiscoveredChannelModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      onlineCount: json['onlineCount'] ?? 0,
      isJoined: json['isJoined'] ?? false,
      isPending: json['isPending'] ?? false,
    );
  }
}
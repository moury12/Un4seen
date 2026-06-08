class RideFeedModel {
  final List<RideModel> result;
  final PaginationMeta meta; // Changed from MetaData

  RideFeedModel({required this.result, required this.meta});

  factory RideFeedModel.fromJson(Map<String, dynamic> json) {
    return RideFeedModel(
      result: (json['result'] as List).map((e) => RideModel.fromJson(e)).toList(),
      meta: PaginationMeta.fromJson(json['meta']), // Changed from MetaData
    );
  }
}

// Renamed class to avoid conflict with Flutter's MetaData widget
class PaginationMeta { 
  final int page;
  final int totalPage;
  final int total;

  PaginationMeta({required this.page, required this.totalPage, required this.total});

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta(
      page: json['page'] ?? 1,
      totalPage: json['totalPage'] ?? 1,
      total: json['total'] ?? 0,
    );
  }
}

class RideModel {
  final String id;
  final RideUser user;
  final String bikeModel;
  final String description;
  final String image;
  int heartCount;
  final String rideType;
  bool isHearted;

  RideModel({
    required this.id,
    required this.user,
    required this.bikeModel,
    required this.description,
    required this.image,
    required this.heartCount,
    required this.rideType,
    required this.isHearted,
  });

  factory RideModel.fromJson(Map<String, dynamic> json) {
    return RideModel(
      id: json['_id'] ?? '',
      bikeModel: json['bikeModel'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      heartCount: json['heartCount'] ?? 0,
      rideType: json['rideType'] ?? '',
      isHearted: json['isHearted'] ?? false,
      user: RideUser.fromJson(json['user'] ?? {}),
    );
  }
}

class RideUser {
  final String fullName;
  final String memberNumber;
  final String image;

  RideUser({required this.fullName, required this.memberNumber, required this.image});

  factory RideUser.fromJson(Map<String, dynamic> json) {
    return RideUser(
      fullName: "${json['firstName'] ?? ''} ${json['lastName'] ?? ''}".trim(),
      memberNumber: json['memberNumber'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
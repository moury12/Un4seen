class BikeProfileResponse {
  final BikeModel? activeBike;
  final List<BikeModel> retiredBikes;

  BikeProfileResponse({this.activeBike, required this.retiredBikes});

  factory BikeProfileResponse.fromJson(Map<String, dynamic> json) {
    return BikeProfileResponse(
      activeBike: json['activeBike'] != null ? BikeModel.fromJson(json['activeBike']) : null,
      retiredBikes: (json['retiredBikes'] as List?)?.map((e) => BikeModel.fromJson(e)).toList() ?? [],
    );
  }
}

class BikeModel {
  final String id;
  final String image;
  final String year;
  final String make;
  final String model;
  final String bikeType;
  final String color;
  final List<BikeUpgrade> upgrades;
  final List<String> gallery;
  final bool isRetired;
  final bool isSaved;

  BikeModel({
    required this.id,
    required this.image,
    required this.year,
    required this.make,
    required this.model,
    required this.bikeType,
    required this.color,
    required this.upgrades,
    required this.gallery,
    required this.isRetired,
    required this.isSaved,
  });

  factory BikeModel.fromJson(Map<String, dynamic> json) {
    return BikeModel(
      id: json['_id'] ?? '',
      image: json['image'] ?? '',
      year: json['year']?.toString() ?? '',
      make: json['make'] ?? '',
      model: json['model'] ?? '',
      bikeType: json['bikeType'] ?? '',
      color: json['color'] ?? '',
      upgrades: (json['upgrades'] as List?)?.map((e) => BikeUpgrade.fromJson(e)).toList() ?? [],
      gallery: List<String>.from(json['gallery'] ?? []),
      isRetired: json['isRetired'] ?? false,
      isSaved: json['isSaved'] ?? false,
    );
  }
}

class BikeUpgrade {
  final String title;
  final List<String> items;
  final String id;

  BikeUpgrade({required this.title, required this.items, required this.id});

  factory BikeUpgrade.fromJson(Map<String, dynamic> json) {
    return BikeUpgrade(
      title: json['title'] ?? '',
      items: List<String>.from(json['items'] ?? []),
      id: json['_id'] ?? '',
    );
  }
}

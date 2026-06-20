class BikeProfileResponse {
  final BikeModel? activeBike;
  final List<BikeModel> retiredBikes;

  BikeProfileResponse({this.activeBike, required this.retiredBikes});

  factory BikeProfileResponse.fromJson(Map<String, dynamic> json) {
    return BikeProfileResponse(
      activeBike: json['activeBike'] != null
          ? BikeModel.fromJson(json['activeBike'])
          : null,
      retiredBikes:
          (json['retiredBikes'] as List?)
              ?.map((e) => BikeModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}

// lib/src/features/bike_profiles/data/models/bike_model.dart

class BikeOwner {
  final String id;
  final String firstName;
  final String lastName;
  final String image;

  String get fullName => '$firstName $lastName'.trim();

  BikeOwner({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.image,
  });

  factory BikeOwner.fromJson(Map<String, dynamic> json) {
    return BikeOwner(
      id: json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      image: json['image'] ?? '',
    );
  }
}

class SavedBikeItem {
  final String id;
  final BikeModel bike;

  SavedBikeItem({required this.id, required this.bike});

  factory SavedBikeItem.fromJson(Map<String, dynamic> json) {
    return SavedBikeItem(
      id: json['_id'] ?? '',
      bike: BikeModel.fromJson(json['bike'] ?? {}),
    );
  }
}

// lib/src/features/bike_profiles/data/models/bike_model.dart

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
  final BikeOwner? user; 

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
    this.user,
  });

  factory BikeModel.fromJson(Map<String, dynamic> json) {
    // Dynamic type check to handle both Populated Object and Plain String ID
    BikeOwner? parsedUser;
    if (json['user'] != null) {
      if (json['user'] is Map<String, dynamic>) {
        parsedUser = BikeOwner.fromJson(json['user']);
      } else if (json['user'] is String) {
        parsedUser = BikeOwner(
          id: json['user'],
          firstName: '',
          lastName: '',
          image: '',
        );
      }
    }

    return BikeModel(
      id: json['_id'] ?? '',
      image: json['image'] ?? '',
      year: json['year']?.toString() ?? '',
      make: json['make'] ?? '',
      model: json['model'] ?? '',
      bikeType: json['bikeType'] ?? '',
      color: json['color'] ?? '',
      upgrades: (json['upgrades'] as List?)
              ?.map((e) => BikeUpgrade.fromJson(e))
              .toList() ?? [],
      gallery: List<String>.from(json['gallery'] ?? []),
      isRetired: json['isRetired'] ?? false,
      isSaved: json['isSaved'] ?? false,
      user: parsedUser,
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

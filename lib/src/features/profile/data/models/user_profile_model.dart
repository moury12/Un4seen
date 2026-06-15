class UserProfileModel {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? fullName;
  final String? email;
  final String? role;
  final String? status;
  final String? aboutMe;
  final String? facebookURL;
  final String? instagramURL;
  final String? tiktokURL;
  final List<String> followers;
  final List<String> following;
  final int followerCount;
  final int followingCount;
  final int shredPoints;
  final String? country;
  final bool isProfileBonusClaimed;
  final bool isProfileComplete;
  final bool isOtpVerified;
  final String? memberNumber;
  final String? referralCode;
  final int referralCount;
  final List<String> referrals;
  final String? referredBy;
  final String? clothingFit;
  final String? dob;
  final String? hoodieSize;
  final String? phoneNumber;
  final String? tShirtSize;
  final String? image;
  final bool isFollowing;
  final Address? address;
  final RideInfo? rideInfo;
  final ActiveBike? activeBike;
  final Journey? journey;
  final String? createdAt;
  final String? updatedAt;

  UserProfileModel({
    this.id,
    this.firstName,
    this.lastName,
    this.fullName,
    this.email,
    this.role,
    this.status,
    this.aboutMe,
    this.facebookURL,
    this.instagramURL,
    this.tiktokURL,
    this.followers = const [],
    this.following = const [],
    this.followerCount = 0,
    this.followingCount = 0,
    this.shredPoints = 0,
    this.country,
    this.isProfileBonusClaimed = false,
    this.isProfileComplete = false,
    this.isOtpVerified = false,
    this.memberNumber,
    this.referralCode,
    this.referralCount = 0,
    this.referrals = const [],
    this.referredBy,
    this.clothingFit,
    this.dob,
    this.hoodieSize,
    this.phoneNumber,
    this.tShirtSize,
    this.image,
    this.isFollowing = false,
    this.address,
    this.rideInfo,
    this.activeBike,
    this.journey,
    this.createdAt,
    this.updatedAt,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      fullName: json['fullName'],
      email: json['email'],
      role: json['role'],
      status: json['status'],
      aboutMe: json['aboutMe'],
      facebookURL: json['facebookURL'],
      instagramURL: json['instagramURL'],
      tiktokURL: json['tiktokURL'],
      followers: List<String>.from(json['followers'] ?? []),
      following: List<String>.from(json['following'] ?? []),
      followerCount: json['followerCount'] ?? 0,
      followingCount: json['followingCount'] ?? 0,
      shredPoints: json['shredPoints'] ?? 0,
      country: json['country'],
      isProfileBonusClaimed: json['isProfileBonusClaimed'] ?? false,
      isProfileComplete: json['isProfileComplete'] ?? false,
      isOtpVerified: json['isOtpVerified'] ?? false,
      memberNumber: json['memberNumber'],
      referralCode: json['referralCode'],
      referralCount: json['referralCount'] ?? 0,
      referrals: List<String>.from(json['referrals'] ?? []),
      referredBy: json['referredBy'],
      clothingFit: json['clothingFit'],
      dob: json['dob'],
      hoodieSize: json['hoodieSize'],
      phoneNumber: json['phoneNumber'],
      tShirtSize: json['tShirtSize'],
      image: json['image'],
      isFollowing: json['isFollowing'] ?? false,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      address: json['address'] != null ? Address.fromJson(json['address']) : null,
      rideInfo: json['rideInfo'] != null ? RideInfo.fromJson(json['rideInfo']) : null,
      activeBike: json['activeBike'] != null ? ActiveBike.fromJson(json['activeBike']) : null,
      journey: json['journey'] != null ? Journey.fromJson(json['journey']) : null,
    );
  }
}

class Address {
  final String? streetAddress;
  final String? city;
  final String? postalCode;
  final String? state;

  Address({this.streetAddress, this.city, this.postalCode, this.state});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      streetAddress: json['streetAddress'],
      city: json['city'],
      postalCode: json['postalCode'],
      state: json['state'],
    );
  }
}

class RideInfo {
  final String? bikeModel;
  final String? year;
  final List<String> rideType;
  final String? ridingLevel;

  RideInfo({this.bikeModel, this.year, this.rideType = const [], this.ridingLevel});

  factory RideInfo.fromJson(Map<String, dynamic> json) {
    return RideInfo(
      bikeModel: json['bikeModel'],
      year: json['year'],
      rideType: List<String>.from(json['rideType'] ?? []),
      ridingLevel: json['ridingLevel'],
    );
  }
}

class ActiveBike {
  final String? id;
  final String? image;
  final String? year;
  final String? make;
  final String? model;

  ActiveBike({this.id, this.image, this.year, this.make, this.model});

  factory ActiveBike.fromJson(Map<String, dynamic> json) {
    return ActiveBike(
      id: json['_id'],
      image: json['image'],
      year: json['year'],
      make: json['make'],
      model: json['model'],
    );
  }
}

class Journey {
  final String? memberSince;
  final String? totalDuration;
  final Milestones? milestones;

  Journey({this.memberSince, this.totalDuration, this.milestones});

  factory Journey.fromJson(Map<String, dynamic> json) {
    return Journey(
      memberSince: json['memberSince'],
      totalDuration: json['totalDuration'],
      milestones: json['milestones'] != null ? Milestones.fromJson(json['milestones']) : null,
    );
  }
}

class Milestones {
  final bool is3moReached;
  final bool is6moReached;
  final bool is1yrReached;
  final bool is2yrReached;
  final bool is3yrReached;
  final bool is4yrReached;
  final bool is5yrReached;

  Milestones({
    this.is3moReached = false,
    this.is6moReached = false,
    this.is1yrReached = false,
    this.is2yrReached = false,
    this.is3yrReached = false,
    this.is4yrReached = false,
    this.is5yrReached = false,
  });

  factory Milestones.fromJson(Map<String, dynamic> json) {
    return Milestones(
      is3moReached: json['is3moReached'] ?? false,
      is6moReached: json['is6moReached'] ?? false,
      is1yrReached: json['is1yrReached'] ?? false,
      is2yrReached: json['is2yrReached'] ?? false,
      is3yrReached: json['is3yrReached'] ?? false,
      is4yrReached: json['is4yrReached'] ?? false,
      is5yrReached: json['is5yrReached'] ?? false,
    );
  }
}
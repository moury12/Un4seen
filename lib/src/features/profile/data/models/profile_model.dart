class ProfileModel {
  final Address? address;
  final RideInfo? rideInfo;
  final String? aboutMe;
  final String? facebookURL;
  final String? instagramURL;
  final String? tiktokURL;
  final int followerCount;
  final int followingCount;
  final String? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? fullName;
  final String? memberNumber;
  final int shredPoints;
  final String? country;
  final String? clothingFit;
  final String? tShirtSize;
  final String? hoodieSize;
  final String? phoneNumber;
  final String? dob;
  final String? profilePicture;
  final String? lastDailyClaimDate;
  final String? role;
  final String? status;
  final bool isProfileComplete;
  final bool isOtpVerified;
  final bool isProfileBonusClaimed;
  final int lastBirthdayRewardYear;
  final String? referralCode;
  final int referralCount;
  final String? referredBy;
  final List<String> referrals;
  final String? createdAt;
  final String? updatedAt;

  ProfileModel({
    this.address,
    this.rideInfo,
    this.aboutMe,
    this.facebookURL,
    this.instagramURL,
    this.tiktokURL,
    this.followerCount = 0,
    this.followingCount = 0,
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.fullName,
    this.memberNumber,
    this.shredPoints = 0,
    this.country,
    this.clothingFit,
    this.tShirtSize,
    this.hoodieSize,
    this.phoneNumber,
    this.dob,
    this.profilePicture,
    this.lastDailyClaimDate,
    this.role,
    this.status,
    this.isProfileComplete = false,
    this.isOtpVerified = false,
    this.isProfileBonusClaimed = false,
    this.lastBirthdayRewardYear = 0,
    this.referralCode,
    this.referralCount = 0,
    this.referredBy,
    this.referrals = const [],
    this.createdAt,
    this.updatedAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['_id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      fullName: json['fullName'],
      memberNumber: json['memberNumber'],
      shredPoints: json['shredPoints'] ?? 0,
      country: json['country'],
      aboutMe: json['aboutMe'],
      profilePicture: json['image'], // Mapping 'image' key to profilePicture
      facebookURL: json['facebookURL'],
      instagramURL: json['instagramURL'],
      tiktokURL: json['tiktokURL'],
      followerCount: json['followerCount'] ?? 0,
      followingCount: json['followingCount'] ?? 0,
      clothingFit: json['clothingFit'],
      tShirtSize: json['tShirtSize'],
      hoodieSize: json['hoodieSize'],
      phoneNumber: json['phoneNumber'],
      dob: json['dob'],
      lastDailyClaimDate: json['lastDailyClaimDate'],
      role: json['role'],
      status: json['status'],
      isProfileComplete: json['isProfileComplete'] ?? false,
      isOtpVerified: json['isOtpVerified'] ?? false,
      isProfileBonusClaimed: json['isProfileBonusClaimed'] ?? false,
      lastBirthdayRewardYear: json['lastBirthdayRewardYear'] ?? 0,
      referralCode: json['referralCode'],
      referralCount: json['referralCount'] ?? 0,
      referredBy: json['referredBy'],
      referrals: List<String>.from(json['referrals'] ?? []),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      address: json['address'] != null ? Address.fromJson(json['address']) : null,
      rideInfo: json['rideInfo'] != null ? RideInfo.fromJson(json['rideInfo']) : null,
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
  final List<String> rideType;
  final String? ridingLevel;
  final String? bikeModel;
  final String? year;

  RideInfo({
    required this.rideType,
    this.ridingLevel,
    this.bikeModel,
    this.year,
  });

  factory RideInfo.fromJson(Map<String, dynamic> json) {
    return RideInfo(
      rideType: List<String>.from(json['rideType'] ?? []),
      ridingLevel: json['ridingLevel'],
      bikeModel: json['bikeModel'],
      year: json['year'],
    );
  }
}
// lib/src/features/un4seen_world/data/models/brand_model.dart

class BrandModel {
  final String id;
  final String title;
  final String subTitle;
  final String description;
  final String discountCode;
  final String link;
  final String image;

  BrandModel({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.discountCode,
    required this.link,
    required this.image,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      subTitle: json['subTitle'] ?? '',
      description: json['description'] ?? '',
      discountCode: json['discountCode'] ?? '',
      link: json['link'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
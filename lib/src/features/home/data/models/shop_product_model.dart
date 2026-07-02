



class ProductModel {
  final int id;
  final String title;
  final String handle;
  final String price;
  final String? compareAtPrice;
  final String? discountPercentage;
  final String image;
  final String brand;
  final String category;
  final String productUrl;

  ProductModel({
    required this.id, required this.title, required this.handle,
    required this.price, this.compareAtPrice, this.discountPercentage,
    required this.image, required this.brand, required this.category,
    required this.productUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      handle: json['handle'] ?? '',
      price: json['price'] ?? '0.00',
      compareAtPrice: json['compareAtPrice'],
      discountPercentage: json['discountPercentage']?.toString(),
      image: json['image'] ?? '',
      brand: json['brand'] ?? 'Un4seen',
      category: json['category'] ?? '',
      productUrl: json['productUrl'] ?? '',
    );
  }
}
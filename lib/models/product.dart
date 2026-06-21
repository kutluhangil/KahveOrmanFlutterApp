/// Tek bir ürünü temsil eden veri modeli.
class Product {
  final int id;
  final String name;
  final num price;
  final String category;
  final String image; // görsel URL
  final String tagline;
  final String description;
  final String roast;
  final String origin;
  final String weight;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.image,
    required this.tagline,
    required this.description,
    required this.roast,
    required this.origin,
    required this.weight,
  });

  /// JSON map'inden Product üretir.
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      price: json['price'] as num,
      category: json['category'] as String,
      image: json['image'] as String,
      tagline: json['tagline'] as String,
      description: json['description'] as String,
      roast: json['roast'] as String,
      origin: json['origin'] as String,
      weight: json['weight'] as String,
    );
  }

  /// Product'ı tekrar JSON map'ine çevirir.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'category': category,
      'image': image,
      'tagline': tagline,
      'description': description,
      'roast': roast,
      'origin': origin,
      'weight': weight,
    };
  }
}

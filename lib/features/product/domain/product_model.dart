class Product{
  final String id;
  final String name;
  final String image;

  Product({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      // JSON dari API bentuknya angka, kita paksa jadi String (toString)
      id: json['id'].toString(),
      name: json['title'] ?? 'Tanpa Nama',
      image: json['image'] ?? "",
    );
  }
}
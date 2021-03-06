class ProductModel{
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final Map<String, dynamic> rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json){
    return ProductModel(
      id: json["id"],
      title: json["title"],
      price: double.parse(json["price"].toString()),
      description: json["description"],
      category: json["category"],
      image: json["image"],
      rating: json["rating"],
    );
  }  
}
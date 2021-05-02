part of 'models.dart';

class Product {
  final String id,
      title,
      location,
      merchant,
      ishalal,
      stock,
      photo,
      category,
      weight;
  final int price;

  Product(
      {this.id,
      this.title,
      this.location,
      this.merchant,
      this.category,
      this.photo,
      this.price,
      this.ishalal,
      this.stock,
      this.weight});

  factory Product.getProduct(Map<String, dynamic> object) {
    return Product(
        id: object["id"],
        title: object["title"],
        location: object["location_name"],
        merchant: object["added_user_name"],
        photo: object["img_path"],
        price: object["price"],
        category: object["cat_name"],
        ishalal: object["is_halal"],
        stock: object["stock"],
        weight: object["weight"]);
  }
}

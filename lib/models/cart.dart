part of 'models.dart';

class Cart {
  String id, title, location, merchant, ishalal, photo;
  int price, stock, quantity, subtotal;
  double weight, totalweight;
  Cart(
      {this.id,
      this.title,
      this.location,
      this.merchant,
      this.photo,
      this.price,
      this.ishalal,
      this.totalweight,
      this.stock,
      this.weight,
      this.quantity,
      this.subtotal});

  Map<String, dynamic> toMap() {
    return {
      'product_id': id,
      'title': title,
      'location': location,
      'merchant': merchant,
      'price': price,
      'ishalal': ishalal,
      'stock': stock,
      'photo': photo,
      'totalweight': totalweight,
      'weight': weight,
      'quantity': quantity,
      'subtotal': subtotal
    };
  }
}

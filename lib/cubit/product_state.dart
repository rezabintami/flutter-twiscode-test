part of 'product_cubit.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoaded extends ProductState {
  List<Product> product;
  List<String> category = List();
  ProductLoaded({this.product, this.category});

  ProductLoaded copyWith({List<Product> product, List<String> category}) {
    return ProductLoaded(
        product: product ?? this.product, category: category ?? this.category);
  }
}

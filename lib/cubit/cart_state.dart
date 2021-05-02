part of 'cart_cubit.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  List<Cart> cart;

  CartLoaded({this.cart});

  CartLoaded copyWith({List<Cart> cart}) {
    return CartLoaded(
      cart: cart ?? this.cart,
    );
  }
}

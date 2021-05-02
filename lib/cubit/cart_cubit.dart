import 'package:bloc/bloc.dart';
import 'package:twistcode_test/models/models.dart';
import 'package:twistcode_test/services/services.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  List<Cart> cart;
  getCart() async {
    if (state is CartInitial) {
      cart = await CartServices.getCart();
      print(cart.length);
      emit(CartLoaded(cart: cart));
    }
  }

  returnCart() {
    emit(CartInitial());
  }
}

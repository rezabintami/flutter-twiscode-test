import 'package:bloc/bloc.dart';
import 'package:twistcode_test/models/models.dart';
import 'package:twistcode_test/services/services.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  List<Product> product;

  List<Product> productcategory;
  List<Product> productallcategory = [];

  getProduct() async {
    if (state is ProductInitial) {
      product = await ProductServices.getproduct();
      emit(ProductLoaded(product: product));
    }
  }

  getProductbyCategory(List<String> category, String filter) async {
    if (state is ProductInitial) {
      if (category.isEmpty) {
        productallcategory = await ProductServices.getproduct();
        if (filter == "Tertinggi") {
          productallcategory.sort((a, b) => b.price.compareTo(a.price));
        } else if (filter == "Terendah") {
          productallcategory.sort((a, b) => a.price.compareTo(b.price));
        }
      } else {
        productallcategory = [];
        product = await ProductServices.getproduct();
        category.forEach((element) {
          productcategory =
              product.where((product) => product.category == element).toList();
          productcategory.forEach((product) {
            productallcategory.add(product);
          });
        });

        if (filter == "Tertinggi") {
          productallcategory.sort((a, b) => b.price.compareTo(a.price));
        } else if (filter == "Terendah") {
          productallcategory.sort((a, b) => a.price.compareTo(b.price));
        }
      }
      emit(ProductLoaded(product: productallcategory, category: category));
    }
  }

  returnProduct() {
    emit(ProductInitial());
  }
}

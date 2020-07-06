import 'package:flutter/widgets.dart';
import '../Model/Cart_model.dart';

class MyProvider with ChangeNotifier {
  List<CartProduct> _cartProductList = [];
  CartProduct cartProduct;
  void addCartProduct({
    String foodName,
    String foodType,
    String foodImage,
    double foodPrice,
    int foodQuntaties,
  }) {
    cartProduct = CartProduct(
        foodName: foodName,
        foodType: foodType,
        foodImage: foodImage,
        foodPrice: foodPrice,
        foodQuantity: foodQuntaties);
    _cartProductList.add(cartProduct);
  }

  List<CartProduct> get allProductList {
    return List.from(_cartProductList);
  }

  int get cartProductlength {
    return _cartProductList.length;
  }

  get cartFoodList {
    return _cartProductList;
  }
}

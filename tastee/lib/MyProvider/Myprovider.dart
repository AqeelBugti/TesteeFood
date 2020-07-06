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
    notifyListeners();
  }

  List<CartProduct> get allProductList {
    return List.from(_cartProductList);
  }

  int get cartProductlength {
    return _cartProductList.length;
  }

  // double get getTotalPrice {
  //   List<double> totalPrice = [];
  //   double price = 0.0;
  //   _cartProductList.forEach((element) {
  //     price = element.foodPrice;
  //     totalPrice.add(price);
  //   });
  //   double lastPrice;
  //   totalPrice.forEach((element) {
  //     lastPrice = element;
  //   });
  //   print(lastPrice);
  //   return price;
  // }

  List<CartProduct> get cartFoodList {
    return _cartProductList;
  }
}

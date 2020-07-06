import 'package:flutter/material.dart';
class CartProduct {
  final String foodImage;
  final int foodQuantity;
  final String foodName;
  final String foodType;
  final double foodPrice;
  CartProduct(
      {@required this.foodName,
      @required this.foodType,
      @required this.foodImage,
      @required this.foodPrice,
      @required this.foodQuantity});
}
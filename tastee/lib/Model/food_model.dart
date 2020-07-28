import 'package:flutter/material.dart';
class Food {
  String foodName;
  String foodType;
  double rating;
  double price;
  String image;
  Food({
    @required this.foodName,
    @required this.foodType,
    @required this.rating,
    @required this.price,
    @required this.image,
  });
}
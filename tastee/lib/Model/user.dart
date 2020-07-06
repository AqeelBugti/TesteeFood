import 'package:flutter/material.dart';

class User {
  String fullName;
  String email;
  String password;
  int contactNumber;
  String gender;
  String address;
  String image;
  String imagePath;
  User({
    @required this.fullName,
    @required this.email,
    @required this.password,
    @required this.contactNumber,
    @required this.gender,
    @required this.address,
    @required this.image,
    @required this.imagePath,
  });
}

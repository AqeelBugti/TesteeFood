import 'package:flutter/material.dart';
import './homepage.dart';
import '../Wigets/circle_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/food_model.dart';

class FoodCatagory extends StatefulWidget {
  @override
  _FoodCatagoryState createState() => _FoodCatagoryState();
}

class _FoodCatagoryState extends State<FoodCatagory> {
  Food pastaFood;
  Food chickenBrost;
  Food fishFry;
  Widget _pastaCheese({
    @required String tasteeFoodName,
    @required double tasteeFoodPrice,
    @required String tasteeFoodImage,
    @required double tasteeFoodRating,
    @required String tasteeFoodType,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          CircleContainer(
            foodName: tasteeFoodName,
            foodType: tasteeFoodType,
            foodRating: tasteeFoodRating,
            foodPrice: tasteeFoodPrice,
            foodImage: tasteeFoodImage,
          ),
          CircleContainer(
            foodName: tasteeFoodName,
            foodType: tasteeFoodType,
            foodRating: tasteeFoodRating,
            foodPrice: tasteeFoodPrice,
            foodImage: tasteeFoodImage,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Firestore.instance
        .collection('Category')
        .document("vegetable")
        .collection("Pasta Cheese")
        .document("UDXaitgT8Gp2TVKSQbFV")
        .snapshots()
        .listen((event) {
      setState(() {
        pastaFood = Food(
            foodName: event["foodName"],
            foodType: event["foodType"],
            price: event["foodPrice"],
            rating: event["foodRating"],
            reathings: event["reatings"],
            image: event["foodImage"]);
      });
    });
    Firestore.instance
        .collection('Category')
        .document("vegetable")
        .collection("Chicken Brost")
        .document("3d8f0sbTRIdeASH89ITy")
        .snapshots()
        .listen((event) {
      print(event['foodPrice']);
      print(event['foodName']);
      setState(() {
        chickenBrost = Food(
            foodName: event["foodName"],
            foodType: event["foodType"],
            price: event["foodPrice"],
            rating: event["foodRating"],
            reathings: event["reatings"],
            image: event["foodImage"]);
      });
    });
    Firestore.instance
        .collection('Category')
        .document("vegetable")
        .collection("Fish Fry")
        .document("MnUTBhwMCpCyhp5zFrOP")
        .snapshots()
        .listen((event) {
      print(event['foodPrice']);
      //print(event['foodName']);
      setState(() {
        fishFry = Food(
            foodName: event["foodName"],
            foodType: event["foodType"],
            price: event["foodPrice"],
            rating: event["foodRating"],
            reathings: event["reatings"],
            image: event["foodImage"]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        title: Text(
          "Pizza",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            _pastaCheese(
                tasteeFoodName: pastaFood.foodName,
                tasteeFoodImage: pastaFood.image,
                tasteeFoodPrice: pastaFood.price,
                tasteeFoodRating: pastaFood.rating,
                tasteeFoodType: pastaFood.foodType),
            _pastaCheese(
                tasteeFoodName: chickenBrost.foodName,
                tasteeFoodImage: chickenBrost.image,
                tasteeFoodPrice: chickenBrost.price,
                tasteeFoodRating: chickenBrost.rating,
                tasteeFoodType: chickenBrost.foodType),
            _pastaCheese(
                tasteeFoodName: fishFry.foodName,
                tasteeFoodImage: fishFry.image,
                tasteeFoodPrice: fishFry.price,
                tasteeFoodRating: fishFry.rating,
                tasteeFoodType: fishFry.foodType),
            _pastaCheese(
                tasteeFoodName: pastaFood.foodName,
                tasteeFoodImage: pastaFood.image,
                tasteeFoodPrice: pastaFood.price,
                tasteeFoodRating: pastaFood.rating,
                tasteeFoodType: pastaFood.foodType),
            _pastaCheese(
                tasteeFoodName: chickenBrost.foodName,
                tasteeFoodImage: chickenBrost.image,
                tasteeFoodPrice: chickenBrost.price,
                tasteeFoodRating: chickenBrost.rating,
                tasteeFoodType: chickenBrost.foodType),
            _pastaCheese(
                tasteeFoodName: fishFry.foodName,
                tasteeFoodImage: fishFry.image,
                tasteeFoodPrice: fishFry.price,
                tasteeFoodRating: fishFry.rating,
                tasteeFoodType: fishFry.foodType),
            _pastaCheese(
                tasteeFoodName: pastaFood.foodName,
                tasteeFoodImage: pastaFood.image,
                tasteeFoodPrice: pastaFood.price,
                tasteeFoodRating: pastaFood.rating,
                tasteeFoodType: pastaFood.foodType),
            _pastaCheese(
                tasteeFoodName: chickenBrost.foodName,
                tasteeFoodImage: chickenBrost.image,
                tasteeFoodPrice: chickenBrost.price,
                tasteeFoodRating: chickenBrost.rating,
                tasteeFoodType: chickenBrost.foodType),
            _pastaCheese(
                tasteeFoodName: fishFry.foodName,
                tasteeFoodImage: fishFry.image,
                tasteeFoodPrice: fishFry.price,
                tasteeFoodRating: fishFry.rating,
                tasteeFoodType: fishFry.foodType),
          ],
        ),
      ),
    );
  }
}

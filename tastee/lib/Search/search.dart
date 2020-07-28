
import 'package:provider/provider.dart';
import '../MyProvider/Myprovider.dart';
import '../Model/food_model.dart';
import '../Wigets/circle_container.dart';
import 'package:flutter/material.dart';

class Search extends SearchDelegate<Food> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context, listen: false);
    var search = provider.getMyFoodList;
    final result =
        search.where((s) => s.foodName.toLowerCase().contains(query));

    return GridView.count(
        childAspectRatio: 0.87,
        crossAxisCount: 2,
        padding: EdgeInsets.only(top: 10),
        children: result
            .map<Widget>(
              (e) => CircleContainer(
                  foodName: e.foodName,
                  foodType: e.foodType,
                  foodPrice: e.price,
                  foodImage: e.image,
                  foodRating: e.rating),
            )
            .toList());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context, listen: false);
    var search = provider.getMyFoodList;
    final result =
        search.where((s) => s.foodName.toLowerCase().contains(query));

    return GridView.count(
        childAspectRatio: 0.87,
        crossAxisCount: 2,
        padding: EdgeInsets.only(top: 10),
        children: result
            .map<Widget>(
              (e) => CircleContainer(
                  foodName: e.foodName,
                  foodType: e.foodType,
                  foodPrice: e.price,
                  foodImage: e.image,
                  foodRating: e.rating),
            )
            .toList());
  }
}

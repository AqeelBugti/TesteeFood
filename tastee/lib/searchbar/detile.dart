import 'package:flutter/material.dart';
import 'package:tastee/Wigets/circle_container.dart';
import './data_page.dart';

class Detail extends StatefulWidget {
  final ListWords listWordsDetail;

  Detail({Key key, @required this.listWordsDetail}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: const Text('Détail', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.70,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: <Widget>[
          CircleContainer(
            foodName: "Pasta",
            foodType: "Chicken",
            foodPrice: 20,
            foodImage: "images/tony.jpg",
            foodRating: 4.5,
          ),
          CircleContainer(
            foodName: "Chicken",
            foodType: "Chicken",
            foodPrice: 20,
            foodImage: "images/tony.jpg",
            foodRating: 4.5,
          ),
        ],
      ),
    );
  }
}

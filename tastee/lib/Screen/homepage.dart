import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './cart.dart';
import './contact_number.dart';
import './detailpage.dart';
import './profile.dart';
import './about_page.dart';
import './food_catagory.dart';
import '../Wigets/circle_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Model/food_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Food food;
  var uid;
  var userImage;
  void getUserImage() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    uid = user.uid;
  }

  Widget _rowContainer({Function whenPress}) {
    return GestureDetector(
      onTap: whenPress,
      child: Container(
        height: 200,
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              height: 200,
              width: 175,
              padding: EdgeInsets.only(top: 20),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 120,
                    child: Image.asset('images/chicken.jpg'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Pasta",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileText(context) {
    return Column(
      children: <Widget>[
        Container(
          height: 190,
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.only(left: 35),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                child: CircleAvatar(
                  radius: 55,
                  backgroundImage: NetworkImage(userImage),
                ),
                radius: 60,
                backgroundColor: Colors.white,
              ),
              Container(
                padding: EdgeInsets.only(top: 20, left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Have you upset",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Stomach?",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _search() {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 160, right: 10),
      child: TextFormField(
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            hintText: 'Search',
            suffixIcon: Icon(
              Icons.search,
            ),
            fillColor: Colors.white,
            filled: true),
      ),
    );
  }

  Widget _featuredAndSeeAll({Function whenPress, context}) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Featured",
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: whenPress,
            child: Text(
              "See all",
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawarCardWidget({IconData icons, String name, Function whenPress}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: Colors.white,
      child: ListTile(
        onTap: whenPress,
        leading: IconButton(
          icon: Icon(icons),
          onPressed: () {},
        ),
        title: Container(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    getUserImage();
    return Scaffold(
      backgroundColor: Color(0xfff0f1f2),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {},
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      drawer: Drawer(
        child: SafeArea(
          child: Container(
            color: Color(0xfff8f8f8),
            child: ListView(
              children: <Widget>[
                Container(
                  height: 80,
                  child: DrawerHeader(
                    child: Text(
                      'Tastee',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Divider(
                  indent: 14,
                  endIndent: 14,
                ),
                _drawarCardWidget(
                  icons: Icons.home,
                  name: 'Home',
                  whenPress: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                ),
                _drawarCardWidget(
                    icons: Icons.shopping_cart,
                    name: 'Cart',
                    whenPress: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Cart()));
                    }),
                _drawarCardWidget(
                    icons: Icons.location_on,
                    name: 'Address',
                    whenPress: () {}),
                _drawarCardWidget(
                    icons: Icons.notifications_none,
                    name: 'Notification',
                    whenPress: () {}),
                _drawarCardWidget(
                    icons: Icons.perm_identity,
                    name: 'Profile',
                    whenPress: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Profile()));
                    }),
                _drawarCardWidget(
                    icons: Icons.perm_identity,
                    name: 'Orders',
                    whenPress: () {}),
                Divider(
                  indent: 14,
                  endIndent: 14,
                ),
                _drawarCardWidget(
                  icons: Icons.info,
                  name: 'About',
                  whenPress: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => AboutPage()));
                  },
                ),
                _drawarCardWidget(
                  icons: Icons.phone,
                  name: 'Contact',
                  whenPress: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => ContactNumber()));
                  },
                ),
                Divider(
                  indent: 14,
                  endIndent: 14,
                ),
                _drawarCardWidget(
                  icons: Icons.exit_to_app,
                  name: 'Logout',
                  whenPress: () {
                    FirebaseAuth.instance.signOut();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('food')
              .document("pjCgmWbz6hw0Cto4uBCh")
              .snapshots(),
          builder: (ctx, foodSnapShot) {
            if (foodSnapShot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            food = Food(
              foodName: foodSnapShot.data["foodName"],
              foodType: foodSnapShot.data["foodtitle"],
              price: foodSnapShot.data["foodPrice"],
              rating: foodSnapShot.data["rating"],
              reathings: foodSnapShot.data["Reatings"],
              image: foodSnapShot.data["image"],
            );
            return StreamBuilder(
                stream: Firestore.instance.collection("user").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var myDocuments = snapshot.data.documents;
                  myDocuments.forEach((checkDocument) {
                    if (uid == checkDocument["UserId"]) {
                      userImage = checkDocument["UserImageUrl"];
                    }
                  });
                  return Container(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 250,
                            ),
                            child: ListView(
                              children: <Widget>[
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: <Widget>[
                                      _rowContainer(whenPress: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FoodCatagory()));
                                      }),
                                      _rowContainer(whenPress: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FoodCatagory()));
                                      }),
                                      _rowContainer(whenPress: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FoodCatagory()));
                                      }),
                                      _rowContainer(whenPress: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FoodCatagory()));
                                      }),
                                      _rowContainer(whenPress: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FoodCatagory()));
                                      }),
                                    ],
                                  ),
                                ),
                                _featuredAndSeeAll(
                                  context: context,
                                  whenPress: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FoodCatagory()));
                                  },
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: <Widget>[
                                      CircleContainer(
                                        foodName: food.foodName,
                                        foodType: food.foodType,
                                        foodPrice: food.price,
                                        foodRating: food.rating,
                                        foodImage: food.image,
                                        whenPress: () {
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) => DetailPage(
                                                foodImage: food.image,
                                                foodName: food.foodName,
                                                foodPrice: food.price,
                                                foodType: food.foodType,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        _profileText(context),
                        _search(),
                      ],
                    ),
                  );
                });
          }),
    );
  }
}

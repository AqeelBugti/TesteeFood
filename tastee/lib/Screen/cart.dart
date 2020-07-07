import 'package:flutter/material.dart';
import '../Wigets/RaisedButton.dart';
import 'package:provider/provider.dart';
import '../MyProvider/Myprovider.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  MyProvider provider;
  double total = 0.0;

  Widget _cartWiget(BuildContext context, int index) {
    var allCartProduct = provider.allProductList;

    return Dismissible(
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Delete'),
              content: Text('Are you sure ?'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    // Navigator.pop(context, false);
                    Navigator.of(
                      context,
                      // rootNavigator: true,
                    ).pop(false);
                  },
                  child: Text('No'),
                ),
                FlatButton(
                  color: Colors.red,
                  onPressed: () {
                    // Navigator.pop(context, true);
                    Navigator.of(
                      context,
                      // rootNavigator: true,
                    ).pop(true);
                  },
                  child: Text('Yes'),
                ),
              ],
            );
          },
        );
      },
      key: UniqueKey(),

      //crossAxisEndOffset: 0.9,
      onDismissed: (direction) {
        provider.deleteCartFood(index);
        total -= allCartProduct[index].foodPrice;
        Scaffold.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).accentColor,
            content: Text(
              'Yesh Delete kr De Bhai',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
      background: Container(
        padding: const EdgeInsets.only(right: 20.0),
        // alignment: AlignmentDirectional.centerEnd,
        alignment: Alignment.centerRight,
        // color: Theme.of(context).primaryColor,
        // child: Icon(
        //   Icons.delete,
        //   size: 32.0,
        //   color: Theme.of(context).accentColor,
        // ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            child: ListTile(
              leading: Container(
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      NetworkImage(allCartProduct[index].foodImage),
                ),
              ),
              title: Container(
                padding: EdgeInsets.only(left: 4),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${allCartProduct[index].foodQuantity}x',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            allCartProduct[index].foodName,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            allCartProduct[index].foodType,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              trailing: Text(
                " \$${allCartProduct[index].foodPrice}",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).accentColor),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _totalPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Total",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Text(
          "\$$total",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  void initState() {
    MyProvider provider = Provider.of<MyProvider>(context, listen: false);
    var check = provider.cartFoodList;
    check.forEach((element) {
      total += element.foodPrice;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          "Cart",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                child: ListView.builder(
                  itemBuilder: _cartWiget,
                  itemCount: provider.cartProductlength,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(28),
                width: double.infinity,
                color: Theme.of(context).primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _totalPrice(),
                    Container(
                      height: 60,
                      width: double.infinity,
                      child: MyRaisedutton(
                        buttonText: 'Submit',
                        textColor: Theme.of(context).primaryColor,
                        myColor: Colors.white,
                        whenPress: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Dismissible(
//   background: Container(
//     color: Colors.red,
//     height: 20,
//   ),
//   key: ValueKey(allCartProduct),
//   onDismissed: (direction) {
//     setState(() {
//       allCartProduct.removeAt(index);
//     });

//     Scaffold.of(context).showSnackBar(
//       SnackBar(
//         content: Text("$allCartProduct dismissed"),
//       ),
//     );
//   },
//   child:

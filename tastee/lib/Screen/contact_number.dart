import 'package:flutter/material.dart';
import './homepage.dart';
import '../Wigets/RaisedButton.dart';
import '../Wigets/MyTextFromField.dart';

class ContactNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
            return;
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Contact",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: 380,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MyTextFromField(
                    hintText: 'FullName',
                    keybord: TextInputType.emailAddress,
                    myObscureText: false,

                  ),
                  MyTextFromField(
                    hintText: 'Email',
                    keybord: TextInputType.emailAddress,
                   myObscureText: false, 
                  ),
                  MyTextFromField(
                    hintText: 'phone',
                    keybord: TextInputType.number,
                   myObscureText: false,
                  ),
                  MyTextFromField(
                    hintText: 'Your massages',
                    keybord: TextInputType.emailAddress,
                    myObscureText: false,
                  ),
                  MyTextFromField(
                    hintText: 'Password',
                    keybord: TextInputType.visiblePassword,
                   myObscureText: true,
                  ),
                ],
              ),
            ),
            Container(
              height: 60,
              width: double.infinity,
              child: MyRaisedutton(
                buttonText: 'Send',textColor: Colors.white,
                myColor: Theme.of(context).primaryColor,
                whenPress: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

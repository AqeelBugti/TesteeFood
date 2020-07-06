import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tastee/MyProvider/Myprovider.dart';
import 'package:tastee/Screen/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './Screen/logIn.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xffff3ea5),
      statusBarBrightness: Brightness.dark,
    ));
    return ChangeNotifierProvider(
      create: (context) => MyProvider(),
      child: MaterialApp(
        theme: ThemeData(
          accentColor: Color(0xff04d4ee), //////////// Python color
          primaryColor: Color(0xffff3ea5), /////// Pink Wala Color
        ),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
            stream: FirebaseAuth.instance.onAuthStateChanged,
            builder: (ctx, userSnapshot) {
              if (userSnapshot.hasData) {
                return HomePage();
              }
              return LogIn();
            }),
      ),
    );
  }
}

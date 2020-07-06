import 'package:flutter/material.dart';
import './homepage.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          "About",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: () {
              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                              return;
          },
        ),
      ),
      body: Container(
        child: Wrap(
          children: <Widget>[
            Text(
              "My Self Aqeel Bugti  asdaskljdhakjsa jkahsdkjashdkasjd hsakasjdhakjsd jashdkjasd asd askdashdkas dk jkashd kasjdas kjdask kalsd jalksd aslkdsajldkdask lkjasdhkjsad askjashd kjasdh sajalksdjlsdjlksadjsa askjdh dakjsdhf ksjdfh skajdfh skjf skjfhs kjfhsdjk fsdjkf sdkjf sdkjfhdskfdsjhf ksdjfhsmskdjfh asdklfh sdkjfhsdakjf asdkf dsf hskjdaf hsadkjf hsdkj fhsdkjf hskdjf jsdhfa kjsf lkasfjhskdjfh sdkjf skjlfhsdk fskjdhf ksjdhfks jdh",
              style: TextStyle(fontSize: 29),
            ),
          ],
        ),
      ),
    );
  }
}

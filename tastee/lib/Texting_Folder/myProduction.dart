import 'package:flutter/material.dart';
class Test extends StatefulWidget {
  @override
  _TestState createState() =>  _TestState();
}

class _TestState extends State<Test> {
  double rating = 3.5;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  ListView(
        children: ListTile
            .divideTiles(
              context: context,
              tiles:  List.generate(42, (index) {
                return SlideMenu(
                  child: ListTile(
                    title:  Container(child:  Text("Drag me")),
                  ),
                  menuItems: <Widget>[
                     Container(
                      child:  IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: null,
                      ),
                    ),
                    //  Container(  /////////////////// Info IconButton 
                    //   child:  IconButton(
                    //     icon:  Icon(Icons.info),
                    //     onPressed: null,
                    //   ),
                    // ),
                  ],
                );
              }),
            )
            .toList(),
      ),
    );
  }
}

class SlideMenu extends StatefulWidget {
  final Widget child;
  final List<Widget> menuItems;

  SlideMenu({this.child, this.menuItems});

  @override
  _SlideMenuState createState() =>  _SlideMenuState();
}

class _SlideMenuState extends State<SlideMenu> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  initState() {
    super.initState();
    _controller =  AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animation =  Tween(
      begin: const Offset(0.0, 0.0),
      end: const Offset(-0.2, 0.0)
    ).animate( CurveTween(curve: Curves.decelerate).animate(_controller));

    return  GestureDetector(
      onHorizontalDragUpdate: (data) {
        // we can access context.size here
        setState(() {
          _controller.value -= data.primaryDelta / context.size.width;
        });
      },
      onHorizontalDragEnd: (data) {
        if (data.primaryVelocity > 2500)
          _controller.animateTo(.0); //close menu on fast swipe in the right direction
        else if (_controller.value >= .5 || data.primaryVelocity < -2500) // fully open if dragged a lot to left or on fast swipe to left
          _controller.animateTo(1.0);
        else // close if none of above
          _controller.animateTo(.0);
      },
      child:  Stack(
        children: <Widget>[
           SlideTransition(position: animation, child: widget.child),
           Positioned.fill(
            child:  LayoutBuilder(
              builder: (context, constraint) {
                return  AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return  Stack(
                      children: <Widget>[
                         Positioned(
                          right: .0,
                          top: .0,
                          bottom: .0,
                          width: constraint.maxWidth * animation.value.dx * -1,
                          child:  Container(
                            color: Colors.black26,
                            child:  Row(
                              children: widget.menuItems.map((child) {
                                return  Expanded(
                                  child: child,
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
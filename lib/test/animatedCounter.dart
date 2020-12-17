import 'package:flutter/material.dart';

class AnimationCounterPage extends StatefulWidget {
  @override
  _AninationCounterPageState createState() => _AninationCounterPageState();
}

class _AninationCounterPageState extends State<AnimationCounterPage> {
  bool _big = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: TweenAnimationBuilder(
        duration: Duration(seconds: 2),
        //curve: Curves.bounceInOut,
        tween: Tween(begin: 7.0, end: 9.0), //begin only usefil at first....
        builder: (BuildContext context, value, Widget child) {
          final whole = value ~/ 1;
          final decimal = value - whole;
          return Center(
              child: Container(
                  width: 300,
                  height: 120,
                  child: Stack(children: [
                    Positioned(
                      top: -100 * decimal,
                      child: Opacity(
                          opacity: 1.0 - decimal,
                          child: Text(
                            "$whole",
                            style: TextStyle(fontSize: 100),
                          )),
                    ),
                    Positioned(
                      top: 100 - 100 * decimal,
                      child: Opacity(
                          opacity: 1.0 * decimal,
                          child: Text(
                            "${whole + 1}",
                            style: TextStyle(fontSize: 100),
                          )),
                    ),
                  ])));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            _big = !_big;
          });
        },
      ),
    );
  }
}

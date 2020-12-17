import 'package:flutter/material.dart';

class TweenAninationPage extends StatefulWidget {
  @override
  _TweenAninationPageState createState() => _TweenAninationPageState();
}

class _TweenAninationPageState extends State<TweenAninationPage> {
  bool _big = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: TweenAnimationBuilder(
        duration: Duration(seconds: 2),
        //curve: Curves.bounceInOut,
        tween: Tween(
            begin: 72.0,
            end: _big ? 172.0 : 72.0), //begin only usefil at first....
        builder: (BuildContext context, value, Widget child) {
          return Container(
              width: 300,
              height: 300,
              color: Colors.blue,
              child: Center(
                  child: Transform.rotate(
                //translate..平移
                angle: 0,
                child: Text(
                  "hi",
                  style: TextStyle(fontSize: value),
                ),
              )));
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

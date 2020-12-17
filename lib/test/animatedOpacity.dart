import 'package:flutter/material.dart';

class AnimatedOpcityPage extends StatefulWidget {
  @override
  _AnimatedOpcityPageState createState() => _AnimatedOpcityPageState();
}

class _AnimatedOpcityPageState extends State<AnimatedOpcityPage> {
  double _top = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AnimatedPadding(
        duration: Duration(seconds: 2),
        padding: EdgeInsets.all(_top),
        curve: Curves.bounceInOut,
        child: Container(
          width: 300,
          height: 300,
          color: Colors.blue,
        ),
      ),

      //  Center(
      //     child: Container(
      //   child: AnimatedOpacity(
      //     curve: Curves.bounceInOut,
      //     opacity: 0.5,
      //     duration: Duration(seconds: 2),
      //     child: Container(
      //       width: 300,
      //       height: 300,
      //       color: Colors.blue,
      //     ),
      //   ),
      // ))
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            if (_top == 40.0)
              _top = 0.0;
            else if (_top == 0.0) _top = 40.0;
          });
        },
      ),
    );
  }
}

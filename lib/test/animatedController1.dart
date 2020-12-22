import 'package:flutter/material.dart';

class AnimationController1Page extends StatefulWidget {
  @override
  _AnimationController1PageState createState() =>
      _AnimationController1PageState();
}

class _AnimationController1PageState extends State<AnimationController1Page>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  var _loading = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
      lowerBound: 0.0,
      upperBound: 1.0,
      //animationBehavior: AnimationBehavior.preserve,
    );

    _controller.repeat(reverse: true);
    _controller.addListener(() {
      //print(_controller.value);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          //   child: RotationTransition(
          // turns: _controller,
          // child: Container(
          //   width: 300,
          //   height: 300,
          //   color: Colors.blue,
          // ),
          //   child: ScaleTransition(
          // scale: _controller,
          // child: Container(
          //   width: 300,
          //   height: 300,
          //   color: Colors.blue,
          // ),
          child: FadeTransition(
        opacity: _controller,
        child: Container(
          width: 300,
          height: 300,
          color: Colors.blue,
        ),
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          if (_loading) {
            _controller.stop();
          } else {
            _controller.repeat(reverse: true);
          }
          _loading = !_loading;
        },
      ),
    );
  }
}

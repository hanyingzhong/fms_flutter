import 'package:flutter/material.dart';

class AnimatedBuilderPage extends StatefulWidget {
  @override
  _AnimatedBuilderPageState createState() => _AnimatedBuilderPageState();
}

class _AnimatedBuilderPageState extends State<AnimatedBuilderPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 2000), vsync: this)
          ..repeat(reverse: true);
    //_controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Animation opacityAnimation =
        Tween(begin: 0.2, end: 0.9).animate(_controller);

    final Animation heightAnimation = Tween(begin: 100.0, end: 200.0)
        .chain(CurveTween(curve: Curves.bounceInOut))
        .chain(CurveTween(curve: Interval(0.2, 0.8)))
        .animate(_controller);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget child) {
            return Opacity(
              opacity: opacityAnimation
                  .value, //Tween(begin: 0.2, end: 0.9).evaluate(_controller),
              child: Container(
                width: 300,
                height: heightAnimation
                    .value, //Tween(begin: 100.0, end: 200.0).evaluate(_controller),
                color: Colors.blue,
                child: child,
              ),
            );
          },
          child: //child不会重新绘制
              Center(
                  child: Container(
            child: Text(
              "Hi",
              style: TextStyle(fontSize: 70),
            ),
          )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

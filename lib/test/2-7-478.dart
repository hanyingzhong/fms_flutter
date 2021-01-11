import 'package:flutter/material.dart';

class Test27478 extends StatefulWidget {
  @override
  _Test27478State createState() => _Test27478State();
}

class _Test27478State extends State<Test27478>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(duration: Duration(seconds: 4), vsync: this);
    super.initState();
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
          child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget child) {
          return Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
                gradient: RadialGradient(
                    stops: [_controller.value, _controller.value + 0.1],
                    colors: [Colors.blue[600], Colors.blue[100]])),
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _controller.repeat(reverse: true);
        },
      ),
    );
  }
}

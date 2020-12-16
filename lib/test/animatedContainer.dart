import 'package:flutter/material.dart';

class AnimatedContanerPage extends StatefulWidget {
  @override
  _AnimatedContanerPageState createState() => _AnimatedContanerPageState();
}

class _AnimatedContanerPageState extends State<AnimatedContanerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: AnimatedContainer(
                duration: Duration(microseconds: 5000),
                width: 300,
                height: 500,
                child: Center(
                  child: Center(
                    child: Text(
                      "welcome",
                      style: TextStyle(fontSize: 70),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.orange, Colors.white],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [0.2, 0.8]),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 50, //边框
                        blurRadius: 50) //模糊效果
                  ],
                  borderRadius: BorderRadius.circular(25),
                ))));
  }
}

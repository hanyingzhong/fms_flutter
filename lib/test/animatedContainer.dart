import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';

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
                child: AnimatedSwitcher(
                  //AnimatedCrossFade
                  transitionBuilder: (child, animation) {
                    //return FadeTransition(opacity: animation, child: child);
                    //return RotationTransition(turns: animation, child: child);
                    return FadeTransition(
                        opacity: animation,
                        child: ScaleTransition(scale: animation, child: child));
                  },
                  duration: Duration(seconds: 2),
                  child: Text(
                    "aaadd",
                    key: UniqueKey(),
                    style: TextStyle(fontSize: 70),
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

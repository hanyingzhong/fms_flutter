import 'package:flutter/material.dart';

class AnimationCounterPage extends StatefulWidget {
  @override
  _AninationCounterPageState createState() => _AninationCounterPageState();
}

class _AninationCounterPageState extends State<AnimationCounterPage> {
  var _counter = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Container(
              width: 400,
              height: 120,
              child: Row(children: <Widget>[
                AnimationCounter(
                  duration: Duration(milliseconds: 500),
                  value: _counter ~/ 100,
                ),
                AnimationCounter(
                  duration: Duration(milliseconds: 500),
                  value: _counter ~/ 10,
                ),
                AnimationCounter(
                    duration: Duration(milliseconds: 500),
                    value: _counter.toInt()),
                // CounterAnimation(
                //     begin: 0,
                //     end: 100,
                //     duration: 5,
                //     curve: Curves.easeOut,
                //     textStyle: TextStyle(fontSize: 70)),
              ]))),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            _counter++;
          });
        },
      ),
    );
  }
}

class AnimationCounter extends StatelessWidget {
  final Duration duration;
  final int value;

  AnimationCounter({@required this.duration, @required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: TweenAnimationBuilder(
      duration: duration,
      //curve: Curves.bounceInOut,
      tween: Tween(
          begin: 0.0,
          end: this.value.toDouble()), //begin only usefil at first....
      builder: (BuildContext context, value, Widget child) {
        final whole = value ~/ 1;
        final decimal = value - whole;
        return Stack(children: [
          Positioned(
            top: -100 * decimal,
            child: Opacity(
                opacity: 1.0 - decimal,
                child: Text(
                  "${whole % 10}",
                  style: TextStyle(fontSize: 100),
                )),
          ),
          Positioned(
            top: 100 - 100 * decimal,
            child: Opacity(
                opacity: 1.0 * decimal,
                child: Text(
                  "${(whole + 1) % 10}",
                  style: TextStyle(fontSize: 100),
                )),
          ),
        ]);
      },
    ));
  }
}

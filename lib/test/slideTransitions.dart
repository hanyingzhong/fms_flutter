import 'package:flutter/material.dart';

class SlidesTransitionsPage extends StatefulWidget {
  @override
  _SlidesTransitionsPageState createState() => _SlidesTransitionsPageState();
}

class _SlidesTransitionsPageState extends State<SlidesTransitionsPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SliderTransitionBox(
                  _controller, Colors.blue[100], Interval(0.0, 0.2)),
              SliderTransitionBox(
                  _controller, Colors.blue[300], Interval(0.2, 0.4)),
              SliderTransitionBox(
                  _controller, Colors.blue[500], Interval(0.4, 0.6)),
              SliderTransitionBox(
                  _controller, Colors.blue[700], Interval(0.6, 0.8)),
              SliderTransitionBox(
                  _controller, Colors.blue[900], Interval(0.8, 1.0)),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

class SliderTransitionBox extends StatelessWidget {
  final AnimationController controller;
  final Interval interval;
  final Color color;

  SliderTransitionBox(this.controller, this.color, this.interval);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SlideTransition(
        position: Tween(begin: Offset.zero, end: Offset(0.15, 0))
            .chain(CurveTween(curve: interval))
            .animate(controller),
        child: Container(
          width: 300,
          height: 100,
          color: color,
        ),
      ),
    );
  }
}

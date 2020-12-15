import 'package:flutter/material.dart';

class GlobalKeyTestPage extends StatefulWidget {
  @override
  _GlobalKeyTestPageState createState() => _GlobalKeyTestPageState();
}

class _GlobalKeyTestPageState extends State<GlobalKeyTestPage> {
  final k1 = GlobalKey();
  final k2 = GlobalKey();
  final k3 = GlobalKey();

  void _increaseCount() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("dd"),
      ),
      body: Center(
        child: Flex(
          direction: MediaQuery.of(context).orientation == Orientation.landscape
              ? Axis.horizontal
              : Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Counter(48, k1),
            Counter(48, k2),
            Counter(72, k3),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _increaseCount();
          [k1, k2, k3].forEach((key) {
            final state = key.currentState as _CounterState;
            final widget = key.currentWidget as Counter;
            final box = key.currentContext.findRenderObject() as RenderBox;
            state._counter++;
            widget.fontSize = 60;
            print(box.size);
            print(box.localToGlobal(Offset.zero)); //位置信息
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Counter extends StatefulWidget {
  double fontSize;
  Counter(this.fontSize, [Key key]) : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        onPressed: () {
          setState(() {
            _counter++;
          });
        },
        child: Text('$_counter', style: TextStyle(fontSize: widget.fontSize)));
  }
}

// import 'package:flutter/material.dart';

// class ColorSortPage extends StatefulWidget {
//   @override
//   _ReorderableListViewDemoState createState() =>
//       _ReorderableListViewDemoState();
// }

// class _ReorderableListViewDemoState extends State<ColorSortPage> {
//   final boxes = [
//     Box(Colors.blue[100], UniqueKey()),
//     Box(Colors.blue[300], UniqueKey()),
//     Box(Colors.blue[500], UniqueKey()),
//     Box(Colors.blue[700], UniqueKey()),
//     Box(Colors.blue[900], UniqueKey()),
//   ];

//   _shuffle() {
//     print("===========");
//     setState(() => boxes.shuffle());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('移动容器，重新排列')),
//       body: Center(
//           child: ReorderableListView(
//         scrollDirection: Axis.horizontal,
//         children: boxes,
//         onReorder: _onReorder, //onRecorder函数定义在下面，
//       )),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _shuffle,
//         tooltip: 'shuffle',
//         child: Icon(Icons.add),
//       ),
//     );
//   }

//   /*
//    * oldIndex代表移动前item的序号
//    * newIndex代表移动后item的序号
//    * 由于在向后移动的时候，newIndex会因为之前的占位
//    * 而多出一个，所以需要处理一下
//    */
//   _onReorder(int oldIndex, int newIndex) {
//     print("from $oldIndex to $newIndex");
//     if (newIndex > oldIndex) newIndex--;
//     final box = boxes.removeAt(oldIndex);
//     boxes.insert(newIndex, box);
//   }
// }

// class Box extends StatelessWidget {
//   final Color color;
//   Box(this.color, Key key) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(8.0),
//       width: 50,
//       height: 50,
//       color: color,
//     );
//   }
// }

import 'package:flutter/material.dart';

class ColorSortPage extends StatefulWidget {
  @override
  _ReorderableListViewDemoState createState() =>
      _ReorderableListViewDemoState();
}

class _ReorderableListViewDemoState extends State<ColorSortPage> {
  final _colors = [
    Colors.blue[100],
    Colors.blue[300],
    Colors.blue[500],
    Colors.blue[700],
    Colors.blue[900],
  ];

  int _slot;

  _shuffle() {
    setState(() => _colors.shuffle());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('移动容器，重新排列')),
      body: Listener(
          onPointerMove: (event) {
            print(event);
            final x = event.position.dx;
            print("$_slot " + x.toString());
            if (x > (_slot + 1) * Box.width) {
              if (_slot == _colors.length - 1) return;
              setState(() {
                final c = _colors[_slot];
                _colors[_slot] = _colors[_slot + 1];
                _colors[_slot + 1] = c;
                _slot++;
              });
            } else if (x < _slot * Box.width) {
              setState(() {
                final c = _colors[_slot];
                _colors[_slot] = _colors[_slot - 1];
                _colors[_slot - 1] = c;
                _slot--;
              });
            }
          },
          child: Stack(
              children: List.generate(_colors.length, (index) {
            return Box(_colors[index], index * Box.width, 200, (Color color) {
              final i = _colors.indexOf(color);
              print(i);
              _slot = i;
              //ValueKey is important...must be const..
            }, ValueKey(_colors[index]));
          }))),
      floatingActionButton: FloatingActionButton(
        onPressed: _shuffle,
        child: Icon(Icons.add),
      ),
    );
  }
}

class Box extends StatelessWidget {
  static const width = 50.0;
  static const height = 150.0;
  static const margin = 2.0;

  final Color color;
  final double x, y;
  final Function(Color color) onDrag;

  Box(this.color, this.x, this.y, this.onDrag, Key key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final container = Container(
      margin: EdgeInsets.all(8.0),
      width: width - margin * 2,
      height: height - margin * 2,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(8.0)),
    );

    return AnimatedPositioned(
        duration: Duration(milliseconds: 500),
        left: x,
        top: y,
        child: Draggable(
          onDragStarted: () {
            onDrag(color);
          },
          child: container,
          feedback: container,
          childWhenDragging: Visibility(visible: false, child: container),
        ));
  }
}

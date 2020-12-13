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
  final boxes = [
    Box(Colors.blue[100], 50, 200, UniqueKey()),
    Box(Colors.blue[300], 100, 200, UniqueKey()),
    Box(Colors.blue[500], 150, 200, UniqueKey()),
    Box(Colors.blue[700], 200, 200, UniqueKey()),
    Box(Colors.blue[900], 250, 200, UniqueKey()),
  ];

  _shuffle() {
    print("===========");
    setState(() => boxes.shuffle());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('移动容器，重新排列')),
      body: Center(
          child: Stack(
        children: boxes,
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _shuffle,
        child: Icon(Icons.add),
      ),
    );
  }
}

class Box extends StatelessWidget {
  final Color color;
  final double x, y;
  Box(this.color, this.x, this.y, Key key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
        duration: Duration(seconds: 1),
        left: x,
        top: y,
        child: Draggable(
          child: Container(
            margin: EdgeInsets.all(8.0),
            width: 50,
            height: 50,
            color: color,
          ),
          feedback: Container(
            margin: EdgeInsets.all(8.0),
            width: 50,
            height: 50,
            color: color,
          ),
          childWhenDragging: Container(
            margin: EdgeInsets.all(8.0),
            width: 50,
            height: 50,
          ),
        ));
  }
}

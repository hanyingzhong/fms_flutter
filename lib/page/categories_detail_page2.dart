// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// class CategoryDetailPage extends StatefulWidget {
//   @override
//   _CategoryDetailPageState createState() => _CategoryDetailPageState();
// }

// class _CategoryDetailPageState extends State<CategoryDetailPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(),
//         body: StaggeredGridView.countBuilder(
//           crossAxisCount: 4,
//           itemCount: 9,
//           itemBuilder: (BuildContext context, int index) =>  Container(
//               color: Colors.green,
//               child: Center(
//                 child: CircleAvatar(
//                   backgroundColor: Colors.white,
//                   child: Text('$index'),
//                 ),
//               )),
//           staggeredTileBuilder: (int index) =>
//               StaggeredTile.count(2, index.isEven ? 2 : 1),
//           mainAxisSpacing: 4.0,
//           crossAxisSpacing: 4.0,
//         ));
//   }
// }

///////////////////////////////////////////////////////////////////////////////

// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
//   const StaggeredTile.count(2, 2),
//   const StaggeredTile.count(2, 1),
//   const StaggeredTile.count(1, 2),
//   const StaggeredTile.count(1, 1),
//   const StaggeredTile.count(2, 2),
//   const StaggeredTile.count(1, 2),
//   const StaggeredTile.count(1, 1),
//   const StaggeredTile.count(3, 1),
//   const StaggeredTile.count(1, 1),
//   const StaggeredTile.count(2, 1),
// ];

// List<Widget> _tiles = const <Widget>[
//   const _Example01Tile(Colors.green, Icons.widgets),
//   const _Example01Tile(Colors.lightBlue, Icons.wifi),
//   const _Example01Tile(Colors.amber, Icons.panorama_wide_angle),
//   const _Example01Tile(Colors.brown, Icons.map),
//   const _Example01Tile(Colors.deepOrange, Icons.send),
//   const _Example01Tile(Colors.indigo, Icons.airline_seat_flat),
//   const _Example01Tile(Colors.red, Icons.bluetooth),
//   const _Example01Tile(Colors.pink, Icons.battery_alert),
//   const _Example01Tile(Colors.purple, Icons.desktop_windows),
//   const _Example01Tile(Colors.blue, Icons.radio),
// ];

// class CategoryDetailPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('example 01'),
//         ),
//         body: Padding(
//             padding: const EdgeInsets.only(top: 12.0),
//             child: StaggeredGridView.count(
//               crossAxisCount: 4,
//               staggeredTiles: _staggeredTiles,
//               children: _tiles,
//               mainAxisSpacing: 4.0,
//               crossAxisSpacing: 4.0,
//               padding: const EdgeInsets.all(4.0),
//             )));
//   }
// }

// class _Example01Tile extends StatelessWidget {
//   const _Example01Tile(this.backgroundColor, this.iconData);

//   final Color backgroundColor;
//   final IconData iconData;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: backgroundColor,
//       child: InkWell(
//         onTap: () {},
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(4.0),
//             child: Icon(
//               iconData,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

final Uint8List kTransparentImage = new Uint8List.fromList(<int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
]);

List<IntSize> _createSizes(int count) {
  Random rnd = new Random();
  return new List.generate(count,
      (i) => new IntSize((rnd.nextInt(500) + 200), rnd.nextInt(800) + 200));
}

class CategoryDetailPage extends StatelessWidget {
  CategoryDetailPage() : _sizes = _createSizes(_kItemCount).toList();

  static const int _kItemCount = 1000;
  final List<IntSize> _sizes;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('random dynamic tile sizes'),
      ),
      body: new StaggeredGridView.countBuilder(
        primary: false,
        crossAxisCount: 4,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        itemBuilder: (context, index) => new _Tile(index, _sizes[index]),
        staggeredTileBuilder: (index) => new StaggeredTile.fit(2),
      ),
    );
  }
}

class IntSize {
  const IntSize(this.width, this.height);

  final int width;
  final int height;
}

class _Tile extends StatelessWidget {
  const _Tile(this.index, this.size);

  final IntSize size;
  final int index;

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Column(
        children: <Widget>[
          new Stack(
            children: <Widget>[
              //new Center(child: new CircularProgressIndicator()),
              new Center(
                child: new FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: 'https://picsum.photos/${size.width}/${size.height}/',
                ),
              ),
            ],
          ),
          new Padding(
            padding: const EdgeInsets.all(4.0),
            child: new Column(
              children: <Widget>[
                new Text(
                  'Image number $index',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                new Text(
                  'Width: ${size.width}',
                  style: const TextStyle(color: Colors.grey),
                ),
                new Text(
                  'Height: ${size.height}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

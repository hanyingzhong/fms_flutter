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
  Random rnd = Random();
  return List.generate(
      count, (i) => IntSize((rnd.nextInt(500) + 200), rnd.nextInt(800) + 200));
}

class CategoryDetailPage extends StatelessWidget {
  CategoryDetailPage() : _sizes = _createSizes(_kItemCount).toList();

  static const int _kItemCount = 1000;
  final List<IntSize> _sizes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('random dynamic tile sizes'),
      ),
      body: StaggeredGridView.countBuilder(
        primary: false,
        crossAxisCount: 4,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        itemCount: _kItemCount,
        itemBuilder: (context, index) => _Tile(index, _sizes[index]),
        staggeredTileBuilder: (index) => StaggeredTile.fit(2),
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
    return Card(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              //new Center(child: new CircularProgressIndicator()),
              Center(
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: 'https://picsum.photos/${size.width}/${size.height}/',
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Image number $index',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Width: ${size.width}',
                  style: const TextStyle(color: Colors.grey),
                ),
                Text(
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

//////////////////////////////////////////////////////////////////////////

class CategoryDetailPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cat Demo')),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Wrap(
          children: [for (CatImage image in images) ImageCaption(image)],
        ),
      ),
    );
  }
}

class ImageCaption extends StatelessWidget {
  const ImageCaption(this.image);

  final CatImage image;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageWidgetPlaceholder(
            image: NetworkImage(image.url),
            placeholder: SizedBox(
              width: image.width.toDouble(),
              height: image.height.toDouble(),
            ),
          ),
          Text(image.caption),
        ],
      ),
    );
  }
}

class ImageWidgetPlaceholder extends StatelessWidget {
  const ImageWidgetPlaceholder({Key key, this.image, this.placeholder})
      : super(key: key);

  final ImageProvider image;
  final Widget placeholder;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: image,
      frameBuilder: (BuildContext context, Widget child, int frame,
          bool wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        } else {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: frame != null ? child : placeholder,
          );
        }
      },
    );
  }
}

class CatImage {
  const CatImage({this.width, this.height, this.caption});
  final int width;
  final int height;
  final String caption;

  get url => 'https://placekitten.com/$width/$height';
}

const List<CatImage> images = [
  CatImage(width: 150, height: 150, caption: 'Watch out'),
  CatImage(width: 150, height: 160, caption: 'Hmm'),
  CatImage(width: 160, height: 150, caption: 'Whats up'),
  CatImage(width: 140, height: 150, caption: 'Miaoo'),
  CatImage(width: 130, height: 150, caption: 'Hey'),
  CatImage(width: 155, height: 150, caption: 'Hello'),
];

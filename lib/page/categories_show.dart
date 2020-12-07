import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fms_flutter/repository/repo_categories.dart';
import 'package:get/get.dart';
import 'package:network_to_file_image/network_to_file_image.dart';

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

class CategoryDetailShowPage extends StatelessWidget {
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
        itemCount: Get.find<List<RepositoryCategory>>().length,
        itemBuilder: (context, index) => _Tile(index),
        staggeredTileBuilder: (index) => StaggeredTile.fit(2),
        //staggeredTileBuilder: (index) => StaggeredTile.count(2, 3),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile(this.index);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              //new Center(child: new CircularProgressIndicator()),
              Container(
                height: index % 2 == 0 ? 250 : 300,
                // child: Image.network(
                //   Get.find<List<RepositoryCategory>>()[index]
                //       .local
                //       .thumb
                //       .location,
                //   fit: BoxFit.fill,
                // ),

                child: _buildTile(index),
                //     child: FadeInImage.memoryNetwork(
                //   placeholder: kTransparentImage,
                //   image: Get.find<List<RepositoryCategory>>()[index]
                //       .local
                //       .thumb
                //       .location,
                //   fit: BoxFit.cover,
                // )
                // child: FadeInImage.memoryNetwork(
                //   placeholder: kTransparentImage,
                //   image:
                //       'https://picsum.photos/${300 + index * 100}/${100 + index * 100}/',
                // ),
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
                  'Width: ',
                  style: const TextStyle(color: Colors.grey),
                ),
                Text(
                  'Height:',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTile(int index) {
    var element = Get.find<List<RepositoryCategory>>()[index];
    return Image(
      image: NetworkToFileImage(
        url: element.local.thumb.location,
        file: File(element.local.large.location),
        debug: false,
      ),
      fit: BoxFit.cover,
    );
    // return FadeInImage.memoryNetwork(
    //   placeholder: kTransparentImage,
    //   image: element.local.thumb.location,
    //   fit: BoxFit.fitWidth,
    // );
  }
}

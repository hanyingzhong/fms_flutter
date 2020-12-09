import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fms_flutter/page/category_swiper.dart';
import 'package:fms_flutter/repository/repo_categories.dart';
import 'package:fms_flutter/repository/repo_images.dart';
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
  final int categoryId;

  CategoryDetailShowPage(this.categoryId);

  @override
  Widget build(BuildContext context) {
    print(categoryId);
    List<RepositoryImagePair> images =
        Get.find<List<RepositoryImagePair>>(tag: categoryId.toString());
    int itemCount = images.length;
    return Scaffold(
      appBar: AppBar(
        title: Text('random dynamic tile sizes'),
      ),
      body: StaggeredGridView.countBuilder(
        primary: false,
        crossAxisCount: 4,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        itemCount: itemCount,
        itemBuilder: (context, index) =>
            _ImageTile(index, categoryId, images[index]),
        staggeredTileBuilder: (index) => StaggeredTile.fit(2),
        //staggeredTileBuilder: (index) => StaggeredTile.count(2, 3),
      ),
    );
  }
}

class _ImageTile extends StatelessWidget {
  const _ImageTile(this.index, this.categoryId, this.imagePair);

  final int categoryId;
  final int index;
  final RepositoryImagePair imagePair;

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

                child: _buildTile(imagePair),
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
          _buildDesc(imagePair),
        ],
      ),
    );
  }

  Widget _buildTile(RepositoryImagePair imagePair) {
    return InkWell(
        onTap: () {
          print("tapped.");
          Get.to(CategoryPhotoSwiperPage(categoryId));
        },
        child: Image(
          image: NetworkToFileImage(
            url: imagePair.network.large.location,
            file: File(imagePair.local.large.location),
            debug: true,
          ),
          fit: BoxFit.cover,
        ));
    // return FadeInImage.memoryNetwork(
    //   placeholder: kTransparentImage,
    //   image: element.local.thumb.location,
    //   fit: BoxFit.fitWidth,
    // );
  }

  Widget _buildDesc(RepositoryImagePair imagePair) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            child: Row(
              children: [
                Spacer(
                  flex: 1,
                ),
                Text(
                  "",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(
                  flex: 5,
                ),
                InkWell(
                  child: Icon(
                    Icons.comment,
                    size: 15,
                    //color: Colors.white,
                  ),
                  onTap: () {
                    print("edit tapped");
                  },
                ),
                Spacer(
                  flex: 1,
                ),
                InkWell(
                  child: Icon(
                    Icons.edit,
                    size: 15,
                    //color: Colors.white,
                  ),
                  onTap: () {
                    print("commnent tapped");
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

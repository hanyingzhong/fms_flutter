import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fms_flutter/provider/categories_images_model.dart';
import 'package:fms_flutter/repository/repo_categories.dart';
import 'package:fms_flutter/repository/repo_images.dart';
import 'package:fms_flutter/widget/loading_container.dart';
import 'package:fms_flutter/widget/provider_widget.dart';
import 'package:get/get.dart';
//import 'package:get/get.dart';
import 'package:network_to_file_image/network_to_file_image.dart';
//import 'package:network_to_file_image/network_to_file_image.dart';

class CategoryDeailPage extends StatefulWidget {
  final int categoryIndex;
  final RepositoryCategory category;

  CategoryDeailPage(this.categoryIndex, {this.category});
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryDeailPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<PhotoCategoryImagesPageModel>(
        model: PhotoCategoryImagesPageModel(widget.categoryIndex),
        onModelInit: (model) async {
          model.refresh();
        },
        builder: (context, model, child) {
          return LoadingContainer(
              loading: model.loading,
              error: model.error,
              retry: model.retry,
              child: Container(
                  child: Scaffold(
                      appBar: AppBar(),
                      body: Container(
                          child: CustomScrollView(
                        slivers: <Widget>[
                          SliverGrid.count(
                            crossAxisCount: 3,
                            children:
                                List.generate(model.images.length, (index) {
                              return _buildImage(context, model, child, index);
                            }).toList(),
                          ),
                          // SliverList(
                          //   delegate:
                          //       SliverChildBuilderDelegate((content, index) {
                          //     return Container(
                          //       height: 85,
                          //       alignment: Alignment.center,
                          //       color: Colors
                          //           .primaries[index % Colors.primaries.length],
                          //       child: Text(
                          //         '$index',
                          //         style: TextStyle(
                          //             color: Colors.white, fontSize: 20),
                          //       ),
                          //     );
                          //   }, childCount: 25),
                          // )
                        ],
                      )))));
        });
  }

  @override
  bool get wantKeepAlive => true;
}

Widget _buildImage(BuildContext context, PhotoCategoryImagesPageModel model,
    Widget child, int index) {
  return Container(
      width: 200,
      height: 20,
      color: Colors.white,
      padding: EdgeInsets.all(1.0),
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          _showPhoto(context, model.images[index]);
        },
        child: Image(
          image: NetworkToFileImage(
            url: model.images[index].network.thumb.location,
            file: File(model.images[index].local.thumb.location),
            debug: true,
          ),
          fit: BoxFit.fill,
        ),
      ));
}

_showPhoto(BuildContext context, RepositoryImagePair info) {
  Navigator.push(context,
      MaterialPageRoute<void>(builder: (BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('===', maxLines: 2),
          centerTitle: true,
        ),
        body: Center(
            child: Hero(
          tag: '===',
          child: InkWell(
            onTap: () => {Navigator.pop(context)},
            child: Image(
              image: NetworkToFileImage(
                url: info.network.large.location,
                file: File(info.local.large.location),
                debug: true,
              ),
              fit: BoxFit.fill,
            ),
          ),
        )));
  }));
}

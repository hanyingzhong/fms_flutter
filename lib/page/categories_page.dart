import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fms_flutter/page/category_detail_page.dart';
import 'package:fms_flutter/provider/categories_model.dart';
import 'package:fms_flutter/repository/repo_categories.dart';
import 'package:fms_flutter/util/navigator_manager.dart';
import 'package:fms_flutter/widget/loading_container.dart';
import 'package:fms_flutter/widget/provider_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:network_to_file_image/network_to_file_image.dart';

class PhotoCategoriesPage extends StatefulWidget {
  @override
  _PhotoCategoriesPageState createState() => _PhotoCategoriesPageState();
}

File fileFromDocsDir(model, String filename) {
  String pathName = p.join(model.appDocsDir.path, filename);
  return File(pathName);
}

class _PhotoCategoriesPageState extends State<PhotoCategoriesPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<PhotoCategoriesPageModel>(
        model: PhotoCategoriesPageModel(),
        onModelInit: (model) async {
          model.refresh();
          print('refreshed....');
        },
        builder: (context, model, child) {
          return LoadingContainer(
              loading: model.loading,
              error: model.error,
              retry: model.retry,
              child: Scaffold(
                appBar: AppBar(),
                body: SmartRefresher(
                    controller: model.refreshController,
                    onRefresh: model.refresh,
                    onLoading: model.loadMore,
                    enablePullUp: true,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: _buildCategoriesList(context, model),
                    )),
              ));
        });
  }

  @override
  bool get wantKeepAlive => true;
}

Widget _buildCategory(
    BuildContext context, int index, PhotoCategoriesPageModel model) {
  return GestureDetector(
      onTap: () =>
          {NavigatorManager.to(CategoryDeailPage(model.categories[index].id))},
      child: SafeArea(
          child: Container(
              width: 200.0,
              height: 160.0,
              child: Image(
                image: NetworkToFileImage(
                  // url:
                  //     "https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png",
                  url: model.categories[index].local.thumb.location,
                  file: File(model.categories[index].local.large.location),
                  debug: true,
                ),
              ))));
}

List<Widget> _buildCategoriesList(
    BuildContext context, PhotoCategoriesPageModel model) {
  List<Widget> list = [];

  model.categories.forEach((element) {
    list.add(GestureDetector(
        onTap: () => {NavigatorManager.to(CategoryDeailPage(element.id))},
        child: SafeArea(
            child: Container(
                margin: EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 1.0),
                width: 160.0,
                height: 220.0,
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 1.0, 1.0),
                child: Card(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                      Container(
                          // margin: EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 1.0),
                          // padding: EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 1.0),
                          height: 20.0,
                          child: Text(element.name)
                          // ListTile(
                          //   title: Center(
                          //       child: Text(element.name,
                          //           style: TextStyle(
                          //               fontWeight: FontWeight.w200,
                          //               fontSize: 12,
                          //               decoration: TextDecoration.none))),
                          // )
                          ),
                      Image(
                        image: NetworkToFileImage(
                          url: element.local.thumb.location,
                          file: File(element.local.large.location),
                          debug: false,
                        ),
                      ),
                    ]))))));
  });

  return list;
}

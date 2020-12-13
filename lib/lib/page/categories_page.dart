import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fms_flutter/config/color.dart';
import 'package:fms_flutter/page/categories_add.dart';
import 'package:fms_flutter/page/category_detail_page.dart';
import 'package:fms_flutter/provider/categories_model.dart';
import 'package:fms_flutter/provider/devicemgr_model.dart';
import 'package:fms_flutter/repository/repo_categories.dart';
import 'package:fms_flutter/util/navigator_manager.dart';
import 'package:fms_flutter/widget/loading_container.dart';
import 'package:fms_flutter/widget/provider_widget.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:path/path.dart' as p;
import 'package:network_to_file_image/network_to_file_image.dart';
import 'package:fms_flutter/popupmenu/w_popup_menu.dart';

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
  final List<String> actions = [
    '编辑',
    '删除',
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print(Get.find<FmsDevice>().connected);
    if (Get.find<FmsDevice>().connected == false) {
      return Scaffold(appBar: AppBar(), body: _buildBanner(context));
    } else {
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
                  appBar: AppBar(
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.search),
                        tooltip: "搜索",
                        onPressed: () {
                          print("搜索");
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        tooltip: "创建相册",
                        onPressed: () {
                          Get.to(CategoriesManagePage(
                              type: CategoriesManageType.Create));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.link),
                        tooltip: "...",
                        onPressed: () async {
                          await _popupMenu(context, model);
                        },
                      ),
                      //_nomalPopMenu()
                    ],
                  ),
                  body: SmartRefresher(
                      controller: model.refreshController,
                      onRefresh: model.refresh,
                      onLoading: model.loadMore,
                      enablePullUp: true,
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        children: _buildCategoriesList(context, model, actions),
                      )),
                ));
          });
    }
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> _popupMenu(
      BuildContext context, PhotoCategoriesPageModel model) async {
    var result = await showMenu(
        color: Colors.grey[800],
        context: context,
        position: RelativeRect.fromLTRB(600.0, 80.0, 0.0, 0.0),
//    position: RelativeRect.fromLTRB(1000.0, 1000.0, 0.0, 10.0),
        items: //_buildPopupMenu());
            <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
              value: 'createCategory',
              child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                  leading: Icon(
                    Icons.message,
                    color: Colors.white,
                  ),
                  title: Text(
                    '创建相册',
                    style: TextStyle(color: Colors.white),
                  ))),
          PopupMenuItem<String>(
              value: 'getList',
              child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                  leading: Icon(
                    Icons.group_add,
                    color: Colors.white,
                  ),
                  title: Text(
                    '获取列表',
                    style: TextStyle(color: Colors.white),
                  ))),
          PopupMenuDivider(height: 20.0),
          PopupMenuItem<String>(
              value: 'value03',
              child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                  leading: Icon(
                    Icons.cast_connected,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Item One',
                    style: TextStyle(color: Colors.white),
                  ))),
        ]);

    if (result != null && result == 'createCategory') {
      print('createCategory');
      //model.add(name: 'ddddd');
      Get.to(CategoriesManagePage(type: CategoriesManageType.Create));
    }
    if (result != null && result == 'getList') {
      print('createCategory');
      model.refresh();
    }
  }

  Widget _buildBanner(BuildContext context) {
    //final colorScheme = Theme.of(context).colorScheme;
    final banner = MaterialBanner(
      content: Text('您尚未登录或者没有添加设备...'),
      leading: CircleAvatar(
        child: Icon(Icons.access_alarm, color: Colors.white),
        backgroundColor: Colors.white,
      ),
      actions: [
        FlatButton(
          child: Text('登录'),
          onPressed: () {
            setState(() {});
          },
        ),
        FlatButton(
          child: Text('退出'),
          onPressed: () {
            setState(() {});
          },
        ),
      ],
      backgroundColor: Colors.white,
    );
    return banner;
  }
}

List<Widget> _buildCategoriesList(BuildContext context,
    PhotoCategoriesPageModel model, List<String> actions) {
  List<Widget> list = [];

  model.categories.forEach((element) {
    list.add(Container(
        child: SafeArea(
            child: WPopupMenu(
                pressType: PressType.longPress,
                onValueChanged: (value) {},
                actions: actions,
                child: Container(
                    width: MediaQuery.of(context).size.width / 2, //160.0,
                    height: 220.0,
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                    child: InkWell(
                        onTap: () => {
                              NavigatorManager.to(CategoryDeailPage(element.id))
                            },
                        child: Card(
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                              Container(
                                  padding: EdgeInsets.all(0.0),
                                  height: 20.0,
                                  child: Text(element.name)),
                              element.nbImages != 0
                                  ? Image(
                                      image: NetworkToFileImage(
                                        url: element.local.thumb.location,
                                        file:
                                            File(element.local.large.location),
                                        debug: false,
                                      ),
                                      fit: BoxFit.cover,
                                    )
                                  : Text('no image'),
                            ]))))))));
  });

  return list;
}

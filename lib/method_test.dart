import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fms_flutter/general_dialog.dart';
import 'package:fms_flutter/get/get_test.dart';
import 'package:fms_flutter/imagepick.dart';
import 'package:fms_flutter/page/categories_show.dart';
import 'package:fms_flutter/page/category_show_detail.dart';
import 'package:fms_flutter/plugin/staggered_gridview_test.dart';
import 'package:fms_flutter/provider/devicemgr_model.dart';
import 'package:fms_flutter/repository/repo_categories.dart';
import 'package:fms_flutter/test/2-7-478.dart';
import 'package:fms_flutter/test/animatedBuilder.dart';
import 'package:fms_flutter/test/animatedContainer.dart';
import 'package:fms_flutter/test/animatedController1.dart';
import 'package:fms_flutter/test/animatedCounter.dart';
import 'package:fms_flutter/test/animatedOpacity.dart';
import 'package:fms_flutter/test/chip.dart';
import 'package:fms_flutter/test/colorsort.dart';
import 'package:fms_flutter/test/draggridview.dart';
import 'package:fms_flutter/test/globalkey.dart';
import 'package:fms_flutter/test/slideTransitions.dart';
import 'package:fms_flutter/test/tweenanimation.dart';
import 'package:fms_flutter/util/app_manager.dart';
import 'package:fms_flutter/util/dio_util.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'api/piwigo_service.dart';
import 'model/categories_getlist.dart';
import 'package:network_to_file_image/network_to_file_image.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:fms_flutter/page/popup_route_page.dart';
import 'package:fms_flutter/page/categories_detail_page2.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('照片服务器'),
        ),
        body: Wrap(
          //Column(
          spacing: 10,
          children: [
            const RaisedButton(child: Text('搜索设备'), onPressed: _startScan),
            RaisedButton(child: const Text('相册'), onPressed: _piwigoGetlist),
            RaisedButton(
                child: const Text('piwigo'),
                onPressed: () => Get.to(MultiPickImagesPage())),
            RaisedButton(
                child: const Text('登录'),
                onPressed: () => AppManager.loginMgr.login()),
            RaisedButton(
                child: const Text('mdns'), onPressed: () => assetsToFiles()),
            RaisedButton(
                child: const Text('dialog'),
                onPressed: () => Get.to(GeneralDialogPage())),
            RaisedButton(
                child: const Text('qrview'),
                onPressed: () => Navigator.of(context).pushNamed('/qrview')),
            RaisedButton(
                child: const Text('dropdown'),
                onPressed: () => Get.to(TestDropdownButton())),
            RaisedButton(
                child: const Text('update'),
                onPressed: () => Get.to(UploadStatusShowPage())),
            RaisedButton(
                child: const Text('showList'),
                onPressed: () {
                  final user = Get.find<List>()[0];
                  print(user.value.name);
                }),
            RaisedButton(
                child: const Text('popup'),
                onPressed: () {
                  Get.to(PopupRoutePage());
                }),
            RaisedButton(
                child: const Text('staggerd'),
                onPressed: () {
                  Get.to(CategoryDetailPage());
                }),
            RaisedButton(
                child: const Text('staggerd2'),
                onPressed: () {
                  LoginMgr.getCategoryDetail(1);
                  Get.to(CategoryStaggeredExtentCountPage(1));
                }),
            RaisedButton(
                child: const Text('placeholder'),
                onPressed: () {
                  Get.to(CategoryDetailPage3());
                }),
            RaisedButton(
                child: const Text('SetCategoryInfo'),
                onPressed: () {
                  LoginMgr.setCategoryInfo(1, comment: "武功山确实不错，可惜太匆忙");
                }),
            RaisedButton(
                child: const Text('showCategoriesList'),
                onPressed: () {
                  Get.to(CategoriesDetailShowPage());
                }),
            RaisedButton(
                child: const Text('showCategoryDetail'),
                onPressed: () {
                  LoginMgr.getCategoryDetail(1);
                  Get.to(CategoryDetailShowPage(1));
                }),
            RaisedButton(
                child: const Text('deleteImage'),
                onPressed: () {
                  LoginMgr.deletedImage(43);
                  List<int> ids = [100, 101];
                  LoginMgr.deletedImages(ids);
                }),
            RaisedButton(
                child: const Text('ColorSort'),
                onPressed: () {
                  Get.to(ColorSortPage());
                }),
            RaisedButton(
                child: const Text('DraggbaleGridView'),
                onPressed: () {
                  Get.to(DragAbleGridViewDemo());
                }),
            RaisedButton(
                child: const Text('GlobalKey'),
                onPressed: () {
                  Get.to(GlobalKeyTestPage());
                }),
            RaisedButton(
                child: const Text('animatedContainer'),
                onPressed: () {
                  Get.to(AnimatedContanerPage());
                }),
            RaisedButton(
                child: const Text('Opacity&Padding'),
                onPressed: () {
                  Get.to(AnimatedOpcityPage());
                }),
            RaisedButton(
                child: const Text('tween animation'),
                onPressed: () {
                  Get.to(TweenAninationPage());
                }),
            RaisedButton(
                child: const Text('counter animation'),
                onPressed: () {
                  Get.to(AnimationCounterPage());
                }),
            RaisedButton(
                child: const Text('animationController rotation'),
                onPressed: () {
                  Get.to(AnimationController1Page());
                }),
            RaisedButton(
                child: const Text('slide transition'),
                onPressed: () {
                  Get.to(SlidesTransitionsPage());
                }), //GridView(),
            RaisedButton(
                child: const Text('animated builder'),
                onPressed: () {
                  Get.to(AnimatedBuilderPage());
                }), //
            RaisedButton(
                child: const Text('chip'),
                onPressed: () {
                  Get.to(FMChipVC());
                }), //
            RaisedButton(
                child: const Text('chip'),
                onPressed: () {
                  Get.to(Test27478());
                }), //
          ],
        ));
  }
}

void _startScan() {
  print('aaaaaaaaaaaaaaaaaaaaaaaa');
  //var deviceMgr = Get.find<FmsDeviceMgr>();
  //print('new...............' + deviceMgr.currentDevice.toString());
  searchDevices();
}

void searchDevices() async {
  // ignore: prefer_typing_uninitialized_variables
  String connect;
  try {
    final result = await InternetAddress.lookup('DESKTOP-TR4ANSP',
        type: InternetAddressType.IPv4);
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      connect = 'true';
      print(result[0].rawAddress);
    }
  } on SocketException catch (_) {
    connect = 'false';
  }
  print(connect);
}

void _piwigoGetlist() {
  PiwigoApiService.getData(
      'http://192.168.1.7', PiwigoApiService.pwg_categories_getList,
      success: (result) async {
    //print(result);
    CategoriesGetListResponse response =
        CategoriesGetListResponse.fromJson(result);
    print(response);
  }, fail: (e) {
    print(e);
  }, complete: () {
    print('completed!');
  });
}

Future<List<File>> assetsToFiles() async {
  List<Asset> assetArray = [];
  List<File> fileImageArray = [];

  try {
    assetArray = await MultiImagePicker.pickImages(
      maxImages: 300,
      enableCamera: true,
      selectedAssets: assetArray,
      cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
      materialOptions: MaterialOptions(
        actionBarColor: "",
        actionBarTitle: "ImagePicker",
        allViewTitle: "All Photos",
        useDetailsView: false,
        selectCircleStrokeColor: "#000000",
      ),
    );
  } on Exception catch (e) {
    print(e.toString());
  }

  assetArray.forEach((imageAsset) async {
    final filePath =
        await FlutterAbsolutePath.getAbsolutePath(imageAsset.identifier);

    File tempFile = File(filePath);
    if (tempFile.existsSync()) {
      fileImageArray.add(tempFile);
      print(tempFile.path);
    }
  });

  return fileImageArray;
}

class TestDropdownButton extends StatefulWidget {
  @override
  _TestDropdownButtonState createState() => _TestDropdownButtonState();
}

class _TestDropdownButtonState extends State<TestDropdownButton> {
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DropdownButton<String>(
          value: dropdownValue,
          onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;
            });
          },
          items: <String>['One', 'Two', 'Free', 'Four']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}

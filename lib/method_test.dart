import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fms_flutter/general_dialog.dart';
import 'package:fms_flutter/imagepick.dart';
import 'package:fms_flutter/provider/devicemgr_model.dart';
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
            //GridView(),
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

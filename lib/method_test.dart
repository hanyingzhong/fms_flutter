import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fms_flutter/util/app_manager.dart';
import 'package:fms_flutter/util/dio_util.dart';
import 'api/piwigo_service.dart';
import 'model/categories_getlist.dart';
import 'package:network_to_file_image/network_to_file_image.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

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
                onPressed: () => Navigator.of(context).pushNamed('/dialog')),
            RaisedButton(
                child: const Text('登录'),
                onPressed: () => AppManager.loginMgr.login()),
            RaisedButton(
                child: const Text('mdns'),
                onPressed: () => Navigator.of(context).pushNamed('/mdns')),
            RaisedButton(
                child: const Text('card'),
                onPressed: () => Navigator.of(context).pushNamed('/card')),
            RaisedButton(
                child: const Text('qrview'),
                onPressed: () => Navigator.of(context).pushNamed('/qrview')),
            //GridView(),
          ],
        ));
  }
}

void _startScan() {
  print('aaaaaaaaaaaaaaaaaaaaaaaa');
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
      'http://192.168.1.3', PiwigoApiService.pwg_categories_getList,
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

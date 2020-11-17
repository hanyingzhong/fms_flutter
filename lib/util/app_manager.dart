import 'dart:convert';
import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:fms_flutter/provider/devicemgr_model.dart';
import 'package:fms_flutter/util/dio_util.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppManager {
  AppManager._();

  static Utf8Decoder utf8decoder = Utf8Decoder();
  static SharedPreferences prefs;
  static Directory appDocsDir;
  static Dio dio;
  static String serverHost = '192.168.1.7';
  static LoginMgr loginMgr;

  static String getServer() {
    return Get.find<FmsDeviceMgr>().currentDevice.host;
  }

  static Directory getAppDir() {
    if (appDocsDir == null) {
      getApplcationDirectory();
    }
    return appDocsDir;
  }

  //App初始化工作
  static init() async {
    prefs = await SharedPreferences.getInstance();
    await getApplcationDirectory();
    print('++++' + appDocsDir.toString());
    initDio();
    prefs.setString('CurrDeivceName', 'DESKTOP-TR4ANSP');
    Get.put<FmsDeviceMgr>(FmsDeviceMgr(), permanent: true);
    var devMgr = Get.find<FmsDeviceMgr>();
    // devMgr.setCurrentDevice(
    //     currentDevice:
    //         FmsDevice(name: prefs.get('CurrDeivceName'), host: '192.168.1.7'));
    await devMgr.searchCurrentDevice(prefs.get('CurrDeivceName'));

    loginMgr = LoginMgr(Get.find<FmsDeviceMgr>().currentDevice.host,
        username: 'root', password: 'root');
    loginMgr.login();
  }

  static initDio() {
    dio = Dio();
    var cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
  }

  static getApplcationDirectory() async {
    if (appDocsDir == null) {
      appDocsDir = await getApplicationDocumentsDirectory();
    }
  }
}

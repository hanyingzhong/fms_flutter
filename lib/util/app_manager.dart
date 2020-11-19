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
    return Get.find<FmsDevice>().host;
  }

  static Directory getAppDir() {
    if (appDocsDir == null) {
      getApplcationDirectory();
    }
    return appDocsDir;
  }

  static getCurrDeviceInfo() {
    var currDeviceInfo = prefs.getString('CurrDeivceInfo');
    print('stored CurrDeivceInfo : ' + currDeviceInfo);
    if (currDeviceInfo != null) {
      var fmsDevice = FmsDevice()..fromJson(jsonDecode(currDeviceInfo));
      Get.find<FmsDevice>().name = fmsDevice.name;
      Get.find<FmsDevice>().username = fmsDevice.username;
      Get.find<FmsDevice>().password = fmsDevice.password;

      Get.find<DeviceLoginInfo>().deviceName = fmsDevice.name;
      Get.find<DeviceLoginInfo>().loginUser = fmsDevice.username;
      Get.find<DeviceLoginInfo>().loginPassword = fmsDevice.password;

      print(Get.find<FmsDevice>().name);
    }
  }

  static void login2CurrDevice() async {
    var deviceName = Get.find<FmsDevice>().name;
    if (deviceName != '') {
      var devMgr = Get.find<FmsDeviceMgr>();
      await devMgr.searchCurrentDevice(Get.find<FmsDevice>().name);

      loginMgr = LoginMgr(Get.find<FmsDevice>().host,
          username: 'root', password: 'root');
      loginMgr.login();
    } else {
      print('no device used....');
    }
  }

  //App初始化工作
  static init() async {
    prefs = await SharedPreferences.getInstance();
    await getApplcationDirectory();
    print('appDocsDir : ' + appDocsDir.toString());
    initDio();
    Get.put<FmsDevice>(FmsDevice(), permanent: true);
    Get.put<FmsDeviceMgr>(FmsDeviceMgr(), permanent: true);
    Get.put<DeviceLoginInfo>(DeviceLoginInfo(), permanent: true);

    getCurrDeviceInfo();
    login2CurrDevice();
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

import 'dart:convert';

import 'package:fms_flutter/util/app_manager.dart';
import 'package:fms_flutter/util/http_constant.dart';
import 'package:http/http.dart' as http;

getCurrentDeviceIp() {
  return '192.168.1.3';
}

class PiwigoApiService {
  PiwigoApiService._();

  // ignore: non_constant_identifier_names
  static const pwg_post = '/piwigo/ws.php?format=json';
  static const pwg_method = '/piwigo/ws.php?format=json&method=';
  static const pwg_categories_getList = '${pwg_method}pwg.categories.getList';
  static const pwg_categories_getImages =
      '${pwg_method}pwg.categories.getImages&cat_id=';

  static const pwg_session_login = 'pwg.session.login';
  static const pwg_session_getStatus = '${pwg_method}pwg.session.getStatus';

  static const pwg_images_upload = 'pwg.images.upload';

  //网络请求封装，通过方法回调执行的结果(成功或失败)
  //网络请求封装方式一：采用回调函数处理请求结果，类似Android开发
  //url format: http://192.168.1.3
  static getData(String host, String method,
      {Function success, Function fail, Function complete}) async {
    try {
      var url = host + method;
      var response = await http
          .get(url, headers: HttpConstant.httpHeader)
          .timeout(Duration(milliseconds: 1500));
      if (response.statusCode == 200) {
        var result =
            json.decode(AppManager.utf8decoder.convert(response.bodyBytes));
        print(String.fromCharCodes(response.bodyBytes));
// List<int> list = 'hello'.codeUnits;
// Uint8List bytes = Uint8List.fromList(list);
// String string = String.fromCharCodes(bytes);
        success(result);
      } else {
        throw Exception('"Request failed with status: ${response.statusCode}"');
      }
    } catch (e) {
      fail(e);
    } finally {
      if (complete != null) {
        complete();
      }
    }
  }

  //网络请求封装方式二：返回Future，结合 then ==> catchError ==>whenComplete,类似JS
  static Future requestData(String url) async {
    try {
      var response = await http.get(url, headers: HttpConstant.httpHeader);
      if (response.statusCode == 200) {
        var result =
            json.decode(AppManager.utf8decoder.convert(response.bodyBytes));
        return result;
      } else {
        throw Exception('"Request failed with status: ${response.statusCode}"');
      }
    } catch (e) {
      Future.error(e);
    }
  }
}

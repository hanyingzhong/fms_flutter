import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fms_flutter/api/piwigo_service.dart';
import 'package:fms_flutter/model/categories_add.dart';
import 'package:fms_flutter/util/app_manager.dart';
import 'package:path/path.dart' as path;

class PiwigiRequest {
  static void uploadImage(File _imageDir, int category,
      {String host, String token}) async {
    //注意：dio3.x版本为了兼容web做了一些修改，上传图片的时候需要把File类型转换成String类型
    // Dio dio = Dio();
    // var cookieJar = CookieJar();
    // dio.interceptors.add(CookieManager(cookieJar));

    var fileDir = _imageDir.path;
    var basename = path.basename(fileDir);

    FormData formData = FormData.fromMap({
      "name": basename,
      "category": category.toString(),
      "pwg_token": token,
      "file": await MultipartFile.fromFile(fileDir, filename: basename),
    });

    var response = await AppManager.dio.post(
        "http://${host}/piwigo/ws.php?method=pwg.images.upload&format=json",
        data: formData);

    print(response);
  }

  static Future<int> add({String name}) async {
    var options = Options(responseType: ResponseType.json);

    Response response = await AppManager.dio.get(
        "http://${AppManager.getServer()}" +
            PiwigoApiService.pwg_categories_add +
            name,
        options: options);

    if (response != null) {
      print(response);

      CategoriesAddResponse status =
          CategoriesAddResponse.fromJson(jsonDecode(response.toString()));

      if (status.stat == 'ok') return status.result.id.toInt();
      return -1;
    }

    return -1;
  }
}

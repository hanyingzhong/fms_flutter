import 'dart:convert';
import 'dart:io';
import 'package:fms_flutter/model/categories_getlist.dart';
import 'package:fms_flutter/provider/devicemgr_model.dart';
import 'package:fms_flutter/repository/repo_categories.dart';
import 'package:fms_flutter/repository/repo_images.dart';
import 'package:fms_flutter/util/file_util.dart';
import 'package:get/get.dart' hide FormData, Response, MultipartFile;
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart';
import 'package:fms_flutter/api/piwigo_service.dart';
import 'package:fms_flutter/model/pwg_session_getstatus.dart';
import 'package:fms_flutter/util/app_manager.dart';

class LoginMgr {
  String host;
  String username;
  String password;
  String pwgToken;
  bool registgered;

  LoginMgr(this.host, {this.username, this.password});

  void login() async {
    var options = Options();
    options.responseType = ResponseType.json;

    var params = {
      'method': PiwigoApiService.pwg_session_login,
      'username': username,
      'password': password
    };
    FormData formData = FormData.fromMap(params);

    Response response = await AppManager.dio
        .post("http://$host/piwigo/ws.php?format=json",
            data: formData, options: options)
        .timeout(
      Duration(seconds: 2),
      onTimeout: () {
        Get.find<FmsDevice>().connected = false;
        return Response(statusCode: 408);
      },
    );

    print("=======================");
    print(response);
    if (response == null) {
      return;
    }

    if ('ok' == jsonDecode(response.data)['stat']) {
      getSessionStatus();
    }
  }

  void getSessionStatus() async {
    var options = Options();
    options.responseType = ResponseType.json;

    Response response = await AppManager.dio.get(
        'http://$host' + PiwigoApiService.pwg_session_getStatus,
        options: options);
    if (response != null) {
      //print(response);
      PwgSessionGetStatusResponse status =
          PwgSessionGetStatusResponse.fromJson(jsonDecode(response.toString()));
      pwgToken = status.result.pwgToken;
      print('pwgToken:' + pwgToken);
      Get.find<FmsDevice>().pwgToken = pwgToken;
    }
  }

  // ignore: unused_element
  static void _uploadImage(File _imageDir, int category,
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

    // var response =
    //     await Dio().post("http://jd.itying.com/imgupload", data: formData);
    // //{"success":"true","path":"/public\\upload\\obhAbgmCB5tcp3wDrf9MsiOT.txt"}
    // //http://jd.itying.com/upload/obhAbgmCB5tcp3wDrf9MsiOT.txt

    var response = await AppManager.dio.post(
        "http://${host}/piwigo/ws.php?method=pwg.images.upload&format=json",
        data: formData);

    print(response);
  }

  static void getCategoriesList() async {
    List<RepositoryCategory> categories = [];
    var options = Options();
    options.responseType = ResponseType.json;

    Response response = await AppManager.dio.get(
        'http://${AppManager.getServer()}' +
            PiwigoApiService.pwg_categories_getList,
        options: options);
    if (response != null) {
      CategoriesGetListResponse status =
          CategoriesGetListResponse.fromJson(jsonDecode(response.toString()));
      status.result.categories.forEach((element) {
        print(element.id.toString());
        print(element.tnUrl);
        categories.add(RepositoryCategory(
            element.id,
            RepositoryImage(
              RepositoryImageDesc(0, 0, element.tnUrl),
              RepositoryImageDesc(
                  0,
                  0,
                  FileUtils.generateLocalFileName(
                      FileUtils.getFileName(element.tnUrl))),
            ),
            RepositoryImage(null, null),
            nbImages: element.nbImages,
            name: element.name,
            comment: element.comment));
      });
      Get.put<List<RepositoryCategory>>(categories);
    }
  }
}

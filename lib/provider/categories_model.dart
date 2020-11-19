import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fms_flutter/api/Piwigo_service.dart';
import 'package:fms_flutter/model/categories_getlist.dart';
import 'package:fms_flutter/repository/repo_categories.dart';
import 'package:fms_flutter/repository/repo_images.dart';
import 'package:fms_flutter/util/app_manager.dart';
import 'package:fms_flutter/util/file_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// class PhotoCategoriesPageModel with ChangeNotifier {
//   List<Category> categories = [];
//   int currentIndex = 0;
//   String nextPageUrl;
//   bool loading = true;
//   bool error = false;
//   RefreshController refreshController =
//       RefreshController(initialRefresh: false);

//   refresh({bool retry = false}) async {
//     List<RepositoryCategory> cat2 = [];

//     PiwigoApiService.getData(
//         'http://192.168.1.3', PiwigoApiService.pwg_categories_getList,
//         success: (result) async {
//       //print(result);
//       CategoriesGetListResponse response =
//           CategoriesGetListResponse.fromJson(result);
//       print(response);
//       categories.clear();
//       categories.addAll(response.result.categories);
//       loading = false;
//       error = false;

//       response.result.categories.forEach((element) {
//         cat2.add(RepositoryCategory(
//             element.id,
//             RepositoryImage(
//               RepositoryImageDesc(0, 0, element.tnUrl),
//               RepositoryImageDesc(
//                   0,
//                   0,
//                   FileUtils.generateLocalFileName(
//                       FileUtils.getFileName(element.tnUrl))),
//             ),
//             RepositoryImage(null, null)));
//       });

//       print('=============' + response.result.categories[0].toString());
//       cat2.forEach((element) {
//         print(element.local.thumb.location);
//         print(element.local.large.location);
//       });

//       nextPageUrl = null;
//       refreshController.refreshCompleted();
//       refreshController.footerMode.value = LoadStatus.canLoading;
//       await loadMore();
//     }, fail: (e) {
//       print(e);
//     }, complete: () {
//       notifyListeners();
//     });
//   }

//   retry() {
//     loading = true;
//     notifyListeners();
//     refresh();
//   }

//   Future loadMore() async {
//     if (nextPageUrl == null) {
//       refreshController.loadNoData();
//       return;
//     }
//   }
// }

class PhotoCategoriesPageModel with ChangeNotifier {
  List<RepositoryCategory> categories = [];
  int currentIndex = 0;
  String nextPageUrl;
  bool loading = true;
  bool error = false;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  refresh({bool retry = false}) async {
    PiwigoApiService.getData('http://${AppManager.getServer()}',
        PiwigoApiService.pwg_categories_getList, success: (result) async {
      //print(result);
      CategoriesGetListResponse response =
          CategoriesGetListResponse.fromJson(result);
      //print(response);
      categories.clear();
      loading = false;
      error = false;

      response.result.categories.forEach((element) {
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

      // print('=============' + response.result.categories[0].toString());
      // categories.forEach((element) {
      //   print(element.local.thumb.location);
      //   print(element.local.large.location);
      // });

      nextPageUrl = null;
      refreshController.refreshCompleted();
      refreshController.footerMode.value = LoadStatus.canLoading;
      await loadMore();
    }, fail: (e) {
      print(e);
    }, complete: () {
      notifyListeners();
    });
  }

  retry() {
    loading = true;
    notifyListeners();
    refresh();
  }

  Future loadMore() async {
    if (nextPageUrl == null) {
      refreshController.loadNoData();
      return;
    }
  }

  add({String name}) async {
    var options = Options();
    options.responseType = ResponseType.json;

    var queryParameters = {
      'format': 'json',
      'method': PiwigoApiService.pwg_session_login,
      'name': name,
    };

    Response response = await AppManager.dio.get(
        "http://${AppManager.getServer()}" +
            PiwigoApiService.pwg_categories_add +
            name,
        options: options);
    print(response);
  }
}

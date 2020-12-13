import 'dart:convert';
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

class PhotoCategoriesPageModel with ChangeNotifier {
  List<RepositoryCategory> categories = [];
  int currentIndex = 0;
  String nextPageUrl;
  bool loading = true;
  bool error = false;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  refresh1({bool retry = false}) async {
    PiwigoApiService.getData('http://${AppManager.getServer()}',
        PiwigoApiService.pwg_categories_getList, success: (result) async {
      CategoriesGetListResponse response =
          CategoriesGetListResponse.fromJson(result);
      categories.clear();
      loading = false;
      error = false;

      response.result.categories.forEach((element) {
        print(element.id.toString());
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

  refresh({bool retry = false}) async {
    var options = Options(responseType: ResponseType.json);

    Response response = await AppManager.dio
        .get(
            "http://${AppManager.getServer()}" +
                PiwigoApiService.pwg_categories_getList,
            options: options)
        .timeout(
      Duration(seconds: 1),
      onTimeout: () {
        return Response(statusCode: 408);
      },
    );
    print(response);
    if (response == null) {
      return;
    }
    var result = json.decode(response.data);

    CategoriesGetListResponse getListResponse =
        CategoriesGetListResponse.fromJson(result);
    categories.clear();
    loading = false;
    error = false;

    getListResponse.result.categories.forEach((element) {
      print(element.id.toString());
      categories.add(RepositoryCategory(
          element.id,
          element.tnUrl != null
              ? RepositoryImage(
                  RepositoryImageDesc(0, 0, element.tnUrl),
                  RepositoryImageDesc(
                      0,
                      0,
                      FileUtils.generateLocalFileName(
                          FileUtils.getFileName(element.tnUrl))),
                )
              : RepositoryImage(null, null),
          RepositoryImage(null, null),
          nbImages: element.nbImages,
          name: element.name,
          comment: element.comment));
    });

    nextPageUrl = null;
    refreshController.refreshCompleted();
    refreshController.footerMode.value = LoadStatus.canLoading;
    await loadMore();
    notifyListeners();
  }

  add({String name}) async {
    var options = Options(responseType: ResponseType.json);

    Response response = await AppManager.dio.get(
        "http://${AppManager.getServer()}" +
            PiwigoApiService.pwg_categories_add +
            name,
        options: options);
    print(response);
  }
}

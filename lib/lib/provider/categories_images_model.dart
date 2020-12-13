import 'package:flutter/material.dart';
import 'package:fms_flutter/api/Piwigo_service.dart';
import 'package:fms_flutter/model/categories_getimages.dart';
import 'package:fms_flutter/repository/repo_images.dart';
import 'package:fms_flutter/util/app_manager.dart';
import 'package:fms_flutter/util/file_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PhotoCategoryImagesPageModel with ChangeNotifier {
  int categoryIndex = 1;

  List<RepositoryImagePair> images = [];
  int currentIndex = 0;
  String nextPageUrl;
  bool loading = true;
  bool error = false;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  PhotoCategoryImagesPageModel(this.categoryIndex);

  refresh({bool retry = false}) async {
    PiwigoApiService.getData(
        'http://${AppManager.getServer()}',
        PiwigoApiService.pwg_categories_getImages +
            this.categoryIndex.toString(), success: (result) async {
      //print(result);
      CategoriesGetImagesResponse response =
          CategoriesGetImagesResponse.fromJson(result);
      //print(response);
      images.clear();
      response.result.images.forEach((element) {
        RepositoryImage network = RepositoryImage(
          RepositoryImageDesc(
              element.derivatives.square.width,
              element.derivatives.square.height,
              element.derivatives.square.url),
          RepositoryImageDesc(
              element.derivatives.medium.width,
              element.derivatives.medium.height,
              element.derivatives.medium.url),
        );

        RepositoryImage thumbLocation = RepositoryImage(
          RepositoryImageDesc(
              element.derivatives.square.width,
              element.derivatives.square.height,
              FileUtils.generateLocalFileName(
                  FileUtils.getFileName(element.derivatives.square.url))),
          RepositoryImageDesc(
              element.derivatives.medium.width,
              element.derivatives.medium.height,
              FileUtils.generateLocalFileName(
                  FileUtils.getFileName(element.derivatives.medium.url))),
        );

        RepositoryImagePair image = RepositoryImagePair(
            id: element.id, local: thumbLocation, network: network);
        images.add(image);
      });

      //images.addAll(response.result.images);
      loading = false;
      error = false;

      // images.forEach((item) {
      //   print('1' + item.local.thumb.location);
      //   print('2' + item.local.large.location);
      //   print('3' + item.network.thumb.location);
      //   print('4' + item.network.large.location);
      // });

      // response.result.images.forEach((item) {
      //   if (item.derivatives.thumb != null) {
      //     print(item.derivatives.thumb.url);
      //   }
      // });

      nextPageUrl = null;
      refreshController.refreshCompleted();
      refreshController.footerMode.value = LoadStatus.canLoading;
      await loadMore();
    }, fail: (e) {
      print(e);
    }, complete: () {
      print('completed!');
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
}

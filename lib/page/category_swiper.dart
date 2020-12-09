import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fms_flutter/repository/repo_images.dart';
import 'package:get/get.dart';
import 'package:network_to_file_image/network_to_file_image.dart';

class CategoryPhotoSwiperPage extends StatelessWidget {
  final int categoryId;

  CategoryPhotoSwiperPage(this.categoryId);

  @override
  Widget build(BuildContext context) {
    List<RepositoryImagePair> images =
        Get.find<List<RepositoryImagePair>>(tag: categoryId.toString());
    return Scaffold(
        appBar: AppBar(
          title: Text("ExampleHorizontal"),
        ),
        body: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Image(
              image: NetworkToFileImage(
                url: images[index].network.large.location,
                file: File(images[index].local.large.location),
                debug: true,
              ),
              fit: BoxFit.cover,
            );
          },
          indicatorLayout: PageIndicatorLayout.COLOR,
          autoplay: true,
          itemCount: images.length,
          //pagination: SwiperPagination(),
          // pagination: SwiperPagination(
          //     alignment: Alignment.bottomRight,
          //     margin: const EdgeInsets.fromLTRB(0, 0, 20, 10),
          //     builder: DotSwiperPaginationBuilder(
          //         color: Colors.black54, activeColor: Colors.white)),
          pagination: SwiperPagination(
              alignment: Alignment.bottomRight,
              margin: const EdgeInsets.fromLTRB(0, 0, 20, 10),
              builder: FractionPaginationBuilder(
                  color: Colors.black54, activeColor: Colors.white)),
          control: SwiperControl(),
        ));
  }
}

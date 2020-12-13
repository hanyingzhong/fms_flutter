import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fms_flutter/plugin/staggered_gridview_page.dart';
import 'package:fms_flutter/repository/repo_images.dart';
import 'package:get/get.dart';

const List<StaggeredTile> _tiles = const <StaggeredTile>[
  const StaggeredTile.count(1, 1.5),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(1, 1.5),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(1, 1.5),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(1, 1.5),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(1, 1.5),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(1, 1.5),
  const StaggeredTile.count(1, 1),
];

// ignore: must_be_immutable
class CategoryStaggeredExtentCountPage extends StatelessWidget {
  final int categoryId;

  CategoryStaggeredExtentCountPage(this.categoryId);
  @override
  Widget build(BuildContext context) {
    return StaggeredGridViewPage.extent(
        title: 'Staggered (Extent, Count)',
        // maxCrossAxisExtent: 170.0, // 最大副轴长度
        maxCrossAxisExtent: 200.0,
        tiles: _tiles);
  }
}

//经测试发现，这个属性意思是副轴的最大长度，因为GridView的主轴是竖的，
//所以GridView中该属性指的是最大宽度，如果屏幕是320像素宽，指定为160
//的时候GridView默认每行显示2个，那如果是150或者170的时候呢？前面说了
//是最大宽度，当150的时候，每行能放下2个还多一点空间，所以GridView会把
//每个item缩小然后每行放3个item，如果是170的时候能放1个item还多一点空
//间，这时候就会缩小这个item的宽度然后放2个item，测试代码如下：

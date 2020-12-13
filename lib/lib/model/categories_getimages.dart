import 'dart:convert' show json;

class CategoriesGetImagesResponse {
  String stat;
  Result result;

  CategoriesGetImagesResponse.fromParams({this.stat, this.result});

  factory CategoriesGetImagesResponse(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? CategoriesGetImagesResponse.fromJson(json.decode(jsonStr))
          : CategoriesGetImagesResponse.fromJson(jsonStr);

  CategoriesGetImagesResponse.fromJson(jsonRes) {
    stat = jsonRes['stat'];
    result =
        jsonRes['result'] == null ? null : Result.fromJson(jsonRes['result']);
  }

  @override
  String toString() {
    return '{"stat": ${stat != null ? '${json.encode(stat)}' : 'null'}, "result": $result}';
  }
}

class Result {
  List<CategoryImage> images;
  Paging paging;

  Result.fromParams({this.images, this.paging});

  Result.fromJson(jsonRes) {
    images = jsonRes['images'] == null ? null : [];

    for (var imagesItem in images == null ? [] : jsonRes['images']) {
      images
          .add(imagesItem == null ? null : CategoryImage.fromJson(imagesItem));
    }

    paging =
        jsonRes['paging'] == null ? null : Paging.fromJson(jsonRes['paging']);
  }

  @override
  String toString() {
    return '{"images": $images, "paging": $paging}';
  }
}

class Paging {
  int count;
  int page;
  int perPage;
  String totalCount;

  Paging.fromParams({this.count, this.page, this.perPage, this.totalCount});

  Paging.fromJson(jsonRes) {
    count = jsonRes['count'];
    page = jsonRes['page'];
    perPage = jsonRes['per_page'];
    totalCount = jsonRes['total_count'];
  }

  @override
  String toString() {
    return '{"count": $count, "page": $page, "per_page": $perPage, "total_count": ${totalCount != null ? '${json.encode(totalCount)}' : 'null'}}';
  }
}

class CategoryImage {
  String comment;
  int height;
  int hit;
  int id;
  int width;
  String dateAvailable;
  String dateCreation;
  String elementUrl;
  String file;
  String name;
  String pageUrl;
  List<Categories> categories;
  Derivatives derivatives;

  CategoryImage.fromParams(
      {this.comment,
      this.height,
      this.hit,
      this.id,
      this.width,
      this.dateAvailable,
      this.dateCreation,
      this.elementUrl,
      this.file,
      this.name,
      this.pageUrl,
      this.categories,
      this.derivatives});

  CategoryImage.fromJson(jsonRes) {
    comment = jsonRes['comment'];
    height = jsonRes['height'];
    hit = jsonRes['hit'];
    id = jsonRes['id'];
    width = jsonRes['width'];
    dateAvailable = jsonRes['date_available'];
    dateCreation = jsonRes['date_creation'];
    elementUrl = jsonRes['element_url'];
    file = jsonRes['file'];
    name = jsonRes['name'];
    pageUrl = jsonRes['page_url'];
    categories = jsonRes['categories'] == null ? null : [];

    for (var categoriesItem
        in categories == null ? [] : jsonRes['categories']) {
      categories.add(
          categoriesItem == null ? null : Categories.fromJson(categoriesItem));
    }

    derivatives = jsonRes['derivatives'] == null
        ? null
        : Derivatives.fromJson(jsonRes['derivatives']);
  }

  @override
  String toString() {
    return '{"comment": ${comment != null ? '${json.encode(comment)}' : 'null'}, "height": $height, "hit": $hit, "id": $id, "width": $width, "date_available": ${dateAvailable != null ? '${json.encode(dateAvailable)}' : 'null'}, "date_creation": ${dateCreation != null ? '${json.encode(dateCreation)}' : 'null'}, "element_url": ${elementUrl != null ? '${json.encode(elementUrl)}' : 'null'}, "file": ${file != null ? '${json.encode(file)}' : 'null'}, "name": ${name != null ? '${json.encode(name)}' : 'null'}, "page_url": ${pageUrl != null ? '${json.encode(pageUrl)}' : 'null'}, "categories": $categories, "derivatives": $derivatives}';
  }
}

class Derivatives {
  TSmall tsmall;
  Large large;
  Medium medium;
  Small ssmall;
  Square square;
  Thumb thumb;
  Xlarge xlarge;
  Xsmall xsmall;
  Xxlarge xxlarge;

  Derivatives.fromParams(
      {this.tsmall,
      this.large,
      this.medium,
      this.ssmall,
      this.square,
      this.thumb,
      this.xlarge,
      this.xsmall,
      this.xxlarge});

  Derivatives.fromJson(jsonRes) {
    tsmall =
        jsonRes['2small'] == null ? null : TSmall.fromJson(jsonRes['2small']);
    large = jsonRes['large'] == null ? null : Large.fromJson(jsonRes['large']);
    medium =
        jsonRes['medium'] == null ? null : Medium.fromJson(jsonRes['medium']);
    ssmall = jsonRes['small'] == null ? null : Small.fromJson(jsonRes['small']);
    square =
        jsonRes['square'] == null ? null : Square.fromJson(jsonRes['square']);
    thumb = jsonRes['thumb'] == null ? null : Thumb.fromJson(jsonRes['thumb']);
    xlarge =
        jsonRes['xlarge'] == null ? null : Xlarge.fromJson(jsonRes['xlarge']);
    xsmall =
        jsonRes['xsmall'] == null ? null : Xsmall.fromJson(jsonRes['xsmall']);
    xxlarge = jsonRes['xxlarge'] == null
        ? null
        : Xxlarge.fromJson(jsonRes['xxlarge']);
  }

  @override
  String toString() {
    return '{"2small": $tsmall, "large": $large, "medium": $medium, "small": $ssmall, "square": $square, "thumb": $thumb, "xlarge": $xlarge, "xsmall": $xsmall, "xxlarge": $xxlarge}';
  }
}

class Xxlarge {
  int height;
  int width;
  String url;

  Xxlarge.fromParams({this.height, this.width, this.url});

  Xxlarge.fromJson(jsonRes) {
    height = jsonRes['height'];
    width = jsonRes['width'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"height": $height, "width": $width, "url": ${url != null ? '${json.encode(url)}' : 'null'}}';
  }
}

class Xsmall {
  int height;
  int width;
  String url;

  Xsmall.fromParams({this.height, this.width, this.url});

  Xsmall.fromJson(jsonRes) {
    height = jsonRes['height'];
    width = jsonRes['width'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"height": $height, "width": $width, "url": ${url != null ? '${json.encode(url)}' : 'null'}}';
  }
}

class Xlarge {
  int height;
  int width;
  String url;

  Xlarge.fromParams({this.height, this.width, this.url});

  Xlarge.fromJson(jsonRes) {
    height = jsonRes['height'];
    width = jsonRes['width'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"height": $height, "width": $width, "url": ${url != null ? '${json.encode(url)}' : 'null'}}';
  }
}

class Thumb {
  int height;
  int width;
  String url;

  Thumb.fromParams({this.height, this.width, this.url});

  Thumb.fromJson(jsonRes) {
    height = jsonRes['height'];
    width = jsonRes['width'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"height": $height, "width": $width, "url": ${url != null ? '${json.encode(url)}' : 'null'}}';
  }
}

class Square {
  int height;
  int width;
  String url;

  Square.fromParams({this.height, this.width, this.url});

  Square.fromJson(jsonRes) {
    height = jsonRes['height'];
    width = jsonRes['width'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"height": $height, "width": $width, "url": ${url != null ? '${json.encode(url)}' : 'null'}}';
  }
}

class Small {
  int height;
  int width;
  String url;

  Small.fromParams({this.height, this.width, this.url});

  Small.fromJson(jsonRes) {
    height = jsonRes['height'];
    width = jsonRes['width'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"height": $height, "width": $width, "url": ${url != null ? '${json.encode(url)}' : 'null'}}';
  }
}

class Medium {
  int height;
  int width;
  String url;

  Medium.fromParams({this.height, this.width, this.url});

  Medium.fromJson(jsonRes) {
    height = jsonRes['height'];
    width = jsonRes['width'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"height": $height, "width": $width, "url": ${url != null ? '${json.encode(url)}' : 'null'}}';
  }
}

class Large {
  int height;
  int width;
  String url;

  Large.fromParams({this.height, this.width, this.url});

  Large.fromJson(jsonRes) {
    height = jsonRes['height'];
    width = jsonRes['width'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"height": $height, "width": $width, "url": ${url != null ? '${json.encode(url)}' : 'null'}}';
  }
}

class TSmall {
  int height;
  int width;
  String url;

  TSmall.fromParams({this.height, this.width, this.url});

  TSmall.fromJson(jsonRes) {
    height = jsonRes['height'];
    width = jsonRes['width'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"height": $height, "width": $width, "url": ${url != null ? '${json.encode(url)}' : 'null'}}';
  }
}

class Categories {
  int id;
  String pageUrl;
  String url;

  Categories.fromParams({this.id, this.pageUrl, this.url});

  Categories.fromJson(jsonRes) {
    id = jsonRes['id'];
    pageUrl = jsonRes['page_url'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"id": $id, "page_url": ${pageUrl != null ? '${json.encode(pageUrl)}' : 'null'}, "url": ${url != null ? '${json.encode(url)}' : 'null'}}';
  }
}

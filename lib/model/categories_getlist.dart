import 'dart:convert' show json;

class CategoriesGetListResponse {
  String stat;
  Result result;

  CategoriesGetListResponse.fromParams({this.stat, this.result});

  factory CategoriesGetListResponse(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? CategoriesGetListResponse.fromJson(json.decode(jsonStr))
          : CategoriesGetListResponse.fromJson(jsonStr);

  CategoriesGetListResponse.fromJson(jsonRes) {
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
  List<Category> categories;

  Result.fromParams({this.categories});

  Result.fromJson(jsonRes) {
    categories = jsonRes['categories'] == null ? null : [];

    for (var categoriesItem
        in categories == null ? [] : jsonRes['categories']) {
      categories.add(
          categoriesItem == null ? null : Category.fromJson(categoriesItem));
    }
  }

  @override
  String toString() {
    return '{"categories": $categories}';
  }
}

class Category {
  int idUppercat;
  String permalink;
  int id;
  int nbCategories;
  int nbImages;
  int totalNbImages;
  String comment;
  String dateLast;
  String globalRank;
  String maxDateLast;
  String name;
  String representativePictureId;
  String status;
  String tnUrl;
  String uppercats;
  String url;

  Category.fromParams(
      {this.idUppercat,
      this.permalink,
      this.id,
      this.nbCategories,
      this.nbImages,
      this.totalNbImages,
      this.comment,
      this.dateLast,
      this.globalRank,
      this.maxDateLast,
      this.name,
      this.representativePictureId,
      this.status,
      this.tnUrl,
      this.uppercats,
      this.url});

  Category.fromJson(jsonRes) {
    idUppercat = jsonRes['id_uppercat'];
    permalink = jsonRes['permalink'];
    id = jsonRes['id'];
    nbCategories = jsonRes['nb_categories'];
    nbImages = jsonRes['nb_images'];
    totalNbImages = jsonRes['total_nb_images'];
    comment = jsonRes['comment'];
    dateLast = jsonRes['date_last'];
    globalRank = jsonRes['global_rank'];
    maxDateLast = jsonRes['max_date_last'];
    name = jsonRes['name'];
    representativePictureId = jsonRes['representative_picture_id'];
    status = jsonRes['status'];
    tnUrl = jsonRes['tn_url'];
    uppercats = jsonRes['uppercats'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"idUppercat": $idUppercat, "permalink": ${permalink != null ? '${json.encode(permalink)}' : 'null'}, "id": $id, "nb_categories": $nbCategories, "nb_images": $nbImages, "total_nb_images": $totalNbImages, "comment": ${comment != null ? '${json.encode(comment)}' : 'null'}, "date_last": ${dateLast != null ? '${json.encode(dateLast)}' : 'null'}, "global_rank": ${globalRank != null ? '${json.encode(globalRank)}' : 'null'}, "max_date_last": ${maxDateLast != null ? '${json.encode(maxDateLast)}' : 'null'}, "name": ${name != null ? '${json.encode(name)}' : 'null'}, "representative_picture_id": ${representativePictureId != null ? '${json.encode(representativePictureId)}' : 'null'}, "status": ${status != null ? '${json.encode(status)}' : 'null'}, "tn_url": ${tnUrl != null ? '${json.encode(tnUrl)}' : 'null'}, "uppercats": ${uppercats != null ? '${json.encode(uppercats)}' : 'null'}, "url": ${url != null ? '${json.encode(url)}' : 'null'}}';
  }
}

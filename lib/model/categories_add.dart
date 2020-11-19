import 'dart:convert' show json;

class CategoriesAddResponse {
  String stat;
  Result result;

  CategoriesAddResponse.fromParams({this.stat, this.result});

  factory CategoriesAddResponse(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? CategoriesAddResponse.fromJson(json.decode(jsonStr))
          : CategoriesAddResponse.fromJson(jsonStr);

  CategoriesAddResponse.fromJson(jsonRes) {
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
  int id;
  String info;

  Result.fromParams({this.id, this.info});

  Result.fromJson(jsonRes) {
    id = jsonRes['id'];
    info = jsonRes['info'];
  }

  @override
  String toString() {
    return '{"id": $id, "info": ${info != null ? '${json.encode(info)}' : 'null'}}';
  }
}

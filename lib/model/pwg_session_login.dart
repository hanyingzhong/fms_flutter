import 'dart:convert' show json;

class PwgSessionLoginResponse {
  bool result;
  String stat;
  String err;
  String message;

  PwgSessionLoginResponse.fromParams(
      {this.result, this.stat, this.err, this.message});

  factory PwgSessionLoginResponse(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? PwgSessionLoginResponse.fromJson(json.decode(jsonStr))
          : PwgSessionLoginResponse.fromJson(jsonStr);

  PwgSessionLoginResponse.fromJson(jsonRes) {
    result = jsonRes['result'];
    stat = jsonRes['stat'];
    err = jsonRes['err'];
    message = jsonRes['message'];
  }

  @override
  String toString() {
    return '{"result": $result, "stat": ${stat != null ? '${json.encode(stat)}' : 'null'}}';
  }
}

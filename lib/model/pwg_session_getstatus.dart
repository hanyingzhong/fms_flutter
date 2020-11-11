import 'dart:convert' show json;

class PwgSessionGetStatusResponse {
  String stat;
  Result result;

  PwgSessionGetStatusResponse.fromParams({this.stat, this.result});

  factory PwgSessionGetStatusResponse(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? PwgSessionGetStatusResponse.fromJson(json.decode(jsonStr))
          : PwgSessionGetStatusResponse.fromJson(jsonStr);

  PwgSessionGetStatusResponse.fromJson(jsonRes) {
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
  int uploadFormChunkSize;
  String charset;
  String currentDatetime;
  String language;
  String pwgToken;
  String status;
  String theme;
  String uploadFileTypes;
  String username;
  String version;
  List<String> availableSizes;

  Result.fromParams(
      {this.uploadFormChunkSize,
      this.charset,
      this.currentDatetime,
      this.language,
      this.pwgToken,
      this.status,
      this.theme,
      this.uploadFileTypes,
      this.username,
      this.version,
      this.availableSizes});

  Result.fromJson(jsonRes) {
    uploadFormChunkSize = jsonRes['upload_form_chunk_size'];
    charset = jsonRes['charset'];
    currentDatetime = jsonRes['current_datetime'];
    language = jsonRes['language'];
    pwgToken = jsonRes['pwg_token'];
    status = jsonRes['status'];
    theme = jsonRes['theme'];
    uploadFileTypes = jsonRes['upload_file_types'];
    username = jsonRes['username'];
    version = jsonRes['version'];
    availableSizes = jsonRes['available_sizes'] == null ? null : [];

    for (var availableSizesItem
        in availableSizes == null ? [] : jsonRes['available_sizes']) {
      availableSizes.add(availableSizesItem);
    }
  }

  @override
  String toString() {
    return '{"upload_form_chunk_size": $uploadFormChunkSize, "charset": ${charset != null ? '${json.encode(charset)}' : 'null'}, "current_datetime": ${currentDatetime != null ? '${json.encode(currentDatetime)}' : 'null'}, "language": ${language != null ? '${json.encode(language)}' : 'null'}, "pwg_token": ${pwgToken != null ? '${json.encode(pwgToken)}' : 'null'}, "status": ${status != null ? '${json.encode(status)}' : 'null'}, "theme": ${theme != null ? '${json.encode(theme)}' : 'null'}, "upload_file_types": ${uploadFileTypes != null ? '${json.encode(uploadFileTypes)}' : 'null'}, "username": ${username != null ? '${json.encode(username)}' : 'null'}, "version": ${version != null ? '${json.encode(version)}' : 'null'}, "available_sizes": $availableSizes}';
  }
}

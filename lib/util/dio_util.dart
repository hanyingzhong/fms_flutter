import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fms_flutter/api/piwigo_service.dart';
import 'package:fms_flutter/model/pwg_session_getstatus.dart';
import 'package:fms_flutter/util/app_manager.dart';

class LoginMgr {
  String host;
  String username;
  String password;
  String pwgToken;
  bool registgered;

  LoginMgr(this.host, {this.username, this.password});

  void login() async {
    var options = Options();
    options.responseType = ResponseType.json;

    var params = {
      'method': PiwigoApiService.pwg_session_login,
      'username': username,
      'password': password
    };
    FormData formData = FormData.fromMap(params);

    Response response = await AppManager.dio.post(
        "http://$host/piwigo/ws.php?format=json",
        data: formData,
        options: options);

    print(response);
    getSessionStatus();
  }

  void getSessionStatus() async {
    var options = Options();
    options.responseType = ResponseType.json;

    Response response = await AppManager.dio.get(
        'http://$host' + PiwigoApiService.pwg_session_getStatus,
        options: options);
    if (response != null) {
      //print(response);
      PwgSessionGetStatusResponse status =
          PwgSessionGetStatusResponse.fromJson(jsonDecode(response.toString()));
      pwgToken = status.result.pwgToken;
    }
  }
}

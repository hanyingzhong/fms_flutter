import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fms_flutter/provider/devicemgr_model.dart';
//import 'package:get/get.dart';
import 'package:fms_flutter/util/validation.dart';
import 'package:get/get.dart';

class DeviceManagePage extends StatefulWidget {
  @override
  _DeviceManagePageState createState() => _DeviceManagePageState();
}

class _DeviceManagePageState extends State<DeviceManagePage> {
  final _formKey = GlobalKey<FormState>();

  String loginPassword = Get.find<DeviceLoginInfo>().loginPassword;
  String usernameValidation(String v) => v.isRequired()();
  String emailValidation(String v) => [v.isRequired(), v.isEmail()].validate();
  String passwordValidation(String v) => [
        v.isRequired(),
        v.minLength(4),
      ].validate();
  String confirmPasswordValidation(String v) => [
        v.isRequired(),
        v.minLength(4),
        v.match(loginPassword),
      ].validate();
  validate() {
    if (true == _formKey.currentState.validate()) {
      print(Get.find<DeviceLoginInfo>().deviceName);
      print(Get.find<DeviceLoginInfo>().loginPassword);
      print(loginPassword);
    }
  }

  resetForm() {
    _formKey.currentState.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("设备管理"),
      ),
      body: Container(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: Get.find<DeviceLoginInfo>().deviceName,
                validator: usernameValidation,
                onChanged: (v) => Get.find<DeviceLoginInfo>().deviceName = v,
                decoration: InputDecoration(
                  labelText: "设备名",
                ),
              ),
              TextFormField(
                initialValue: Get.find<DeviceLoginInfo>().loginUser,
                validator: usernameValidation,
                onChanged: (v) => Get.find<DeviceLoginInfo>().loginUser = v,
                decoration: InputDecoration(
                  labelText: "用户名",
                ),
              ),
              TextFormField(
                initialValue: Get.find<DeviceLoginInfo>().loginPassword,
                validator: passwordValidation,
                obscureText: true,
                onChanged: (v) {
                  Get.find<DeviceLoginInfo>().loginPassword = v;
                  loginPassword = v;
                },
                decoration: InputDecoration(
                  labelText: "密码",
                ),
              ),
              TextFormField(
                validator: confirmPasswordValidation,
                initialValue: Get.find<DeviceLoginInfo>().loginPassword,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "证实密码",
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                child: Container(
                  width: Get.width,
                  child: FlatButton(
                    color: Colors.grey[400],
                    onPressed: validate,
                    child: Text("添加"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

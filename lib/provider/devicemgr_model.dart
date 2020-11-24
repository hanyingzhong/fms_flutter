import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class DeviceLoginInfo {
  String deviceName;
  String loginUser;
  String loginPassword;
  DeviceLoginInfo({this.deviceName, this.loginUser, this.loginPassword});
}

class FmsDevice {
  String name;
  String host;
  String username;
  String password;
  bool connected = false;

  FmsDevice(
      {this.name, this.host, this.username, this.password, this.connected});

  @override
  String toString() {
    return '{"name": "$name", "username": "$username","password": "$password"}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }

  fromJson(Map<String, dynamic> data) {
    name = data['name'];
    username = data['username'];
    password = data['password'];
  }
}

class FmsDeviceMgr {
  factory FmsDeviceMgr() => _getInstance();
  static FmsDeviceMgr get instance => _getInstance();
  static FmsDeviceMgr _instance;
  // ignore: empty_constructor_bodies
  FmsDeviceMgr._internal() {}

  static FmsDeviceMgr _getInstance() {
    if (_instance == null) {
      _instance = new FmsDeviceMgr._internal();
    }
    return _instance;
  }

  List<FmsDevice> mgr = [];

  setCurrentDevice({@required FmsDevice currentDevice}) {
    Get.find<FmsDevice>().host = currentDevice.host;
    Get.find<FmsDevice>().name = currentDevice.name;

    mgr.removeWhere((element) {
      if (element.name == currentDevice.name) {
        return true;
      }
      return false;
    });

    mgr.add(currentDevice);
  }

  add(FmsDevice device) {
    mgr.add(device);
  }

  Future<bool> searchCurrentDevice(String deviceName) async {
    bool connect;
    String newHost;
    try {
      final result = await InternetAddress.lookup(deviceName,
          type: InternetAddressType.IPv4);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Get.find<FmsDevice>().connected = true;
        connect = true;
        newHost = result[0].address;
        print(newHost);
        setCurrentDevice(
            currentDevice:
                FmsDevice(name: deviceName, host: newHost, connected: true));
      }
    } on SocketException catch (_) {
      connect = false;
      Get.find<FmsDevice>().connected = false;
    }
    print('connect to ' + deviceName + ' ' + connect.toString());
    return connect;
  }
}

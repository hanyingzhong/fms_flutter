import 'dart:io';

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
  bool connected = false;

  FmsDevice({this.name, this.host, this.connected});
  @override
  String toString() {
    return name + '-' + host;
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
  FmsDevice currentDevice;

  setCurrentDevice({@required FmsDevice currentDevice}) {
    this.currentDevice = currentDevice;
    mgr.removeWhere((element) {
      if (element.name == currentDevice.name) {
        return true;
      }
      return false;
    });

    print(currentDevice);
    mgr.add(currentDevice);
  }

  FmsDevice getCurrentDevice() {
    return currentDevice;
  }

  add(FmsDevice device) {
    mgr.add(device);
  }

  Future<void> searchCurrentDevice(String deviceName) async {
    bool connect;
    String newHost;
    try {
      final result = await InternetAddress.lookup(deviceName,
          type: InternetAddressType.IPv4);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        connect = true;
        newHost = result[0].address;
        print(newHost);
        setCurrentDevice(
            currentDevice:
                FmsDevice(name: deviceName, host: newHost, connected: true));
      }
    } on SocketException catch (_) {
      connect = false;
    }
    print('connect to ' + deviceName + ' ' + connect.toString());
  }
}

import 'package:flutter/material.dart';

class FmsDevice {
  String name;
  String host;

  FmsDevice({this.name, this.host});
  @override
  String toString() {
    return name + '-' + host;
  }
}

class FmsDeviceMgr {
  List<FmsDevice> mgr = [];
  FmsDevice currentDevice;
  FmsDeviceMgr();

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
}

final FmsDeviceMgr fmsDeviceMgr = FmsDeviceMgr();

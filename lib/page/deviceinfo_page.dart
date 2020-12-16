import 'package:flutter/material.dart';
import 'package:fms_flutter/provider/devicemgr_model.dart';
import 'package:get/get.dart';

Widget getDeviceInfo() {
  return ExpansionTile(
    //tilePadding: EdgeInsets.all(0.0),
    //childrenPadding: EdgeInsets.all(0.0),
    title: Text("设备信息", style: TextStyle(fontSize: 18)),
    // leading: Icon(
    //   Icons.favorite,
    //   color: Colors.white,
    // ),
    backgroundColor: Colors.grey[500],
    initiallyExpanded: false, //默认是否展开
    children: <Widget>[
      // ListTile(
      //   //contentPadding: EdgeInsets.all(0.0),
      //   title: Text(Get.find<FmsDevice>().name),
      // ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    Get.find<FmsDevice>()?.name ?? "no deivce",
                    style: TextStyle(fontSize: 18),
                  )),
              Spacer(
                flex: 1,
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    Get.find<FmsDevice>()?.host ?? "no device",
                    style: TextStyle(fontSize: 18),
                  )),
              Spacer(
                flex: 1,
              ),
              Offstage(
                  offstage: false,
                  child: Text(Get.find<FmsDevice>()?.username ?? "no device",
                      style: TextStyle(fontSize: 18))),
              Spacer(
                flex: 1,
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

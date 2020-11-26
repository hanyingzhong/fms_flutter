import 'package:flutter/material.dart';
import 'package:fms_flutter/provider/devicemgr_model.dart';
import 'package:get/get.dart';

Widget getDeviceInfo() {
  return ExpansionTile(
    //tilePadding: EdgeInsets.all(0.0),
    //childrenPadding: EdgeInsets.all(0.0),
    title: Text("设备信息"),
    // leading: Icon(
    //   Icons.favorite,
    //   color: Colors.white,
    // ),
    backgroundColor: Colors.grey[500],
    initiallyExpanded: false, //默认是否展开
    children: <Widget>[
      ListTile(
        title: Text(Get.find<FmsDevice>().name),
        // leading: Icon(
        //   Icons.favorite_border,
        //   color: Colors.white,
        // ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(Get.find<FmsDevice>().host),
              Spacer(
                flex: 1,
              ),
              Text(Get.find<FmsDevice>().username),
              Spacer(
                flex: 1,
              ),
              Text('1'),
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

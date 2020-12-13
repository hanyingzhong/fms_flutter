import 'package:dragablegridview_flutter/dragablegridview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fms_flutter/test/itembin.dart';

class DragAbleGridViewDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DragAbleGridViewDemoState();
  }
}

class DragAbleGridViewDemoState extends State<DragAbleGridViewDemo> {
  List<ItemBin> itemBins = List();
  String actionTxtEdit = "编辑";
  String actionTxtComplete = "完成";
  String actionTxt;
  var editSwitchController = EditSwitchController();
  final List<String> heroes = [
    "鲁班",
    "虞姬",
    "甄姬",
    "黄盖",
    "张飞",
    "关羽",
    "刘备",
    "曹操",
    "赵云",
    "孙策",
    "庄周",
    "廉颇",
    "后裔",
    "妲己",
    "荆轲",
  ];

  @override
  void initState() {
    super.initState();
    actionTxt = actionTxtEdit;
    heroes.forEach((heroName) {
      itemBins.add(ItemBin(heroName));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("可拖拽GridView"),
        actions: <Widget>[
          Center(
              child: GestureDetector(
            child: Container(
              child: Text(
                actionTxt,
                style: TextStyle(fontSize: 19.0),
              ),
              margin: EdgeInsets.only(right: 12),
            ),
            onTap: () {
              changeActionState();
              editSwitchController.editStateChanged();
            },
          ))
        ],
      ),
      body: DragAbleGridView(
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 1.8,
        crossAxisCount: 4,
        itemBins: itemBins,
        editSwitchController: editSwitchController,
        /****************************** parameter*********************************/
        isOpenDragAble: true,
        animationDuration: 300, //milliseconds
        longPressDuration: 800, //milliseconds
        /****************************** parameter*********************************/
        deleteIcon: Image.asset("images/ic_home_selected.png",
            width: 15.0, height: 15.0),
        child: (int position) {
          return Container(
            padding: EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(3.0)),
              border: Border.all(color: Colors.blue),
            ),
            //因为本布局和删除图标同处于一个Stack内，设置marginTop和marginRight能让图标处于合适的位置
            //Because this layout and the delete_Icon are in the same Stack, setting marginTop and marginRight will make the icon in the proper position.
            margin: EdgeInsets.only(top: 6.0, right: 6.0),
            child: Text(
              itemBins[position].data,
              style: TextStyle(fontSize: 16.0, color: Colors.blue),
            ),
          );
        },
        editChangeListener: () {
          changeActionState();
        },
      ),
    );
  }

  void changeActionState() {
    if (actionTxt == actionTxtEdit) {
      setState(() {
        actionTxt = actionTxtComplete;
      });
    } else {
      setState(() {
        actionTxt = actionTxtEdit;
      });
    }
  }
}

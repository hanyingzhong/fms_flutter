import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeviceManagePage extends StatefulWidget {
  @override
  _DeviceManagePageState createState() => _DeviceManagePageState();
}

class _DeviceManagePageState extends State<DeviceManagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("设备管理"),
      ),
      body: ListView(
        children: <Widget>[
          buildButton("退出", () => Get.back()),
        ],
      ),
    );
  }

  showTransBackgroundDialog() {
    showGeneralDialog(
      context: context,
      barrierLabel: "你好",
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return Center(
          child: Material(
            child: Container(
              color: Colors.black.withOpacity(animation.value),
              child: Text("我是一个可变的"),
            ),
          ),
        );
      },
    );
  }

  showOtherBackgroundDialog(Color color) {
    showGeneralDialog(
      context: context,
      barrierLabel: "你好",
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 1000),
      barrierColor: color,
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return Center(
          child: Material(
            child: Container(
              color: Colors.black.withOpacity(animation.value),
              child: Text("我是一个可变的"),
            ),
          ),
        );
      },
    );
  }

  showDialogWithToTestTransitionDialog() {
    showGeneralDialog(
      context: context,
      barrierLabel: "你好",
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 1000),
      barrierColor: Colors.white.withOpacity(0.5),
      pageBuilder: (
        BuildContext context,
        Animation animation,
        Animation secondaryAnimation,
      ) {
        return Container(
          child: Text("我是一个dialog"),
        );
      },
      transitionBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        return Center(
          child: Material(
            child: Container(
              color: Colors.red.withOpacity(animation.value),
              child: child,
            ),
          ),
        );
      },
    );
  }

  showDialogWithOffset({OffsetHandle handle = fromLeft}) {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      barrierLabel: "",
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 1000),
      pageBuilder: (
        BuildContext context,
        Animation animation,
        Animation secondaryAnimation,
      ) {
        return Center(
          child: Material(
            child: Container(
              child: Text("我是dialog"),
            ),
          ),
        );
      },
      transitionBuilder: (ctx, animation, _, child) {
        return FractionalTranslation(
          translation: handle(animation),
          child: child,
        );
      },
    );
  }

  showDialogWithScaleTransition() {
    showGeneralDialog(
      context: context,
      barrierLabel: "",
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      barrierDismissible: true,
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return Center(
          child: Image.asset("assets/demo.png"),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return ScaleTransition(
          alignment: Alignment.bottomCenter, // 添加这个
          scale: anim,
          child: child,
        );
      },
    );
  }

  showDialogWithScaleTransitionAndTansform() {
    showGeneralDialog(
      context: context,
      barrierLabel: "",
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 2000),
      barrierDismissible: true,
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return Center(
          child: Image.asset("assets/demo.png"),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        var radians = 2 * pi * anim.value;
        var matrix = Matrix4.rotationY(radians);
        return Transform(
          child: ScaleTransition(
            scale: anim,
            child: child,
          ),
          transform: matrix,
        );
      },
    );
  }
}

typedef Offset OffsetHandle(Animation animation);

Offset fromLeft(Animation animation) {
  return Offset(animation.value - 1, 0);
}

Offset fromRight(Animation animation) {
  return Offset(1 - animation.value, 0);
}

Offset fromTop(Animation animation) {
  return Offset(0, animation.value - 1);
}

Offset fromBottom(Animation animation) {
  return Offset(0, 1 - animation.value);
}

Offset fromTopLeft(Animation anim) {
  return fromLeft(anim) + fromTop(anim);
}

Widget buildButton(
  String text,
  Function onPressed, {
  Color color = Colors.white,
}) {
  return FlatButton(
    color: color,
    child: Text(text),
    onPressed: onPressed,
  );
}

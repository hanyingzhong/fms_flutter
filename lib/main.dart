import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fms_flutter/navigation/tab_navigation.dart';
import 'package:fms_flutter/util/app_manager.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
  //Flutter沉浸式状态栏
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppManager.init();
    return MaterialApp(
        title: 'Eyepetizer', navigatorKey: Get.key, home: TabNavigation());
  }
}

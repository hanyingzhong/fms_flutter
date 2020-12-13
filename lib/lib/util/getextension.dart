import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

extension AppDirectory on GetInterface {
  static Directory appDocsDir;

  static getApplcationDirectory() async {
    if (appDocsDir == null) {
      appDocsDir = await getApplicationDocumentsDirectory();
    }
  }

  Directory getAppDir() {
    if (appDocsDir == null) {
      getApplcationDirectory();
    }
    return appDocsDir;
  }
}

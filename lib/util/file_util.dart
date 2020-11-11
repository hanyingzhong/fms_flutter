import 'package:fms_flutter/util/app_manager.dart';

class FileUtils {
  FileUtils._();

  static String getFileName(String url) {
    Uri uri = Uri.parse(url);
    if (uri.query.split('/').last.length != 0) {
      //print('last ' + uri.query.split('/').last);
      return uri.query.split('/').last;
    }

    //print(uri.path.split('/').last);
    return uri.path.split('/').last;
  }

  static String generateLocalFileName(String name) {
    String fullFileName = AppManager.getAppDir().path + '/' + name;
    //print(fullFileName);
    return fullFileName;
  }
}

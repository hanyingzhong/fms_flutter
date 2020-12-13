import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadStatusController extends GetxController {
  var list = List();
  UploadStatusController({this.list});
}

class UploadProgressStatus {
  UploadProgressStatus({this.categoryId, this.fileName, this.progress});
  final int categoryId;
  final String fileName;
  int progress;

  set setProgress(int progress) {
    this.progress = progress;
  }
}

class UploadStatusShowPage extends StatefulWidget {
  @override
  _UploadStatusShowPageState createState() => _UploadStatusShowPageState();
}

class _UploadStatusShowPageState extends State<UploadStatusShowPage> {
  @override
  void initState() {
    super.initState();
    Get.find<UploadStatusController>()?.list?.forEach((element) {
      print("+++++");
      print(element.value.name);
      print(element.runtimeType);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: GetBuilder(
              init: Get.find<UploadStatusController>(),
              builder: (controller) {
                return Column(children: _buildItems(controller));
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.find<List>().forEach((element) {
            element.update((user) {
              // this parameter is the class itself that you want to update
              user.age++;
            });
          });
        },
      ),
    );
  }

  _buildItems(controller) {
    List<Widget> list = [];

    controller?.list?.forEach((element) {
      list.add(Obx(
          () => Text("Name ${element.value.name}: Age: ${element.value.age}")));
    });

    return list;
  }
}

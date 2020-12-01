import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadController extends GetxController {
  final list = List<String>().obs;
  UploadController() {
    list.add('aaaaaaaaaa');
  }
}

class User {
  User({this.name, this.age});
  String name;
  int age;
}

class UploadStatusShowPage extends StatefulWidget {
  @override
  _UploadStatusShowPageState createState() => _UploadStatusShowPageState();
}

class _UploadStatusShowPageState extends State<UploadStatusShowPage> {
  //final user = User().obs;
  final user = User().obs;
  int idx = 0;

  @override
  void initState() {
    super.initState();
    print("===============");
    user.update((user) {
      // this parameter is the class itself that you want to update
      user.name = 'Jonny====';
      user.age = 18;
    });
    // print(user.runtimeType);
    // print(Get.find<List>().length);
    Get.find<List>().forEach((element) {
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
              init: UploadController(),
              builder: (controller) {
                print("count 1 rebuild");
                return Column(children: _buildItems());
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

  _buildItems() {
    List<Widget> list = [];

    list.add(FlatButton(
        onPressed: () {
          //controller.list.add('bbbbbb');
          idx++;
          user.update((user) {
            // this parameter is the class itself that you want to update
            user.name = 'Jonny';
            user.age = 18 + idx;
          });
        },
        child: Text('add')));

    Get.find<List>().forEach((element) {
      list.add(Obx(
          () => Text("Name ${element.value.name}: Age: ${element.value.age}")));
    });

    return list;
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:fms_flutter/provider/devicemgr_model.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

enum CategoriesManageType { Edit, Create, Delete }

class CategoriesManagePage extends StatefulWidget {
  CategoriesManagePage({CategoriesManageType type, int parent});

  @override
  _CategoriesManagePageState createState() => _CategoriesManagePageState();
}

class _CategoriesManagePageState extends State<CategoriesManagePage> {
  final _formKey = GlobalKey<FormState>();
  bool visible = true;
  bool commnetable = true;

  validate() {
    if (true == _formKey.currentState.validate()) {}
  }

  resetForm() {
    _formKey.currentState.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("相册管理"),
      ),
      body: Container(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: '',
                validator: null,
                onChanged: (v) => Get.find<DeviceLoginInfo>().deviceName = v,
                decoration: InputDecoration(
                  labelText: "相册名",
                ),
              ),
              TextFormField(
                initialValue: '',
                validator: null,
                onChanged: (v) => Get.find<DeviceLoginInfo>().loginUser = v,
                decoration: InputDecoration(
                  labelText: "相册说明",
                ),
                maxLines: 2,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                textDirection: TextDirection.ltr,
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  Expanded(
                      child: Container(
                    // constraints: BoxConstraints(
                    //     maxWidth: MediaQuery.of(context).size.width / 3,
                    //     maxHeight: MediaQuery.of(context).size.height / 3),
                    //color: Color(0xFFFF0000),
                    child: CheckboxListTile(
                      //secondary: const Icon(Icons.shutter_speed),
                      contentPadding: EdgeInsets.all(0),
                      title: const Text('可见'),
                      value: this.visible,
                      onChanged: (bool value) {
                        setState(() {
                          this.visible = !this.visible;
                        });
                      },
                    ),
                  )),
                  Expanded(child: Container(child: Text(''))),
                  Expanded(
                      child: Container(
                    // constraints: BoxConstraints(
                    //     maxWidth: MediaQuery.of(context).size.width / 3,
                    //     maxHeight: MediaQuery.of(context).size.height / 3),
                    //color: Color(0xFFFF0000),
                    child: CheckboxListTile(
                      //secondary: const Icon(Icons.shutter_speed),
                      contentPadding: EdgeInsets.all(0),
                      title: const Text('可评论'),
                      value: this.commnetable,
                      onChanged: (bool value) {
                        setState(() {
                          this.commnetable = !this.commnetable;
                        });
                      },
                    ),
                  )),
                ],
              ),
              ListTile(
                contentPadding: EdgeInsets.all(0.0),
                title: Text('添加图片'),
                trailing: Icon(Icons.add),
                onTap: () {
                  _assetsToFiles();
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                child: Container(
                  width: Get.width,
                  child: FlatButton(
                    color: Colors.grey[400],
                    onPressed: validate,
                    child: Text("提交"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<List<File>> _assetsToFiles() async {
  List<Asset> assetArray = [];
  List<File> fileImageArray = [];

  try {
    assetArray = await MultiImagePicker.pickImages(
      maxImages: 300,
      enableCamera: true,
      selectedAssets: assetArray,
      cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
      materialOptions: MaterialOptions(
        actionBarColor: "",
        actionBarTitle: "ImagePicker",
        allViewTitle: "All Photos",
        useDetailsView: false,
        selectCircleStrokeColor: "#000000",
      ),
    );
  } on Exception catch (e) {
    print(e.toString());
  }

  assetArray.forEach((imageAsset) async {
    final filePath =
        await FlutterAbsolutePath.getAbsolutePath(imageAsset.identifier);

    File tempFile = File(filePath);
    if (tempFile.existsSync()) {
      fileImageArray.add(tempFile);
    }
  });

  return fileImageArray;
}

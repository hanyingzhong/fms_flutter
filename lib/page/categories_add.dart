import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:fms_flutter/provider/devicemgr_model.dart';
import 'package:fms_flutter/util/piwigo_request.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:fms_flutter/util/validation.dart';

enum CategoriesManageType { Edit, Create, Delete }

class CategoriesManagePage extends StatefulWidget {
  CategoriesManagePage({CategoriesManageType type, int parent});

  @override
  _CategoriesManagePageState createState() => _CategoriesManagePageState();
}

String categoryNameValidation(String v) => v.isRequired()();

class _CategoriesManagePageState extends State<CategoriesManagePage> {
  final _formKey = GlobalKey<FormState>();
  bool visible = true;
  bool commentable = true;
  List<Asset> images = List<Asset>();
  String name;
  String comment;

  validate() {
    if (true == _formKey.currentState.validate()) {
      _upload();
      Get.back();
    }
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
                validator: categoryNameValidation,
                onChanged: (v) => name = v,
                decoration: InputDecoration(
                  labelText: "相册名",
                ),
              ),
              TextFormField(
                initialValue: '',
                validator: null,
                onChanged: (v) => comment = v,
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
                    child: CheckboxListTile(
                      //secondary: const Icon(Icons.shutter_speed),
                      contentPadding: EdgeInsets.all(0),
                      title: const Text('可评论'),
                      value: this.commentable,
                      onChanged: (bool value) {
                        setState(() {
                          this.commentable = !this.commentable;
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
                onTap: () async {
                  images = await _assetsPicked();
                  setState(() {});
                },
              ),
              Expanded(
                child: _buildGridView(),
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

  Widget _buildGridView() {
    return GridView.count(
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<List<File>> assetsToFiles(List<Asset> assets) async {
    List<File> fileImageArray = [];

    for (var item in assets) {
      final file = await _getAbsolutePath(item.identifier);
      if (file != null) {
        fileImageArray.add(file);
        print(file.path);
      }
    }

    print('++++++++++++++++++++' + fileImageArray.length.toString());
    return fileImageArray;
  }

  _upload() async {
    List<File> files = await assetsToFiles(images);
    if (files.length == 0) {
      print("why the length is zero...?");
      return;
    }
    var id = await PiwigoRequest.add(name: name);
    print("start create .....category..$id");

    //if (files != null) {
    for (var item in files) {
      print(item.path);
      await PiwigoRequest.uploadImage(
        item,
        id,
        host: Get.find<FmsDevice>().host,
        token: Get.find<FmsDevice>().pwgToken,
      );
    }
  }
}

Future<List<Asset>> _assetsPicked() async {
  List<Asset> assetArray = [];

  try {
    assetArray = await MultiImagePicker.pickImages(
      maxImages: 9,
      enableCamera: false,
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

  return assetArray;
}

Future<File> _getAbsolutePath(String uri) async {
  final filePath = await FlutterAbsolutePath.getAbsolutePath(uri);
  File tempFile = File(filePath);
  if (tempFile.existsSync()) {
    //print(tempFile.path);
  }
  return tempFile;
}

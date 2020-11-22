import 'package:flutter/material.dart';
import 'package:fms_flutter/provider/devicemgr_model.dart';
import 'package:get/get.dart';

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
              ),
              CheckboxListTile(
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
              CheckboxListTile(
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
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   mainAxisSize: MainAxisSize.max,
              //   textDirection: TextDirection.ltr,
              //   verticalDirection: VerticalDirection.down,
              //   children: <Widget>[
              //     Container(
              //       color: Color(0xFFFF0000),
              //       child: Text(
              //         "Text1",
              //         style: TextStyle(fontSize: 30.0),
              //       ),
              //     ),
              //   ],
              // ),
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

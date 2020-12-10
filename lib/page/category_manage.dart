import 'package:flutter/material.dart';
import 'package:fms_flutter/repository/repo_categories.dart';
import 'package:fms_flutter/util/dio_util.dart';
import 'package:fms_flutter/util/validation.dart';
import 'package:get/get.dart';

enum CategoryManageType { Edit, Create, Delete }

class CategoryManagePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final RepositoryCategory category;

  String categoryNameValidation(String v) => v.isRequired()();

  CategoryManagePage(CategoryManageType type, this.category);

  validate() {
    if (true == _formKey.currentState.validate()) {
      LoginMgr.setCategoryInfo(category.id,
          name: category.name, comment: category.comment);
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    print(category);
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(),
        body: Container(
            padding: const EdgeInsets.all(24.0),
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "相册名",
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.left,
                      )),
                  TextFormField(
                    initialValue: category.name,
                    validator: categoryNameValidation,
                    onChanged: (v) => category.name = v,
                  ),
                  Padding(padding: EdgeInsets.all(20)),
                  Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "相册说明",
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.left,
                      )),
                  Expanded(
                      child: TextFormField(
                    initialValue: category.comment,
                    validator: null,
                    onChanged: (v) => category.comment = v,
                    maxLines: 200,
                  )),
                  Spacer(
                    flex: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                    child: Container(
                      width: Get.width,
                      child: FlatButton(
                        color: Colors.grey[400],
                        onPressed: validate,
                        child: Text("提交"),
                      ),
                    ),
                  ),
                ]))));
  }
}

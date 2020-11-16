//import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fms_flutter/config/color.dart';
import 'package:fms_flutter/components/expansion_tile.dart' as Comp;
import 'package:shared_preferences/shared_preferences.dart';

class MyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MyPageState();
  }
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin {
  static var _color = Color(0xFFFCFCFC);
  static BuildContext _context;
  SharedPreferences _prefs;
  String _avatarUrl = "";
  String _name = "";
  var _isLogin = false;
  List<Widget> _edageList = [];

  void _getInfo() async {
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
    _refreshInfo();
  }

  @override
  void initState() {
    materialColor.forEach((k, v) {
      _edageList.add(this.Edage(k, v, context));
    });
    _getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的'),
        centerTitle: true,
      ),
      body: new Container(
          color: Color(0xFFF0F0F0),
          child: ListView(
            children: <Widget>[_line()],
          )),
    );
  }

  void _refreshInfo() {
    setState(() {
      _isLogin = _prefs.getBool("isLogin") ?? false;
      _avatarUrl = _prefs.getString("avatar_url") ?? "";
      _name = _prefs.getString("name") ?? "";
    });
  }

  Widget _line() {
    return new Container(
      margin: EdgeInsets.only(top: 15.0),
      color: _color,
      child: new Column(
        children: <Widget>[
          new ListTile(
            title: new Text('点个star', style: new TextStyle(fontSize: 18.0)),
            trailing: new Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey,
            ),
            onTap: () {
              //launch("https://github.com/fujianlian/GankFlutter");
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Divider(height: 0.0),
          ),
          new ListTile(
            title: new Text('提Issue/PR', style: new TextStyle(fontSize: 18.0)),
            trailing: new Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey,
            ),
            onTap: () {
              //launch("https://github.com/fujianlian/GankFlutter/issues");
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Divider(height: 0.0),
          ),
          new ListTile(
            title: new Text('关于', style: new TextStyle(fontSize: 18.0)),
            trailing: new Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey,
            ),
            onTap: () {
              // Navigator.push(_context,
              //     new MaterialPageRoute(builder: (context) {
              //   return new AboutPage();
              // }));
            },
          ),
          Container(
              color: Color(0xFFF7F7F7), padding: EdgeInsets.only(top: 15.0)),
          Comp.ExpansionTile(
            headerBackgroundColor: Colors.white,
            title: Row(
              children: <Widget>[
                Text('选择主题', style: new TextStyle(fontSize: 18.0)),
                Container(
                  margin: EdgeInsets.fromLTRB(5, 3, 0, 0),
                  child: Container(
                    color: Color(
                        0), //Color(materialColor[Store.value<ConfigModel>(context).theme]),
                    height: 18,
                    width: 18,
                  ),
                )
              ],
            ),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 5,
                  children: _edageList,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget Edage(name, color, context) {
    return GestureDetector(
      onTap: () {
        //Store.value<ConfigModel>(context).setTheme(name);
      },
      child: Container(
        color: Color(color),
        height: 30,
        width: 30,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

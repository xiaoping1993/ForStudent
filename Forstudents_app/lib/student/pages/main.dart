import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:forstudents_app/student/pages/home.dart';
import 'package:forstudents_app/student/pages/sign.dart';
import 'package:forstudents_app/student/pages/me.dart';

class StudentMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _StudentMainState();
  }
}

class _StudentMainState extends State<StudentMain> {
  final appBarTitles = ['主页', '签到', '我的'];
  final tabTextStyleSelected = new TextStyle(color: const Color(0xff63ca6c));
  final tabTextStyleNormal = new TextStyle(color: const Color(0xff969696));
  var tabImages;
  var _body;
  var pages;
  int _tabIndex = 0;
  Image getTabImage(path) {
    //path:images/sign_normal.png
    return new Image.asset(path, width: 20.0, height: 20.0);
  }

  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }

  TextStyle getTabTextStyle(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabTextStyleSelected;
    }
    return tabTextStyleNormal;
  }

  Text getTabTitle(int curIndex) {
    return new Text(appBarTitles[curIndex], style: getTabTextStyle(curIndex));
  }

  @override
  void initState() {
    super.initState();
    pages = <Widget>[new StudentHome(), new StudentSign(), new StudentMe()];
    if (tabImages == null) {
      tabImages = [
        [
          getTabImage('images/home_normal.png'),
          getTabImage('images/home_actived.png')
        ],
        [
          getTabImage('images/sign_normal.png'),
          getTabImage('images/sign_actived.png')
        ],
        [
          getTabImage('images/me_normal.png'),
          getTabImage('images/me_actived.png')
        ]
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    _body = new IndexedStack(
      children: pages,
      index: _tabIndex,
    );
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("助学通-学生", style: new TextStyle(color: Colors.white)),
          iconTheme: new IconThemeData(color: Colors.white),
        ),
        body: _body,
        bottomNavigationBar: CupertinoTabBar(
            items: <BottomNavigationBarItem>[
              new BottomNavigationBarItem(
                  icon: getTabIcon(0), title: getTabTitle(0)),
              new BottomNavigationBarItem(
                  icon: getTabIcon(1), title: getTabTitle(1)),
              new BottomNavigationBarItem(
                  icon: getTabIcon(2), title: getTabTitle(2)),
            ],
            currentIndex: _tabIndex,
            onTap: (index) {
              setState(() {
                _tabIndex = index;
              });
            }));
  }
}

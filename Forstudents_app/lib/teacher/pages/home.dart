import 'package:flutter/material.dart';
import 'package:forstudents_app/util/DataUtils.dart';
import 'package:forstudents_app/model/DutyInfo.dart';
import 'package:forstudents_app/model/GradeInfo.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TeacherHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _TeacherHomeState();
  }
}

class _TeacherHomeState extends State<TeacherHome> {
  var value;
  List<DropdownMenuItem> dropdownMenuItems=getListInit();
  String ObjectToString(DutyInfo dutyInfo){
    String result = "";
    GradeInfo gradeInfo = dutyInfo.dutyGradeInfo;
    result+=gradeInfo.gradeXueyuan+gradeInfo.gradeZhuanye+gradeInfo.gradeNianji+gradeInfo.gradeBanji+dutyInfo.dutyCourseName+"\n";
    return result;
  }
  static List<DropdownMenuItem> getListInit(){
    List<DropdownMenuItem> items=new List();
    DropdownMenuItem dropdownMenuItem=new DropdownMenuItem(
        child:new Text("a"),
        value: 1
    );
    items.add(dropdownMenuItem);

  }
  @override
  void initState(){
    super.initState();
    List<DropdownMenuItem> items=new List();
    DataUtils.getDutys().then((List<DutyInfo> dutys){
      for(var i=0;i<dutys.length;i++){
        DropdownMenuItem dropdownMenuItem=new DropdownMenuItem(
          child:new Text(ObjectToString(dutys[i])),
          value: dutys[i].dutyGradeInfo
        );
        items.add(dropdownMenuItem);
      }
      setState(() {
        dropdownMenuItems = items;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          new Center(
            child: new DropdownButton(
              items: dropdownMenuItems,
              hint:new Text('选择你的角色'),//当没有默认值的时候可以设置的提示
              value: value,//下拉菜单选择完之后显示给用户的值
              onChanged: (T){//下拉菜单item点击之后的回调
                setState(() {
                  value=T;
                });
              },
              elevation: 24,//设置阴影的高度
              style: new TextStyle(//设置文本框里面文字的样式
                  color: Colors.black
              ),
//              isDense: false,//减少按钮的高度。默认情况下，此按钮的高度与其菜单项的高度相同。如果isDense为true，则按钮的高度减少约一半。 这个当按钮嵌入添加的容器中时，非常有用
              iconSize: 50.0,//设置三角标icon的大小
            ),
          ),
          Expanded(
            child: Center(
              child: MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: new Text('获得此班级二维码'),
                onPressed: () {
                  if(value==null){//没有值
                    //提示失败
                    return showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('提示'),
                          content: SingleChildScrollView(
                            child: Text("没有二维码信息，请重新选择"),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('关闭'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }else{
                    showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return Scaffold(
                            appBar: new AppBar(
                              title: new Text("班级二维码", style: new TextStyle(color: Colors.white)),
                              iconTheme: new IconThemeData(color: Colors.white),
                              ),
                            body:Column(
                              children: <Widget>[
                                MaterialButton(
                                    color: Colors.blue,
                                    textColor: Colors.white,
                                    child: new Text('变更班级二维码'),
                                    onPressed: () {
                                      return showDialog<void>(
                                        context: context,
                                        barrierDismissible: false, // user must tap button!
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('提示'),
                                            content: SingleChildScrollView(
                                              child: Text("二维码更新成功"),
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text('关闭'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }),
                                Expanded(
                                 child: Center(
                                   child: QrImage(
                                       data: value.gradeQRCode,
                                       size: 200.0,
                                       onError: (ex) {
                                         print("[QR] ERROR - $ex");
                                       }),
                                 )
                                ),
                              ],
                            )
                          );
                        });
                  }
                }
              ),
            ),
          )
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:forstudents_app/api/Api.dart';
import 'package:forstudents_app/util/NetUtils.dart';
import 'dart:convert' show json;
import 'package:forstudents_app/teacher/pages/main.dart';
import 'package:forstudents_app/util/DataUtils.dart';
import 'package:forstudents_app/model/DutyInfo.dart';
import 'package:forstudents_app/model/GradeInfo.dart';

class TeacherLogin extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _TeacherLoginState();
  }
}

class _TeacherLoginState extends State<TeacherLogin> {
  var leftRightPadding = 30.0;
  var topBottomPadding = 4.0;
  var textTips = new TextStyle(fontSize: 16.0, color: Colors.black);
  var hintTips = new TextStyle(fontSize: 15.0, color: Colors.black26);
  List<String> dutyInfos=List();
  var _userPassController = new TextEditingController();
  var _userNameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("教师登录", style: new TextStyle(color: Colors.white)),
          iconTheme: new IconThemeData(color: Colors.white),
        ),
        body: new Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.fromLTRB(
                  leftRightPadding, 50.0, leftRightPadding, topBottomPadding),
              child: new TextField(
                style: hintTips,
                controller: _userNameController,
                decoration: new InputDecoration(hintText: "请输入用户名"),
                obscureText: false,
              ),
            ),
            new Padding(
              padding: new EdgeInsets.fromLTRB(
                  leftRightPadding, 30.0, leftRightPadding, topBottomPadding),
              child: new TextField(
                style: hintTips,
                controller: _userPassController,
                decoration: new InputDecoration(hintText: "请输入用户密码"),
                obscureText: true,
              ),
            ),
            new Container(
              width: 360.0,
              margin: new EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 0.0),
              padding: new EdgeInsets.fromLTRB(leftRightPadding,
                  topBottomPadding, leftRightPadding, topBottomPadding),
              child: new Card(
                color: Colors.green,
                elevation: 6.0,
                child: new FlatButton(
                    onPressed: () {
                      //将用户名密码传到服务器
                      Map<String, String> params = new Map();
                      params['username'] = _userNameController.text;
                      params['password'] = _userPassController.text;
                      NetUtils.get(Api.checkTeacherAccount, params: params).then((data) {
                        //处理返回结果
                        var map = json.decode(data);
                        if(map["code"]==0){
                          //将教师信息存起来
                          String teacherId=map["data"]["teacherId"];
                          String teacherName=map["data"]["teacherName"];
                          String teacherGender=map["data"]["teacherGender"];
                          var teacherInfo = {"teacherId":teacherId,"teacherName":teacherName,"teacherGender":int.parse(teacherGender)};
                          DataUtils.saveTeacherInfo(teacherInfo);
                          //将教师职责存起来
                          Map<String,String> params = new Map();
                          params["teacherId"]=teacherId;
                          NetUtils.post(Api.getTeacherDutys,params: params).then((data){
                            var map = json.decode(data);
                            if(map["code"]==0){
                              List res = map["data"];
                              for(var i=0;i<res.length;i++){
                                var aa = res[i];
                                GradeInfo gradeInfo = GradeInfo();
                                gradeInfo.gradeId=aa["gradeId"];
                                gradeInfo.gradeXueyuan = aa["gradeXueyuan"];
                                gradeInfo.gradeZhuanye = aa["gradeZhuanye"];
                                gradeInfo.gradeNianji = aa["gradeNianji"];
                                gradeInfo.gradeBanji = aa["gradeBanji"];
                                gradeInfo.gradeQRCode = aa["gradeQRCode"];
                                DutyInfo dutyInfo=  DutyInfo();
                                dutyInfo.dutyId = aa["id"];
                                dutyInfo.dutyCourseName=aa["courseName"];
                                dutyInfo.dutyGradeInfo=gradeInfo;
                                dutyInfos.add(json.encode(dutyInfo.toJson()));
                                DataUtils.saveDutys(dutyInfos);
                                //跳转下个页面
                                Navigator.of(context).push(
                                    new MaterialPageRoute(builder: (context){
                                      //返回教师主页面
                                      return new TeacherMain();
                                    })
                                );
                              }
                            }else{
                              //弹窗提示
                              return showDialog<void>(
                                context: context,
                                barrierDismissible: false, // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('提示'),
                                    content: SingleChildScrollView(
                                      child: Text(map["msg"]),
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
                            }
                          });
                        }else{
                          //弹窗提示
                          return showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('提示'),
                                content: SingleChildScrollView(
                                  child: Text(map["msg"]),
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
                        }
                      });
                    },
                    color: Colors.blue,
                    child: new Padding(
                      padding: new EdgeInsets.all(10.0),
                      child: new Text(
                        '马上登录',
                        style:
                        new TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    )),
              ),
            )
          ],
        ));
  }
}
import 'package:flutter/material.dart';
import 'package:forstudents_app/util/NetUtils.dart';
import 'package:forstudents_app/util/DataUtils.dart';
import 'package:forstudents_app/model/TeacherInfo.dart';
import 'package:forstudents_app/api/Api.dart';
import 'package:forstudents_app/model/DutyInfo.dart';
import 'package:forstudents_app/model/GradeInfo.dart';
import 'dart:convert' show json;

class TeacherMe extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _TeacherMeState();
  }
}

class _TeacherMeState extends State<TeacherMe> {
  List<DutyInfo> dutyInfos=List();
  TeacherInfo teacherInfo = TeacherInfo(teacherId:"1",teacherName:"小明",teacherGender:1);
  var _oldPassController = new TextEditingController();
  var _newPassController = new TextEditingController();
  @override
  void initState(){
    super.initState();
    //获得教师责任信息
    DataUtils.getTeacherInfo().then((TeacherInfo teacher){
      String teacherId = teacher.teacherId;
      Map<String,String> params = new Map();
      params["teacherId"]=teacherId;
      DataUtils.getDutys().then((List<DutyInfo> dutys){
        setState(() {
          dutyInfos=dutys;
          teacherInfo=teacher;
        });
      });
    });
  }
  String _getJiaoseByDutys(List list){
    String result="";
    for(var i=0;i<list.length;i++){
      DutyInfo dutyInfo = list[i];
      GradeInfo gradeInfo = dutyInfo.dutyGradeInfo;
      result+=gradeInfo.gradeXueyuan+gradeInfo.gradeZhuanye+gradeInfo.gradeNianji+gradeInfo.gradeBanji+dutyInfo.dutyCourseName+"\n";
    }
    return result;
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body:Column(
          children: <Widget>[
            Expanded(
              child:Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Align(
                      alignment: Alignment.center,
                      child:Text("姓名："+teacherInfo.teacherName,style: TextStyle(fontSize: 20,)),
                    ),
                  ),
                  Text("性别："+(teacherInfo.teacherGender==1?"男":"女"),style: TextStyle(fontSize: 20),),
                  Text("角色：",style: TextStyle(fontSize: 20),),
                  Text(_getJiaoseByDutys(dutyInfos),style: TextStyle(fontSize: 20),),
                ],
              )
            ),
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: new Text('修改密码'),
              onPressed: () {
                _newPassController.clear();
                _oldPassController.clear();
                //修改密码
                showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return SimpleDialog(
                        title: const Text('修改密码'),
                        children: <Widget>[
                          SimpleDialogOption(
                            child: new TextField(
                              controller: _oldPassController,
                              decoration: new InputDecoration(hintText: "请输入旧密码"),
                              obscureText: true,
                            ),
                          ),
                          SimpleDialogOption(
                            child: new TextField(
                              controller: _newPassController,
                              decoration: new InputDecoration(hintText: "请输入新密码"),
                              obscureText: true,
                            ),
                          ),
                          SimpleDialogOption(
                              child: ButtonBar(children: <Widget>[
                                new MaterialButton(
                                  color: Colors.blue,
                                  textColor: Colors.white,
                                  child: new Text('确认'),
                                  onPressed: () {
                                    //修改密码
                                    Map<String,String> params = new Map();
                                    params["teacherId"]=teacherInfo.teacherId;
                                    params["oldPassword"]=_oldPassController.text;
                                    params["newPassword"]=_newPassController.text;
                                    NetUtils.post(Api.modifyTeacherPassword,params: params).then((data){
                                      var map = json.decode(data);
                                      if(map["code"]==0){
                                        //提示成功
                                        //弹窗提示
                                        return showDialog<void>(
                                          context: context,
                                          barrierDismissible: false, // user must tap button!
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('提示'),
                                              content: SingleChildScrollView(
                                                child: Text('密码修改成功'),
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
                                        //提示失败
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
                                ),
                                new MaterialButton(
                                  color: Colors.blue,
                                  textColor: Colors.white,
                                  child: new Text('取消'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],)
                          ),
                        ],
                      );
                    }
                );
              },
            ),
          ],
        )
    );
  }
}
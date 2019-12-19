import 'package:flutter/material.dart';
import 'package:forstudents_app/util/NetUtils.dart';
import 'package:forstudents_app/api/Api.dart';
import 'package:forstudents_app/model/StudentInfo.dart';
import 'package:forstudents_app/util/DataUtils.dart';
import 'dart:convert' show json;
class StudentMe extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new _StudentMeState();
  }

}
class _StudentMeState extends State<StudentMe> {
  String startTime;
  String endTime;
  String StudentChidao="0";
  String StudentKuangke="0";
  String StudentQingjia="0";
  String StudentXh="";
  String StudentName="";
  String StudentGender="";
  String StudentGradeId="";
  String StudentNianji="";
  String StudentBanji="";
  String StudentXueyuan="";
  String StudentZhuanye="";
  var _oldPassController = new TextEditingController();
  var _newPassController = new TextEditingController();
  /**
   * 获得学生班级信息
   */
  _getStudentGardeInfo(String gradeId,int type) async{
    Map<String, String> params = new Map();
    params['gradeId'] = gradeId;
    Map<String,String> result = new Map();
    String data = await NetUtils.get(Api.getGradeInfo,params: params);
    //处理返回结果
    var map = json.decode(data);
    if(map["code"]==0){
      //将学生班级专业信息存起来
      DataUtils.saveGardeInfo(map["data"]);
      result['StudentNianji']=map["data"]["gradeNianji"];
      result['StudentBanji']=map["data"]["gradeBanji"];
      result['StudentXueyuan']=map["data"]["gradeXueyuan"];
      result['StudentZhuanye']=map["data"]["gradeZhuanye"];
      if(type==1){
        setState(() {
          StudentNianji=result['StudentNianji'];
          StudentBanji=result['StudentBanji'];
          StudentXueyuan=result['StudentXueyuan'];
          StudentZhuanye=result['StudentZhuanye'];
        });
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
    return result;
  }

  /**
   * 获得学生指定时间段的签到信息
   */
  _getStudentSignInInfo(String studentXh,String gradeId,String startTime,String endTime,int type) async{
    Map<String, String> params = new Map();
    params['studentXh'] = studentXh;
    params['gradeId']=gradeId;
    params['startTime']=startTime;
    params['endTime']=endTime;
    Map<String,String> result = new Map();
    String data = await NetUtils.post(Api.getSignInStatesByTimes,params: params);
    var map = json.decode(data);
    if(map["code"]==0){
      result['StudentChidao']=map["data"]["chidao"].toString();
      result['StudentKuangke']=map["data"]["kuangke"].toString();
      result['StudentQingjia']=map["data"]["qingjia"].toString();
      if(type==1){//更新state
        setState(() {
          StudentChidao=result['StudentChidao'];
          StudentKuangke=result['StudentKuangke'];
          StudentQingjia=result['StudentQingjia'];
        });
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
    return result;
  }
  _showDataPicker(var type) async {
    Locale myLocale = Localizations.localeOf(context);
    var picker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2016),
        lastDate: DateTime(2020),
        locale: myLocale);
    if(type==1){
      String startTime1 = picker.toString().substring(0,10);
      if(startTime1.compareTo(endTime)==-1){
        startTime=startTime1;
      }else{
        //弹窗提示
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('提示'),
              content: SingleChildScrollView(
                child: Text("开始时间不能大于结束时间！"),
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
    }else{
      String endTime1 = picker.toString().substring(0,10);
      if(endTime1.compareTo(startTime)==1){
        endTime=endTime1;
      }else{
        //弹窗提示
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('提示'),
              content: SingleChildScrollView(
                child: Text("开始时间不能大于结束时间！"),
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
    }
    setState(() {
      startTime = startTime;
      endTime=endTime;
    });
  }
  @override
  void initState(){
    super.initState();
    //初始化开始时间，结束时间为本周一和周五
    var now = DateTime.now();
    var weekDay = now.weekday;
    startTime = now.add(Duration(days: -weekDay+1)).toString().substring(0,10);
    endTime = now.add(Duration(days: 7-weekDay)).toString().substring(0,10);
    //获得学生基本信息
    DataUtils.getStudentInfo().then((StudentInfo studentInfo){
      StudentName = studentInfo.studentName;
      StudentGender=(studentInfo.studentGender==1?"男":"女");
      StudentXh = studentInfo.studentXh;
      StudentGradeId=studentInfo.gradeId.toString();
      _getStudentGardeInfo(StudentGradeId,2).then((data){
        StudentNianji=data['StudentNianji'];
        StudentBanji=data['StudentBanji'];
        StudentXueyuan=data['StudentXueyuan'];
        StudentZhuanye=data['StudentZhuanye'];
        _getStudentSignInInfo(StudentXh,StudentGradeId,startTime,endTime,2).then((map){
          StudentChidao=map['StudentChidao'];
          StudentKuangke=map['StudentKuangke'];
          StudentQingjia=map['StudentQingjia'];
          setState(() {
            startTime=startTime;
            endTime=endTime;
            StudentGradeId=StudentGradeId;
            StudentXh=StudentXh;
            StudentGender=StudentGender;
            StudentName=StudentName;
            StudentNianji=StudentNianji;
            StudentBanji=StudentBanji;
            StudentXueyuan=StudentXueyuan;
            StudentZhuanye=StudentZhuanye;
            StudentChidao=StudentChidao;
            StudentKuangke=StudentKuangke;
            StudentQingjia=StudentQingjia;
          });
        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('时间段：'),
              RaisedButton(
                child: Text(startTime),
                onPressed: () => _showDataPicker(1),
              ),
              Text("~"),
              RaisedButton(
                child: Text(endTime),
                onPressed: () => _showDataPicker(2),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: RaisedButton(
                  child: Text("查询"),
                  onPressed: ()=>_getStudentSignInInfo(StudentXh,StudentGradeId,startTime,endTime,1),
                ),
              )
            ],),
          Center(
              child: Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text("      迟到       ",style: TextStyle(fontSize: 25),),
                      Text(StudentChidao)
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text("      旷课      ",style: TextStyle(fontSize: 25)),
                      Text(StudentKuangke)
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text("      请假      ",style: TextStyle(fontSize: 25)),
                      Text(StudentQingjia)
                    ],
                  )
                ],
              ),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Column(
                children: <Widget>[
                  Text("学号："+StudentXh,style: TextStyle(fontSize: 25),),
                  Text("姓名："+StudentName,style: TextStyle(fontSize: 25),),
                  Text("性别："+StudentGender,style: TextStyle(fontSize: 25),),
                  Text("年级："+StudentNianji,style: TextStyle(fontSize: 25),),
                  Text("班级："+StudentBanji,style: TextStyle(fontSize: 25),),
                  Text("学院："+StudentXueyuan,style: TextStyle(fontSize: 25),),
                  Text("专业："+StudentZhuanye,style: TextStyle(fontSize: 25),),
                ],
              ),
            ),
          ),
          Center(
          child: Column(children: <Widget>[
            new MaterialButton(
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
                                params["studentXh"]=StudentXh;
                                params["oldPassword"]=_oldPassController.text;
                                params["newPassword"]=_newPassController.text;
                                NetUtils.post(Api.modifyStudentPassword,params: params).then((data){
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
          ],))
        ],
      )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:forstudents_app/util/NetUtils.dart';
import 'package:forstudents_app/api/Api.dart';
import 'package:forstudents_app/util/DataUtils.dart';
import 'package:forstudents_app/model/StudentInfo.dart';
import 'dart:convert' show json;

class StudentHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _StudentHomeState();
  }
}

class _StudentHomeState extends State<StudentHome> {
  //坐标时间表
  Map<int,int> scourseTimes = {
    480:1,
    530:2,
    580:3,
    630:4,
    840:5,
    890:6,
    940:7
  };
  Map<String,dynamic> courseSchedules = {
    "1,1":"数学","1,2":"数学","1,3":"数学","1,4":"数学","1,5":"数学","1,6":"数学","1,7":"数学",
    "2,1":"数学","2,2":"数学","2,3":"数学","2,4":"数学","2,5":"数学","2,6":"数学","2,7":"数学",
    "3,1":"数学","3,2":"数学","3,3":"数学","3,4":"数学","3,5":"数学","3,6":"数学","3,7":"数学",
    "4,1":"数学","4,2":"数学","4,3":"数学","4,4":"数学","4,5":"数学","4,6":"数学","4,7":"数学",
    "5,1":"数学","5,2":"数学","5,3":"数学","5,4":"数学","5,5":"数学","5,6":"数学","5,7":"数学",
  };
  //状态0：正常，状态1：迟到，状态2：旷课，状态3：请假，状态4：还未上课
  Map<String,dynamic> signInState = {
    "1,1":4,"1,2":4,"1,3":4,"1,4":4,"1,5":4,"1,6":4,"1,7":4,
    "2,1":4,"2,2":4,"2,3":4,"2,4":4,"2,5":4,"2,6":4,"2,7":4,
    "3,1":4,"3,2":4,"3,3":4,"3,4":4,"3,5":4,"3,6":4,"3,7":4,
    "4,1":4,"4,2":4,"4,3":4,"4,4":4,"4,5":4,"4,6":4,"4,7":4,
    "5,1":4,"5,2":4,"5,3":4,"5,4":4,"5,5":4,"5,6":4,"5,7":4,
  };
  //状态颜色
  final signInColor = [
    TextStyle(color:Colors.blue),
    TextStyle(color:Colors.amber),
    TextStyle(color:Colors.red),
    TextStyle(color:Colors.green),
    TextStyle(color:Colors.black),
    ];

  /**
   * 初始化已经上课的状态信息
   */
  Map<String,dynamic> getHasTakenClasses(String date){
    Map<String,dynamic> map = new Map<String,dynamic>();
    DateTime time = DateTime.parse(date);
    int postionX = time.weekday;
    int minutes = time.hour*60+time.minute;
    int postionY = 0;
    List<int> keys = scourseTimes.keys.toList();
    for(int i=keys.length-1;i>=0;i--){
      if(minutes>keys[i]){
        postionY=scourseTimes[keys[i]];
        break;
      }
    }
    if(postionX>5){postionX=5;}
    var fullMap = postionX-1;
    //先填充3天之前的所有map集合
    for(int x=1;x<=fullMap;x++){
      for(int y=1;y<=7;y++){
        map[x.toString()+","+y.toString()]=0;
      }
    }
    //填充之后的map集合
    for(int y=1;y<=postionY;y++){
      map[postionX.toString()+","+y.toString()]=0;
    }
    return map;
  }
  @override
  void initState(){
    super.initState();
    Map<String, String> params = new Map();
    DataUtils.getStudentInfo().then((StudentInfo studentInfo){
      //获得课程表信息
      params["gradeId"]=studentInfo.gradeId.toString();
      NetUtils.post(Api.getCourseSchedule,params: params).then((data){
        //处理返回结果
        var map = json.decode(data);
        if(map["code"]==0){
          //更新课程表内容
          courseSchedules.addAll(map["data"]);
          //获得签到状态信息
          params.clear();
          params["gradeId"]=studentInfo.gradeId.toString();
          params["studentXh"]=studentInfo.studentXh;
          //print(new DateTime.now().toString());
          params["queryTime"]=new DateTime.now().toString();//new DateTime.now().toString();
          NetUtils.post(Api.getSignInStates,params: params).then((data){
            //处理返回结果
            var map = json.decode(data);
            if(map["code"]==0){
              //更新签到情况
              //将已经上课的部分先替换为状态0
              Map<String,dynamic> haaTakenClassesMap = getHasTakenClasses(params["queryTime"]);
              signInState.addAll(haaTakenClassesMap);
              //替换从服务器上拿到的数据
              signInState.addAll(map["data"]);
              setState(() {
                signInState=signInState;
                courseSchedules=courseSchedules;
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
    });

  }
  //课程表控件
  Widget _timeSheet() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Center(
              child: Text("课程表",style: TextStyle(fontSize: 20),),
            ),
            decoration: BoxDecoration(
              //border: new Border.all(width: 1.0, color: Colors.black),
              border: new Border(
                  top: BorderSide(color: Colors.black, width: 1.0),
                  left: BorderSide(color: Colors.black, width: 1.0),
                  right: BorderSide(color: Colors.black, width: 1.0)),
            ),
          ),
          Row(children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: 83,
                  width: 28,
                  child: Center(
                    child: Text("上午",textAlign: TextAlign.center,),
                  ),
                  decoration: BoxDecoration(
                    //border: new Border.all(width: 1.0, color: Colors.black),
                    border: new Border(
                        top: BorderSide(color: Colors.black, width: 1.0),
                        left: BorderSide(color: Colors.black, width: 1.0)),
                  ),
                ),
                Container(
                  height: 64,
                  width: 28,
                  child: Center(
                    child: Text("下午",textAlign: TextAlign.center,),
                  ),
                  decoration: BoxDecoration(
                    //border: new Border.all(width: 1.0, color: Colors.black),
                    border: new Border(
                      top:  BorderSide(color: Colors.black, width: 1.0),
                        left: BorderSide(color: Colors.black, width: 1.0),
                        bottom: BorderSide(color: Colors.black, width: 1.0)),
                  ),
                )
              ],
            ),
            Expanded(
              child: Table(
                border: new TableBorder.all(width: 1.0, color: Colors.black),
                children: <TableRow>[
                  new TableRow(
                    children: <Widget>[
                      new TableCell(
                        child: new Center(
                          child: new Text(courseSchedules["1,1"],style: signInColor[signInState["1,1"]]),
                        ),
                      ),
                      new TableCell(
                        child: new Center(
                          child: new Text(courseSchedules["2,1"],style: signInColor[signInState["2,1"]]),
                        ),
                      ),
                      new TableCell(
                        child: new Center(
                          child: new Text(courseSchedules["3,1"],style: signInColor[signInState["3,1"]]),
                        ),
                      ),
                      new TableCell(
                        child: new Center(
                          child: new Text(courseSchedules["4,1"],style: signInColor[signInState["4,1"]]),
                        ),
                      ),
                      new TableCell(
                        child: new Center(
                          child: new Text(courseSchedules["5,1"],style: signInColor[signInState["5,1"]]),
                        ),
                      ),
                    ],
                  ),
                  new TableRow(
                    children: <Widget>[
                      new TableCell(
                        child: new Center(
                          child: new Text(courseSchedules["1,2"],style: signInColor[signInState["1,2"]]),
                        ),
                      ),
                      new TableCell(
                        child: new Center(
                          child: new Text(courseSchedules["2,2"],style: signInColor[signInState["2,2"]]),
                        ),
                      ),
                      new TableCell(
                        child: new Center(
                          child: new Text(courseSchedules["3,2"],style: signInColor[signInState["3,2"]]),
                        ),
                      ),
                      new TableCell(
                        child: new Center(
                          child: new Text(courseSchedules["4,2"],style: signInColor[signInState["4,2"]]),
                        ),
                      ),
                      new TableCell(
                        child: new Center(
                          child: new Text(courseSchedules["5,2"],style: signInColor[signInState["5,2"]]),
                        ),
                      ),
                    ],
                  ),
                  new TableRow(
                    children: <Widget>[
                      new TableCell(
                        child: new Center(
                          child: new Text(courseSchedules["1,3"],style: signInColor[signInState["1,3"]]),
                        ),
                      ),
                      new TableCell(
                        child: new Center(
                          child: new Text(courseSchedules["2,3"],style: signInColor[signInState["2,3"]]),
                        ),
                      ),
                      new TableCell(
                        child: new Center(
                          child: new Text(courseSchedules["3,3"],style: signInColor[signInState["3,3"]]),
                        ),
                      ),
                      new TableCell(
                        child: new Center(
                          child: new Text(courseSchedules["4,3"],style: signInColor[signInState["4,3"]]),
                        ),
                      ),
                      new TableCell(
                        child: new Center(
                          child: new Text(courseSchedules["5,3"],style: signInColor[signInState["5,3"]]),
                        ),
                      ),
                    ],
                  ),
                  new TableRow(
                    children: <Widget>[
                      new TableCell(
                        child: new Center(
                          child: new Text(courseSchedules["1,4"],style: signInColor[signInState["1,4"]]),
                        ),
                      ),
                      new TableCell(
                        child: new Center(
                          child: new Text(courseSchedules["2,4"],style: signInColor[signInState["2,4"]]),
                        ),
                      ),
                      new TableCell(
                        child: new Center(
                          child: new Text(courseSchedules["3,4"],style: signInColor[signInState["3,4"]]),
                        ),
                      ),
                      new TableCell(
                        child: new Center(
                          child: new Text(courseSchedules["4,4"],style: signInColor[signInState["4,4"]]),
                        ),
                      ),
                      new TableCell(
                        child: new Center(
                          child: new Text(courseSchedules["5,4"],style: signInColor[signInState["5,4"]]),
                        ),
                      ),
                    ],
                  ),
                  new TableRow(
                    children: <Widget>[
                      new TableCell(
                        child: new Center(
                          child: new Text(courseSchedules["1,5"],style: signInColor[signInState["1,5"]]),
                        ),
                      ),
                      new TableCell(
                        child: new Center(
                          child: new Text(courseSchedules["2,5"],style: signInColor[signInState["2,5"]]),
                        ),
                      ),
                      new TableCell(
                        child: new Center(
                          child: new Text(courseSchedules["3,5"],style: signInColor[signInState["3,5"]]),
                        ),
                      ),
                      new TableCell(
                        child: new Center(
                          child: new Text(courseSchedules["4,5"],style: signInColor[signInState["4,5"]]),
                        ),
                      ),
                      new TableCell(
                        child: new Center(
                          child: new Text(courseSchedules["5,5"],style: signInColor[signInState["5,5"]]),
                        ),
                      ),
                    ],
                  ),
                  new TableRow(
                    children: <Widget>[
                      new TableCell(
                        child: new Center(
                          child: new Text(courseSchedules["1,6"],style: signInColor[signInState["1,6"]]),
                        ),
                      ),
                      new TableCell(
                        child: new Center(
                          child: new Text(courseSchedules["2,6"],style: signInColor[signInState["2,6"]]),
                        ),
                      ),
                      new TableCell(
                        child: new Center(
                          child: new Text(courseSchedules["3,6"],style: signInColor[signInState["3,6"]]),
                        ),
                      ),
                      new TableCell(
                        child: new Center(
                          child: new Text(courseSchedules["4,6"],style: signInColor[signInState["4,6"]]),
                        ),
                      ),
                      new TableCell(
                        child: new Center(
                          child: new Text(courseSchedules["5,6"],style: signInColor[signInState["5,6"]]),
                        ),
                      ),
                    ],
                  ),
                  new TableRow(
                    children: <Widget>[
                      new TableCell(
                        child: new Center(
                          child: new Text(courseSchedules["1,7"],style: signInColor[signInState["1,7"]]),
                        ),
                      ),
                      new TableCell(
                        child: new Center(
                          child: new Text(courseSchedules["2,7"],style: signInColor[signInState["2,7"]]),
                        ),
                      ),
                      new TableCell(
                        child: new Center(
                          child: new Text(courseSchedules["3,7"],style: signInColor[signInState["3,7"]]),
                        ),
                      ),
                      new TableCell(
                        child: new Center(
                          child: new Text(courseSchedules["4,7"],style: signInColor[signInState["4,7"]]),
                        ),
                      ),
                      new TableCell(
                        child: new Center(
                          child: new Text(courseSchedules["5,7"],style: signInColor[signInState["5,7"]]),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ]),

        ],
      ),

      //height: 500,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(70.0),
          child: Center(
              child: Text(
            "本周课程表及签到情况",
            style: TextStyle(fontSize: 25),
          )),
        ),
        _timeSheet(),
        Center(child: Row(children: <Widget>[
          //状态0：正常，状态1：迟到，状态2：旷课，状态3：请假，状态4：还未上课
          //Text("("),
          Column(children: <Widget>[
            Row(children: <Widget>[
              Text("Tip："),
              Text("绿色：正常；",style:signInColor[0]),
              Text("黄色：迟到；",style: signInColor[1],),
              Text("红色：旷课；",style: signInColor[2],),
            ],),
            Row(children: <Widget>[
              Text("绿色：请假；",style: signInColor[3],),
              Text("黑色：未上课",style: signInColor[4],),
            ],)
          ],)
          //Text(")")
        ],))
      ],
    ));
  }
}

import 'package:flutter/material.dart';
import 'student/login.dart';
import 'teacher//login.dart';

void main() {
  runApp(new MaterialApp(title: 'loginBefore', home: new LoginBefore()));
}

class LoginBefore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('助学通'),
        centerTitle: true,
      ),
      body: new Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 230),
        child: Center(
          child: Column(
            children: <Widget>[
              new OutlineButton(
                borderSide:
                    new BorderSide(color: Theme.of(context).primaryColor),
                child: new Text(
                  '教师入口',
                  style: new TextStyle(color: Theme.of(context).primaryColor,fontSize: 25),
                ),
                onPressed: () {
                  //跳转到教师登录页面
                  Navigator.of(context).push(
                    new MaterialPageRoute(builder: (context){
                      //返回教师登录入口
                      return new TeacherLogin();
                    })
                  );
                },
              ),
              new OutlineButton(
                borderSide:
                new BorderSide(color: Theme.of(context).primaryColor),
                child: new Text(
                  '学生入口',
                  style: new TextStyle(color: Theme.of(context).primaryColor,fontSize: 25),
                ),
                onPressed: () {
                  //跳转到学生登录页面
                  Navigator.of(context).push(
                      new MaterialPageRoute(builder: (context){
                        //学生登录入口
                        return new StudentLogin();
                      })
                  );
                },
              ),
            ],
          ),
        ),
      ))
    );
  }
}

import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:forstudents_app/util/NetUtils.dart';
import 'package:forstudents_app/api/Api.dart';
import 'package:forstudents_app/util/DataUtils.dart';
import 'package:forstudents_app/model/StudentInfo.dart';
import 'dart:convert' show json;
class StudentSign extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new _StudentSignState();
  }

}
class _StudentSignState extends State<StudentSign> {
  Future<String> scan() async {
    String barcode="";
    try {
      barcode = await BarcodeScanner.scan();
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        barcode = 'The user did not grant the camera permission!';
      } else {
        barcode = 'Unknown error: $e';
      }
    } on FormatException{
      barcode = 'null (User returned using the "back"-button before scanning anything. Result)';
    } catch (e) {
      barcode = 'Unknown error: $e';
    }
    return barcode;

  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new MaterialButton(
          color: Colors.blue,
          textColor: Colors.white,
          child: new Text('点我签到'),
          onPressed: (){
            scan().then((value){
              //获得课堂对应的二维码后，根据时间给后台发签到情况
              //获得学生，班级信息
              DataUtils.getStudentInfo().then((StudentInfo student){
                Map<String,dynamic> params = new Map();
                params["studentXh"]=student.studentXh;
                params["gradeId"]=student.gradeId;
                params["gradeQRcode"]=value;
                NetUtils.post(Api.seedSignInStatus,params: params).then((data){
                  var map = json.decode(data);
                  if(map["code"]==0){
                    var data = map["data"];
                    return showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('提示'),
                          content: SingleChildScrollView(
                            child: Text(data),
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
              });
            });
          },
        )
      ),
    );
  }
}
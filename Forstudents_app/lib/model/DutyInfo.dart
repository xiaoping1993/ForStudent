import 'package:forstudents_app/model/GradeInfo.dart';
// 责任信息
class DutyInfo {
  int dutyId;
  String dutyCourseName;
  GradeInfo dutyGradeInfo;
  Map toJson(){
    Map map = new Map();
    map["dutyCourseName"] = this.dutyCourseName;
    map["dutyGradeInfo"] = this.dutyGradeInfo.toJson();
    map["dutyId"] = this.dutyId;
    return map;
  }
  DutyInfo MapToObject(Map map){
    DutyInfo dutyInfo = new DutyInfo();
    dutyInfo.dutyId=map["dutyId"];
    dutyInfo.dutyCourseName=map["dutyCourseName"];
    Map dutyGradeInfo = map["dutyGradeInfo"];
    GradeInfo gradeInfo = new GradeInfo();
    dutyInfo.dutyGradeInfo=gradeInfo.MapToObject(dutyGradeInfo);
    return dutyInfo;
  }
  DutyInfo({this.dutyId, this.dutyCourseName, this.dutyGradeInfo});

}
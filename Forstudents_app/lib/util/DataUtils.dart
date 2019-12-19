import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../model/StudentInfo.dart';
import '../model/GradeInfo.dart';
import 'package:forstudents_app/model/TeacherInfo.dart';
import 'package:forstudents_app/model/DutyInfo.dart';
import 'dart:convert' show json;

class DataUtils {
  // 保存教师信息
  static void saveTeacherInfo(Map data) async {
    if (data != null) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      String teacherId = data['teacherId'];
      String teacherName = data['teacherName'];
      int teacherGender = data['teacherGender'];
      await sp.setString("teacherId", teacherId);
      await sp.setString("teacherName", teacherName);
      await sp.setInt("teacherGender", teacherGender);
    }
  }
  // 获得教师信息
  static Future<TeacherInfo> getTeacherInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    TeacherInfo teacherInfo = new TeacherInfo();
    teacherInfo.teacherId = sp.getString("teacherId");
    teacherInfo.teacherName = sp.getString("teacherName");
    teacherInfo.teacherGender = sp.getInt("teacherGender");
    return teacherInfo;
  }
  static void saveDuty(Map data) async{
    if (data != null) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      int dutyId = data["id"];
      String dutyCourseName = data["courseName"];
      GradeInfo dutyGradeInfo = data["dutyGradeInfo"];
      String teacherId = data['teacherId'];
      String teacherName = data['teacherName'];
      int teacherGender = data['teacherGender'];
      await sp.setString("teacherId", teacherId);
      await sp.setString("teacherName", teacherName);
      await sp.setInt("teacherGender", teacherGender);
    }
  }
  // 保存学生信息
  static void saveStudentInfo(Map data) async {
    if (data != null) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      String studentXh = data['studentXh'];
      String studentName = data['studentName'];
      int studentGender = data['studentGender'];
      int studentGradeId = data['gradeId'];
      String gradeQRCode = data['gradeQRCode'];
      await sp.setString("studentXh", studentXh);
      await sp.setString("studentName", studentName);
      await sp.setInt("studentGender", studentGender);
      await sp.setInt("studentGradeId", studentGradeId);
      await sp.setString("gradeQRCode", gradeQRCode);
    }
  }

  // 获取学生信息
  static Future<StudentInfo> getStudentInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    StudentInfo userInfo = new StudentInfo();
    userInfo.studentXh = sp.getString("studentXh");
    userInfo.studentName = sp.getString("studentName");
    userInfo.studentGender = sp.getInt("studentGender");
    userInfo.gradeId = sp.getInt("studentGradeId");
    return userInfo;
  }
  //保存班级专业信息
  static void saveGardeInfo(Map data) async{
    if(data!=null){
      SharedPreferences sp = await SharedPreferences.getInstance();
      int gardeId = data['gradeId'];
      String gradeBanji=data['gradeBanji'];
      String gradeNianji=data['gradeNianji'];
      String gradeXueyuan=data['gradeXueyuan'];
      String gradeZhuanye=data['gradeZhuanye'];
      await sp.setInt("gradeId", gardeId);
      await sp.setString("gradeBanji", gradeBanji);
      await sp.setString("gradeNianji", gradeNianji);
      await sp.setString("gradeXueyuan", gradeXueyuan);
      await sp.setString("gradeZhuanye", gradeZhuanye);
    }
  }
  //获得班级专业信息
  static Future<GradeInfo> getGradeInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    GradeInfo gradeInfo = new GradeInfo();
    gradeInfo.gradeId = sp.getInt("gradeId");
    gradeInfo.gradeBanji = sp.getString("gradeBanji");
    gradeInfo.gradeNianji = sp.getString("gradeNianji");
    gradeInfo.gradeXueyuan = sp.getString("gradeXueyuan");
    gradeInfo.gradeZhuanye = sp.getString("gradeZhuanye");
    gradeInfo.gradeQRCode = sp.getString("gradeQRCode");
    return gradeInfo;
  }
  //保存通过json编码的任意对象
  static void saveDutys(List dutys) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setStringList("dutys", dutys);
  }
  static Future<List<DutyInfo>> getDutys()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<DutyInfo> result=new List();
    List<String> dutys = sp.getStringList("dutys");
    for(var i=0;i<dutys.length;i++){
      DutyInfo dutyInfo = new DutyInfo();
      dutyInfo = dutyInfo.MapToObject(json.decode(dutys[i]));
      result.add(dutyInfo);
    }
    return result;
  }
}
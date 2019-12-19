
// 专业班级信息
class GradeInfo {
  int gradeId;
  String gradeNianji;
  String gradeBanji;
  String gradeXueyuan;
  String gradeZhuanye;
  String gradeQRCode;
  Map toJson(){
    Map map = new Map();
    map["gradeId"] = this.gradeId;
    map["gradeNianji"] = this.gradeNianji;
    map["gradeBanji"] = this.gradeBanji;
    map["gradeXueyuan"] = this.gradeXueyuan;
    map["gradeZhuanye"] = this.gradeZhuanye;
    map["gradeQRCode"] = this.gradeQRCode;
    return map;
  }
  GradeInfo MapToObject(Map map){
    GradeInfo gradeInfo = new GradeInfo();
    gradeInfo.gradeId=map["gradeId"];
    gradeInfo.gradeNianji=map["gradeNianji"];
    gradeInfo.gradeBanji=map["gradeBanji"];
    gradeInfo.gradeXueyuan=map["gradeXueyuan"];
    gradeInfo.gradeZhuanye=map["gradeZhuanye"];
    gradeInfo.gradeQRCode=map["gradeQRCode"];
    return gradeInfo;
  }
  GradeInfo({this.gradeId, this.gradeNianji, this.gradeBanji, this.gradeXueyuan,this.gradeZhuanye,this.gradeQRCode});

}
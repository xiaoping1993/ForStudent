class Api {
  static final String HOST = "http://165.88.123.1:8880";
  //验证学生账户
  static final String checkStudentAccount = HOST+"/ForStudent/Api/checkStudentAccount";
  //验证教师账户
  static final String checkTeacherAccount = HOST+"/ForStudent/Api/checkTeacherAccount";
  //获得课程表
  static final String getCourseSchedule = HOST+"/ForStudent/Api/getCourseSchedule";
  //获得签到状态信息
  static final String getSignInStates = HOST+"/ForStudent/Api/getSignInStates";
  //获得学生所在班级专业信息
  static final String getGradeInfo = HOST+"/ForStudent/Api/getGradeInfoByGradeId";
  //获得学生指定时间段内的签到情况
  static final String getSignInStatesByTimes = HOST+"/ForStudent/Api/getSignInStatesByTimes";
  //修改学生密码
  static final String modifyStudentPassword = HOST+"/ForStudent/Api/modifyStudentPassword";
  //签到
  static final String seedSignInStatus = HOST+"/ForStudent/Api/seedSignInStatus";
  //获得教师角色职责相关信息
  static final String getTeacherDutys = HOST+"/ForStudent/Api/getTeacherDutys";
  //修改教师密码
  static final modifyTeacherPassword = HOST+"/ForStudent/Api/modifyTeacherPassword";
}
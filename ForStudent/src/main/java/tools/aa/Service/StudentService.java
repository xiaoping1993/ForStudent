package tools.aa.Service;

import tools.aa.entity.Result;

public interface StudentService {
	/**
	 * 获得所有的学生信息
	 * @param studentXH
	 * @param studentName
	 * @param studentCollege
	 * @param studentMajor
	 * @param studentGradeClass
	 * @param page
	 * @param limit
	 * @return
	 */
	public Result getAllStudent(String studentXH,String studentName,String studentCollege,String studentMajor,String studentGradeClass,int page,int limit);

	/**
	 * 设置学生的密码
	 * @param studentXH
	 * @param studentPassword
	 * @return
	 * @throws Exception 
	 */
	public Result setPasswordForStudent(String studentXH, String studentPassword) throws Exception;

	/**
	 * 查询学生考勤情况
	 * @param studentXH
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	public Result queryCheck(String studentXH, String startTime, String endTime);

	/**
	 * 验证学生账号是否正确
	 * @param username
	 * @param password
	 * @return
	 */
	public Result checkStudentAccount(String username, String password);
	/**
	 * 获得特定gradeId班级的课程表信息
	 * @param gradeId
	 * @return
	 */
	public Result getCourseSchedule(String gradeId);

	/**
	 * 获得学生在这个班级的签到情况
	 * @param gradeId
	 * @param studentXh
	 * @param queryTime
	 * @return
	 */
	public Result getSignInStates(String gradeId, String studentXh, String queryTime);

	/**
	 * 获得班级专业信息
	 * @param gradeId
	 * @return
	 */
	public Result getGradeInfoByGradeId(String gradeId);

	/**
	 * 获得指点时间段内学生的签到情况
	 * @param studentXh
	 * @param gradeId
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	public Result getSignInStatesByTimes(String studentXh, String gradeId, String startTime, String endTime);

	/**
	 * 修改密码
	 * @param studentXh
	 * @param oldPassword
	 * @param newPassword
	 * @return
	 */
	public Result modifyStudentPassword(String studentXh, String oldPassword, String newPassword);

	/**
	 * 学生签到逻辑处理
	 * @param studentXh
	 * @param gradeId
	 * @param gradeQRcode
	 * @return
	 */
	public Result seedSignInStatus(String studentXh, String gradeId, String gradeQRcode);
}

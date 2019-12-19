package tools.aa.Service;

import tools.aa.entity.Result;

public interface TeacherService {
	/**
	 * 获得所有的教师信息
	 * @param teacherXH
	 * @param teacherName
	 * @param teacherCollege
	 * @param teacherMajor
	 * @param teacherGradeClass
	 * @param page
	 * @param limit
	 * @return
	 */
	public Result getAllTeacher(String teacherId,String teacherName,String teacherCourse,int page,int limit);

	/**
	 * 设置教师的密码
	 * @param teacherXH
	 * @param teacherPassword
	 * @return
	 * @throws Exception 
	 */
	public Result setPasswordForTeacher(String teacherId, String teacherPassword) throws Exception;

	/**
	 * 验证移动端教师密码是否正确
	 * @param username
	 * @param password
	 * @return
	 */
	public Result checkTeacherAccount(String username, String password);
	/**
	 * 获得教师职责信息
	 * @param teacherId
	 * @return
	 */
	public Result getTeacherDutys(String teacherId);

	/**
	 * 修改教师密码
	 * @param teacherId
	 * @param oldPassword
	 * @param newPassword
	 * @return
	 */
	public Result modifyTeacherPassword(String teacherId, String oldPassword, String newPassword);
}

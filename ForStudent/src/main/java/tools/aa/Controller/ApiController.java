package tools.aa.Controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import tools.aa.Enum.ResultEnum;
import tools.aa.Service.StudentService;
import tools.aa.Service.TeacherService;
import tools.aa.Utils.PasswordUtil;
import tools.aa.Utils.ResultUtil;
import tools.aa.entity.Result;

/**
 * 给app提供接口服务的
 * @author wangj01052
 *
 */
@RestController
@RequestMapping("/Api")
public class ApiController {
	protected final static Logger log = LoggerFactory.getLogger(ApiController.class);
	@Autowired
	private StudentService studentService;
	@Autowired
	private TeacherService teacherService;
	/**
	 * 验证用户密码是否正确
	 * @param username
	 * @param password
	 * @return
	 */
	@RequestMapping("checkStudentAccount")
	public Result checkStudentAccount(String username,String password){
		try {
			password = PasswordUtil.encrypt(username, password, PasswordUtil.getStaticSalt());
			Result result = studentService.checkStudentAccount(username,password);
			return result;
		} catch (Exception e) {
			log.error(e.toString());
			return ResultUtil.error(ResultEnum.UNKONW_ERROR.getCode(), ResultEnum.UNKONW_ERROR.getMsg());
		}
	}
	/**
	 * 验证教师密码是否正确
	 * @param username
	 * @param password
	 * @return
	 */
	@RequestMapping("checkTeacherAccount")
	public Result checkTeacherAccount(String username,String password){
		try {
			password = PasswordUtil.encrypt(username, password, PasswordUtil.getStaticSalt());
			Result result = teacherService.checkTeacherAccount(username,password);
			return result;
		} catch (Exception e) {
			log.error(e.toString());
			return ResultUtil.error(ResultEnum.UNKONW_ERROR.getCode(), ResultEnum.UNKONW_ERROR.getMsg());
		}
	}
	/**
	 * 获得课程表信息
	 * @param gradeId
	 * @return
	 */
	@RequestMapping("getCourseSchedule")
	public Result getCourseSchedule(String gradeId,String tokenAccess){
		try {
			Result result = studentService.getCourseSchedule(gradeId); 
			return result;
		} catch (Exception e) {
			log.error(e.toString());
			return ResultUtil.error(ResultEnum.UNKONW_ERROR.getCode(), ResultEnum.UNKONW_ERROR.getMsg());
		}
	}
	@RequestMapping("getSignInStates")
	public Result getSignInStates(String gradeId,String studentXh,String queryTime){
		try {
			Result result = studentService.getSignInStates(gradeId,studentXh,queryTime); 
			return result;
		} catch (Exception e) {
			log.error(e.toString());
			return ResultUtil.error(ResultEnum.UNKONW_ERROR.getCode(), ResultEnum.UNKONW_ERROR.getMsg());
		}
	}
	@RequestMapping("getGradeInfoByGradeId")
	public Result getGradeInfoByGradeId(String gradeId){
		try {
			Result result = studentService.getGradeInfoByGradeId(gradeId);
			return result;
		} catch (Exception e) {
			log.error(e.toString());
			return ResultUtil.error(ResultEnum.UNKONW_ERROR.getCode(), ResultEnum.UNKONW_ERROR.getMsg());
		}
	}
	@RequestMapping("getSignInStatesByTimes")
	public Result getSignInStatesByTimes(String studentXh,String gradeId,String startTime,String endTime){
		try {
			Result result = studentService.getSignInStatesByTimes(studentXh,gradeId,startTime,endTime);
			return result;
		} catch (Exception e) {
			log.error(e.toString());
			return ResultUtil.error(ResultEnum.UNKONW_ERROR.getCode(), ResultEnum.UNKONW_ERROR.getMsg());
		}
	}
	@RequestMapping("modifyStudentPassword")
	public Result modifyStudentPassword(String studentXh,String oldPassword,String newPassword){
		try {
			oldPassword = PasswordUtil.encrypt(studentXh, oldPassword, PasswordUtil.getStaticSalt());
			newPassword = PasswordUtil.encrypt(studentXh, newPassword, PasswordUtil.getStaticSalt());
			Result result = studentService.modifyStudentPassword(studentXh,oldPassword,newPassword);
			return result;
		} catch (Exception e) {
			log.error(e.toString());
			return ResultUtil.error(ResultEnum.UNKONW_ERROR.getCode(), ResultEnum.UNKONW_ERROR.getMsg());
		}
	}
	@RequestMapping("seedSignInStatus")
	@Transactional(rollbackFor = Exception.class)
	public Result seedSignInStatus(String studentXh,String gradeId,String gradeQRcode){
		try {
			Result result = studentService.seedSignInStatus(studentXh,gradeId,gradeQRcode);
			return result;
		} catch (Exception e) {
			log.error(e.toString());
			return ResultUtil.error(ResultEnum.UNKONW_ERROR.getCode(), ResultEnum.UNKONW_ERROR.getMsg());
		}
	}
	@RequestMapping("getTeacherDutys")
	public Result getTeacherDutys(String teacherId){
		try {
			Result result = teacherService.getTeacherDutys(teacherId);
			return result;
		} catch (Exception e) {
			log.error(e.toString());
			return ResultUtil.error(ResultEnum.UNKONW_ERROR.getCode(), ResultEnum.UNKONW_ERROR.getMsg());
		}
	}
	@RequestMapping("modifyTeacherPassword")
	public Result modifyTeacherPassword(String teacherId,String oldPassword,String newPassword){
		try {
			oldPassword = PasswordUtil.encrypt(teacherId, oldPassword, PasswordUtil.getStaticSalt());
			newPassword = PasswordUtil.encrypt(teacherId, newPassword, PasswordUtil.getStaticSalt());
			Result result = teacherService.modifyTeacherPassword(teacherId,oldPassword,newPassword);
			return result;
		} catch (Exception e) {
			log.error(e.toString());
			return ResultUtil.error(ResultEnum.UNKONW_ERROR.getCode(), ResultEnum.UNKONW_ERROR.getMsg());
		}
	}
}

package tools.aa.Controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import tools.aa.Enum.ResultEnum;
import tools.aa.Service.TeacherService;
import tools.aa.Utils.PasswordUtil;
import tools.aa.Utils.ResultUtil;
import tools.aa.entity.Result;

@RestController
@RequestMapping("/Teacher")
public class TeacherController {
	protected final static Logger log = LoggerFactory.getLogger(TeacherController.class);
	@Autowired
	private TeacherService teacherService;
	@RequestMapping(params="getAllTeacher")
	public Result getAllTeacher(String teacherId,String teacherName,String teacherTeacher,String teacherCourse,int page,int limit){
		try {
			Result result= teacherService.getAllTeacher(teacherId,teacherName,teacherCourse,page,limit);
			return result;
		} catch (Exception e) {
			log.error(e.toString());
			return ResultUtil.error(ResultEnum.UNKONW_ERROR.getCode(), ResultEnum.UNKONW_ERROR.getMsg());
		}
	}
	@RequestMapping(params="setPasswordForTeacher")
	public Result setPasswordForTeacher(String teacherXH,String teacherPassword){
		try {
			//密码加密
			teacherPassword = PasswordUtil.encrypt(teacherXH, teacherPassword, PasswordUtil.getStaticSalt());
			Result result = teacherService.setPasswordForTeacher(teacherXH,teacherPassword);
			return ResultUtil.success(result);
		} catch (Exception e) {
			log.error(e.toString());
			return ResultUtil.error(ResultEnum.UNKONW_ERROR.getCode(), ResultEnum.UNKONW_ERROR.getMsg());
		}
	}
}

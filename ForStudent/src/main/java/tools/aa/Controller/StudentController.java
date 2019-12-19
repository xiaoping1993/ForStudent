package tools.aa.Controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import tools.aa.Enum.ResultEnum;
import tools.aa.Service.StudentService;
import tools.aa.Utils.PasswordUtil;
import tools.aa.Utils.ResultUtil;
import tools.aa.entity.Result;


@RestController
@RequestMapping("/Student")
public class StudentController {
	protected final static Logger log = LoggerFactory.getLogger(StudentController.class);
	@Autowired
	private StudentService studentService;
	@RequestMapping(params="getAllStudent")
	public Result getAllStudent(String studentXH,String studentName,String studentTeacher,String studentCollege,String studentMajor,String studentGradeClass,int page,int limit){
		try {
			Result result= studentService.getAllStudent(studentXH,studentName,studentCollege,studentMajor,studentGradeClass,page,limit);
			return result;
		} catch (Exception e) {
			log.error(e.toString());
			return ResultUtil.error(ResultEnum.UNKONW_ERROR.getCode(), ResultEnum.UNKONW_ERROR.getMsg());
		}
	}
	@RequestMapping(params="setPasswordForStudent")
	public Result setPasswordForStudent(String studentXH,String studentPassword){
		try {
			//密码加密
			studentPassword = PasswordUtil.encrypt(studentXH, studentPassword, PasswordUtil.getStaticSalt());
			Result result = studentService.setPasswordForStudent(studentXH,studentPassword);
			return ResultUtil.success(result);
		} catch (Exception e) {
			log.error(e.toString());
			return ResultUtil.error(ResultEnum.UNKONW_ERROR.getCode(), ResultEnum.UNKONW_ERROR.getMsg());
		}
	}
	@RequestMapping(params="queryCheck")
	public Result queryCheck(String studentXH,String startTime,String endTime){
		try {
			Result result = studentService.queryCheck(studentXH,startTime,endTime);
			return ResultUtil.success(result);
		} catch (Exception e) {
			log.error(e.toString());
			return ResultUtil.error(ResultEnum.UNKONW_ERROR.getCode(), ResultEnum.UNKONW_ERROR.getMsg());
		}
	}
}

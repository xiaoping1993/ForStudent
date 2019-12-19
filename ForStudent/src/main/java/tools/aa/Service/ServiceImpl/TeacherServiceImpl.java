package tools.aa.Service.ServiceImpl;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;

import tools.aa.Enum.ResultEnum;
import tools.aa.Mapper.TeacherMapper;
import tools.aa.Service.TeacherService;
import tools.aa.Utils.ResultUtil;
import tools.aa.entity.Result;
@Service
public class TeacherServiceImpl implements TeacherService {
	@Autowired
	private TeacherMapper teacherMapper;
	@Override
	public Result getAllTeacher(String teacherXH, String teacherName, String teacherCourse,int page,int limit) {
		int start = (page-1)*limit;
		int end = start+limit-1;
		List<Map<String,Object>> result = teacherMapper.getAllTeacher(teacherXH, teacherName, teacherCourse,start,end);
		return ResultUtil.success(result);
	}
	@Override
	public Result setPasswordForTeacher(String teacherId, String teacherPassword) throws Exception {
		Integer count = teacherMapper.setPasswordForTeacher(teacherId,teacherPassword);
		if(count==1){
			return ResultUtil.success();
		}else{
			throw new Exception("更新"+teacherId+"的密码为失败！");
		}
	}
	@Override
	public Result checkTeacherAccount(String username, String password) {
		Map<String,Object> result = teacherMapper.getTeacherPassword(username);
		if(result==null){
			return ResultUtil.error(ResultEnum.HasNoUser.getCode(),ResultEnum.HasNoUser.getMsg());
		}else{
			Object passwordO = result.get("password");
			if(passwordO==null){
				return ResultUtil.error(ResultEnum.AccountHasNotInit.getCode(),ResultEnum.AccountHasNotInit.getMsg());
			}else{
				if(password.equals(passwordO.toString())){
					JSONObject jo = new JSONObject();
					jo.putAll(result);
					return ResultUtil.success(jo);
				}else{
					return ResultUtil.error(ResultEnum.PasswordFail.getCode(), ResultEnum.PasswordFail.getMsg());
				}
			}
		}
	}
	@Override
	public Result getTeacherDutys(String teacherId) {
		List<Map<String,Object>> result = teacherMapper.getTeacherDutys(teacherId);
		return ResultUtil.success(result);
	}
	@Override
	public Result modifyTeacherPassword(String teacherId, String oldPassword, String newPassword) {
		Map<String,Object> result = teacherMapper.getTeacherPassword(teacherId);
		if(result==null){
			return ResultUtil.error(ResultEnum.HasNoUser.getCode(),ResultEnum.HasNoUser.getMsg());
		}else{
			Object passwordO = result.get("password");
			if(passwordO==null){
				return ResultUtil.error(ResultEnum.AccountHasNotInit.getCode(),ResultEnum.AccountHasNotInit.getMsg());
			}else{
				if(oldPassword.equals(passwordO.toString())){
					//将新密码更新
					int sum = teacherMapper.modifyStudentPassword(teacherId,newPassword);
					if(sum>0){
						return ResultUtil.success();	
					}else{
						return ResultUtil.error(ResultEnum.ModifyPasswordFail.getCode(), ResultEnum.ModifyPasswordFail.getMsg());
					}
					
				}else{
					return ResultUtil.error(ResultEnum.oldPasswordFail.getCode(), ResultEnum.oldPasswordFail.getMsg());
				}
			}
		}
	}

}

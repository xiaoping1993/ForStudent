package tools.aa.Service.ServiceImpl;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.alibaba.fastjson.JSONObject;
import tools.aa.Enum.ResultEnum;
import tools.aa.Enum.ScheduleTimeEnum;
import tools.aa.Mapper.StudentMapper;
import tools.aa.Service.StudentService;
import tools.aa.Utils.ResultUtil;
import tools.aa.Utils.WeekUtils;
import tools.aa.entity.Result;
@Service
public class StudentServiceImpl implements StudentService {
	@Autowired
	private StudentMapper studentMapper;
	SimpleDateFormat sdf = new SimpleDateFormat("EEEE");
	SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
	@Override
	public Result getAllStudent(String studentXH, String studentName, String studentCollege,
			String studentMajor, String studentGradeClass,int page,int limit) {
		int start = (page-1)*limit;
		int end = start+limit-1;
		List<Map<String,Object>> result = studentMapper.getAllStudent(studentXH, studentName, studentCollege,
				studentMajor, studentGradeClass,start,end);
		return ResultUtil.success(result);
	}
	@Override
	public Result setPasswordForStudent(String studentXH, String studentPassword) throws Exception {
		Integer count = studentMapper.setPasswordForStudent(studentXH,studentPassword);
		if(count==1){
			return ResultUtil.success();
		}else{
			throw new Exception("更新"+studentXH+"的密码为失败！");
		}
	}
	@Override
	public Result queryCheck(String studentXH, String startTime, String endTime) {
		JSONObject result = new JSONObject();
		Integer overdueSum = studentMapper.queryCheckForOverdueSum(studentXH, startTime, endTime);
		Integer RquestLeaveSum = studentMapper.queryCheckForRquestLeaveSum(studentXH, startTime, endTime);
		Integer TruantSum = studentMapper.queryCheckForTruantSum(studentXH, startTime, endTime);
		result.put("overdueSum", overdueSum);
		result.put("RquestLeaveSum", RquestLeaveSum);
		result.put("TruantSum", TruantSum);
		return ResultUtil.success(result);
	}
	@Override
	public Result checkStudentAccount(String username, String password) {
		Map<String,Object> result = studentMapper.getStudentPassword(username);
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
	public Result getCourseSchedule(String gradeId) {
		JSONObject jo = new JSONObject();
		List<Map<String,Object>> result = studentMapper.getCourseSchedule(gradeId);
		for (int i = 0; i < result.size(); i++) {
			String position = result.get(i).get("position").toString();
			String courseName = result.get(i).get("courseName").toString();
			jo.put(position, courseName);
		}
		return ResultUtil.success(jo);
	}
	@Override
	public Result getSignInStates(String gradeId, String studentXh, String queryTime) {
		JSONObject jo = new JSONObject();
		String startTime = WeekUtils.getMonday(queryTime);
		List<Map<String,Object>> result = studentMapper.getSignInStates(gradeId,studentXh,startTime);
		for (int i = 0; i < result.size(); i++) {
			String position = result.get(i).get("position").toString();
			Integer status = Integer.parseInt(result.get(i).get("status").toString());
			jo.put(position, status);
		}
		return ResultUtil.success(jo);
	}
	@Override
	public Result getGradeInfoByGradeId(String gradeId) {
		Map<String,Object> result = studentMapper.getGradeInfoByGradeId(gradeId);
		if(result==null){
			return ResultUtil.error(ResultEnum.FAILADDATA.getCode(), ResultEnum.FAILADDATA.getMsg());
		}else{
			return ResultUtil.success(result);
		}
	}
	@Override
	public Result getSignInStatesByTimes(String studentXh, String gradeId, String startTime, String endTime) {
		JSONObject result = new JSONObject();
		int chidao=0;
		int kuangke=0;
		int qingjia=0;
		chidao= studentMapper.getSignInStatesByTimes(studentXh, gradeId,startTime,endTime,1);
		kuangke = studentMapper.getSignInStatesByTimes(studentXh, gradeId,startTime,endTime,2);
		qingjia = studentMapper.getSignInStatesByTimes(studentXh, gradeId,startTime,endTime,3);
		result.put("chidao", chidao);
		result.put("kuangke", kuangke);
		result.put("qingjia", qingjia);
		return ResultUtil.success(result);
	}
	@Override
	public Result modifyStudentPassword(String studentXh, String oldPassword, String newPassword) {
		Map<String,Object> result = studentMapper.getStudentPassword(studentXh);
		if(result==null){
			return ResultUtil.error(ResultEnum.HasNoUser.getCode(),ResultEnum.HasNoUser.getMsg());
		}else{
			Object passwordO = result.get("password");
			if(passwordO==null){
				return ResultUtil.error(ResultEnum.AccountHasNotInit.getCode(),ResultEnum.AccountHasNotInit.getMsg());
			}else{
				if(oldPassword.equals(passwordO.toString())){
					//将新密码更新
					int sum = studentMapper.modifyStudentPassword(studentXh,newPassword);
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
	@Override
	public Result seedSignInStatus(String studentXh, String gradeId, String gradeQRcode) {
		//验证二维码信息是否正确
		Object gradeQRcode1 = studentMapper.getGradeQRcode(gradeId);
		if(gradeQRcode1==null){
			return ResultUtil.error(ResultEnum.GradeNotExist.getCode(), ResultEnum.GradeNotExist.getMsg());
		}else if(!gradeQRcode.equals(gradeQRcode1)){
			return ResultUtil.error(ResultEnum.QRcodeError.getCode(), ResultEnum.QRcodeError.getMsg());
		}else{//二维码验证通过
			//获得签到对应哪节课
			Date now = new Date();
			Calendar c=Calendar.getInstance();
		    c.setTime(now);
		    int weekday=c.get(Calendar.DAY_OF_WEEK)-1;
		    weekday = weekday==0?7:weekday;
			String time = now.getHours()+":"+now.getMinutes();
			ScheduleTimeEnum ownerTime = ScheduleTimeEnum.SEVEN;
			for (int i = 0; i < ScheduleTimeEnum.values().length; i++) {
				String start = ScheduleTimeEnum.values()[i].getStart();
				String end = ScheduleTimeEnum.values()[i].getEnd();
				if(time.compareTo(end)==-1){//签到在这节课之前,这几课中间
					ownerTime=ScheduleTimeEnum.values()[i];
					break;
				}
			}
			//保存签到状态
			String start = ownerTime.getStart();
			int minStart = Integer.parseInt(start.split(":")[0])*60+Integer.parseInt(start.split(":")[0]);
			int minTime = Integer.parseInt(time.split(":")[0])*60+Integer.parseInt(time.split(":")[0]);
			int a = minStart-minTime;
			String postion = weekday+","+ownerTime.getCount();
			if(a>5){//5min之前签到时间没到
				return ResultUtil.error(ResultEnum.IsNotToSignInTime.getCode(), ResultEnum.IsNotToSignInTime.getMsg());
			}else{
				//签到之前需要先判断是否已签到
				String signInStart = sdf2.format(now)+" "+(minStart-5)/60+":"+(minStart-5)%60;
				String signInEnd = sdf2.format(now)+" "+(minStart+10)/60+":"+(minStart+10)%60;
				String status = "4";//4代表签到成功
				int sum = studentMapper.isSignIn(signInStart,signInEnd,gradeId,studentXh);
				if(sum==0){//未签到
					if(a>=0){//签到成功
						status = "4";
					}else if(a>-10){//签到迟到
						status = "1";
					}else{
						//先判断学生是否已请假
						int flag = studentMapper.isQingjiaStatus(studentXh,signInEnd);
						if(flag==0){//请假
							status="3";
						}else{//旷课
							status="2";
						}
					}
					//签到信息写入数据库
					int count = studentMapper.insertCheckingIn(gradeId,studentXh,status,postion,sdf1.format(now));
					if(count!=1){
						return ResultUtil.error(ResultEnum.InsertDataFail.getCode(), ResultEnum.InsertDataFail.getMsg());
					}else{
						String result = "签到成功";
						switch (status) {
						case "1":
							result = "迟到";
							break;
						case "2":
							result = "旷课";
							break;
						case "3":
							result = "请假";
							break;
						case "4":
							result = "签到成功";
							break;
						default:
							break;
						}
						return ResultUtil.success(status);
					}
				}else{//已签到
					return ResultUtil.error(ResultEnum.HasSignIn.getCode(), ResultEnum.HasSignIn.getMsg());
				}
			}
		}
	}
}

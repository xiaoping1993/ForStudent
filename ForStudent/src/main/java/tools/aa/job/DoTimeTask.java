package tools.aa.job;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import tools.aa.Enum.ScheduleTimeEnum;
import tools.aa.Mapper.StudentMapper;

/**
 * 定时任务
 * @author wangjiping
 *
 */
@Component
public class DoTimeTask {
	private final Logger log = LoggerFactory.getLogger(DoTimeTask.class);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	@Autowired
	private StudentMapper studentMapper;
	/**
	 * 每天7节课上课后的40min后执行，找到所有没有做处理的剩余学生，判断学生状态，存入数据库
	 * 主要处理
	 */
	@Scheduled(cron="0 40 08 * * ?")//第一节开始后40min
	@Transactional(rollbackFor = Exception.class)//默认只对RuntimeException起作用
	public void doOtherStudentSignInForOne(){
		try {
			String aa = ScheduleTimeEnum.ONE.getEnd().split(":")[0];
			//获得在这个时间段开始前5min到结束，期间所有点击了签到的学生学号集合
			Date now  = new Date();
			String start = ScheduleTimeEnum.ONE.getStart();
			String end = ScheduleTimeEnum.ONE.getEnd();
			int y = ScheduleTimeEnum.ONE.getCount();
			String startFormat = sdf.format(now)+" "+convertFromSecondToString(convertFromStringToSecond(start)-5);
			String endFormat = sdf.format(now)+" "+end;
			List<Map<String,Object>> result =  studentMapper.getOtherStudents(startFormat, endFormat);
			Calendar c=Calendar.getInstance();
		    c.setTime(now);
		    int weekday=c.get(Calendar.DAY_OF_WEEK)-1;
		    weekday = weekday==0?7:weekday;
			String postion = weekday+","+y;
			for (Map<String, Object> map : result) {
				String gradeId = map.get("gradeId").toString();
				String studentXh = map.get("studentXh").toString();
				//判断是否状态是请假
				//先判断学生是否已请假
				int flag = studentMapper.isQingjiaStatus(studentXh,endFormat);
				if(flag!=0){//3
					studentMapper.insertCheckingIn(gradeId,studentXh,"3",postion,sdf1.format(now));
				}else{//2
					studentMapper.insertCheckingIn(gradeId,studentXh,"2",postion,sdf1.format(now));
				}
			}
		} catch (Exception e) {
			log.error(e.toString());
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();//如果updata2()抛了异常,updata()会回滚,不影响事物正常执行
		}
	}
	@Scheduled(cron="0 40 09 * * ?")//第二节开始后40min
	@Transactional(rollbackFor = Exception.class)//默认只对RuntimeException起作用
	public void doOtherStudentSignInForTwo(){
		try {
			//获得在这个时间段开始前5min到结束，期间所有点击了签到的学生学号集合
			Date now  = new Date();
			String start = ScheduleTimeEnum.TWO.getStart();
			String end = ScheduleTimeEnum.TWO.getEnd();
			int y = ScheduleTimeEnum.TWO.getCount();
			String startFormat = sdf.format(now)+" "+convertFromSecondToString(convertFromStringToSecond(start)-5);
			String endFormat = sdf.format(now)+" "+end;
			List<Map<String,Object>> result =  studentMapper.getOtherStudents(startFormat, endFormat);
			Calendar c=Calendar.getInstance();
		    c.setTime(now);
		    int weekday=c.get(Calendar.DAY_OF_WEEK)-1;
		    weekday = weekday==0?7:weekday;
			String postion = weekday+","+y;
			for (Map<String, Object> map : result) {
				String gradeId = map.get("gradeId").toString();
				String studentXh = map.get("studentXh").toString();
				//判断是否状态是请假
				//先判断学生是否已请假
				int flag = studentMapper.isQingjiaStatus(studentXh,endFormat);
				if(flag!=0){//3
					studentMapper.insertCheckingIn(gradeId,studentXh,"3",postion,sdf1.format(now));
				}else{//2
					studentMapper.insertCheckingIn(gradeId,studentXh,"2",postion,sdf1.format(now));
				}
			}
		} catch (Exception e) {
			log.error(e.toString());
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();//如果updata2()抛了异常,updata()会回滚,不影响事物正常执行
		}
	}
	@Scheduled(cron="0 40 10 * * ?")//第三节开始后40min
	@Transactional(rollbackFor = Exception.class)//默认只对RuntimeException起作用
	public void doOtherStudentSignInForThree(){
		try {
			//获得在这个时间段开始前5min到结束，期间所有点击了签到的学生学号集合
			Date now  = new Date();
			String start = ScheduleTimeEnum.THREE.getStart();
			String end = ScheduleTimeEnum.THREE.getEnd();
			int y = ScheduleTimeEnum.THREE.getCount();
			String startFormat = sdf.format(now)+" "+convertFromSecondToString(convertFromStringToSecond(start)-5);
			String endFormat = sdf.format(now)+" "+end;
			List<Map<String,Object>> result =  studentMapper.getOtherStudents(startFormat, endFormat);
			Calendar c=Calendar.getInstance();
		    c.setTime(now);
		    int weekday=c.get(Calendar.DAY_OF_WEEK)-1;
		    weekday = weekday==0?7:weekday;
			String postion = weekday+","+y;
			for (Map<String, Object> map : result) {
				String gradeId = map.get("gradeId").toString();
				String studentXh = map.get("studentXh").toString();
				//判断是否状态是请假
				//先判断学生是否已请假
				int flag = studentMapper.isQingjiaStatus(studentXh,endFormat);
				if(flag!=0){//3
					studentMapper.insertCheckingIn(gradeId,studentXh,"3",postion,sdf1.format(now));
				}else{//2
					studentMapper.insertCheckingIn(gradeId,studentXh,"2",postion,sdf1.format(now));
				}
			}
		} catch (Exception e) {
			log.error(e.toString());
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();//如果updata2()抛了异常,updata()会回滚,不影响事物正常执行
		}
	}
	@Scheduled(cron="0 40 11 * * ?")//第四节开始后40min
	@Transactional(rollbackFor = Exception.class)//默认只对RuntimeException起作用
	public void doOtherStudentSignInForFour(){
		try {
			//获得在这个时间段开始前5min到结束，期间所有点击了签到的学生学号集合
			Date now  = new Date();
			String start = ScheduleTimeEnum.FOUR.getStart();
			String end = ScheduleTimeEnum.FOUR.getEnd();
			int y = ScheduleTimeEnum.FOUR.getCount();
			String startFormat = sdf.format(now)+" "+convertFromSecondToString(convertFromStringToSecond(start)-5);
			String endFormat = sdf.format(now)+" "+end;
			List<Map<String,Object>> result =  studentMapper.getOtherStudents(startFormat, endFormat);
			Calendar c=Calendar.getInstance();
		    c.setTime(now);
		    int weekday=c.get(Calendar.DAY_OF_WEEK)-1;
		    weekday = weekday==0?7:weekday;
			String postion = weekday+","+y;
			for (Map<String, Object> map : result) {
				String gradeId = map.get("gradeId").toString();
				String studentXh = map.get("studentXh").toString();
				//判断是否状态是请假
				//先判断学生是否已请假
				int flag = studentMapper.isQingjiaStatus(studentXh,endFormat);
				if(flag!=0){//3
					studentMapper.insertCheckingIn(gradeId,studentXh,"3",postion,sdf1.format(now));
				}else{//2
					studentMapper.insertCheckingIn(gradeId,studentXh,"2",postion,sdf1.format(now));
				}
			}
		} catch (Exception e) {
			log.error(e.toString());
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();//如果updata2()抛了异常,updata()会回滚,不影响事物正常执行
		}
	}
	@Scheduled(cron="0 40 14 * * ?")//第五节开始后40min
	@Transactional(rollbackFor = Exception.class)//默认只对RuntimeException起作用
	public void doOtherStudentSignInForFive(){
		try {
			//获得在这个时间段开始前5min到结束，期间所有点击了签到的学生学号集合
			Date now  = new Date();
			String start = ScheduleTimeEnum.FIVE.getStart();
			String end = ScheduleTimeEnum.FIVE.getEnd();
			int y = ScheduleTimeEnum.FIVE.getCount();
			String startFormat = sdf.format(now)+" "+convertFromSecondToString(convertFromStringToSecond(start)-5);
			String endFormat = sdf.format(now)+" "+end;
			List<Map<String,Object>> result =  studentMapper.getOtherStudents(startFormat, endFormat);
			Calendar c=Calendar.getInstance();
		    c.setTime(now);
		    int weekday=c.get(Calendar.DAY_OF_WEEK)-1;
		    weekday = weekday==0?7:weekday;
			String postion = weekday+","+y;
			for (Map<String, Object> map : result) {
				String gradeId = map.get("gradeId").toString();
				String studentXh = map.get("studentXh").toString();
				//判断是否状态是请假
				//先判断学生是否已请假
				int flag = studentMapper.isQingjiaStatus(studentXh,endFormat);
				if(flag!=0){//3
					studentMapper.insertCheckingIn(gradeId,studentXh,"3",postion,sdf1.format(now));
				}else{//2
					studentMapper.insertCheckingIn(gradeId,studentXh,"2",postion,sdf1.format(now));
				}
			}
		} catch (Exception e) {
			log.error(e.toString());
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();//如果updata2()抛了异常,updata()会回滚,不影响事物正常执行
		}
	}
	@Scheduled(cron="0 40 15 * * ?")//第六节开始后40min
	@Transactional(rollbackFor = Exception.class)//默认只对RuntimeException起作用
	public void doOtherStudentSignInForSix(){
		try {
			//获得在这个时间段开始前5min到结束，期间所有点击了签到的学生学号集合
			Date now  = new Date();
			String start = ScheduleTimeEnum.SIX.getStart();
			String end = ScheduleTimeEnum.SIX.getEnd();
			int y = ScheduleTimeEnum.SIX.getCount();
			String startFormat = sdf.format(now)+" "+convertFromSecondToString(convertFromStringToSecond(start)-5);
			String endFormat = sdf.format(now)+" "+end;
			List<Map<String,Object>> result =  studentMapper.getOtherStudents(startFormat, endFormat);
			Calendar c=Calendar.getInstance();
		    c.setTime(now);
		    int weekday=c.get(Calendar.DAY_OF_WEEK)-1;
		    weekday = weekday==0?7:weekday;
			String postion = weekday+","+y;
			for (Map<String, Object> map : result) {
				String gradeId = map.get("gradeId").toString();
				String studentXh = map.get("studentXh").toString();
				//判断是否状态是请假
				//先判断学生是否已请假
				int flag = studentMapper.isQingjiaStatus(studentXh,endFormat);
				if(flag!=0){//3
					studentMapper.insertCheckingIn(gradeId,studentXh,"3",postion,sdf1.format(now));
				}else{//2
					studentMapper.insertCheckingIn(gradeId,studentXh,"2",postion,sdf1.format(now));
				}
			}
		} catch (Exception e) {
			log.error(e.toString());
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();//如果updata2()抛了异常,updata()会回滚,不影响事物正常执行
		}
	}
	@Scheduled(cron="0 40 16 * * ?")//第一节开始后40min
	@Transactional(rollbackFor = Exception.class)//默认只对RuntimeException起作用
	public void doOtherStudentSignInForSeven(){
		try {
			//获得在这个时间段开始前5min到结束，期间所有点击了签到的学生学号集合
			Date now  = new Date();
			String start = ScheduleTimeEnum.SEVEN.getStart();
			String end = ScheduleTimeEnum.SEVEN.getEnd();
			int y = ScheduleTimeEnum.SEVEN.getCount();
			String startFormat = sdf.format(now)+" "+convertFromSecondToString(convertFromStringToSecond(start)-5);
			String endFormat = sdf.format(now)+" "+end;
			List<Map<String,Object>> result =  studentMapper.getOtherStudents(startFormat, endFormat);
			Calendar c=Calendar.getInstance();
		    c.setTime(now);
		    int weekday=c.get(Calendar.DAY_OF_WEEK)-1;
		    weekday = weekday==0?7:weekday;
			String postion = weekday+","+y;
			for (Map<String, Object> map : result) {
				String gradeId = map.get("gradeId").toString();
				String studentXh = map.get("studentXh").toString();
				//判断是否状态是请假
				//先判断学生是否已请假
				int flag = studentMapper.isQingjiaStatus(studentXh,endFormat);
				if(flag!=0){//3
					studentMapper.insertCheckingIn(gradeId,studentXh,"3",postion,sdf1.format(now));
				}else{//2
					studentMapper.insertCheckingIn(gradeId,studentXh,"2",postion,sdf1.format(now));
				}
			}
		} catch (Exception e) {
			log.error(e.toString());
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();//如果updata2()抛了异常,updata()会回滚,不影响事物正常执行
		}
	}

	@Scheduled(cron="0 0 1 * * ?")//在每天凌晨1点，将昨天签到成功学生记录删除，到这个时间点，这个信息已经没有用，留着占内存
	public void doStudentSignInOverTime(){
		try {
			studentMapper.deleteStudentForOverTime();
		} catch (Exception e) {
			log.error(e.toString());
		}
	}
	public static int convertFromStringToSecond(String minSecond){
		String[] minSecondS = minSecond.split(":");
		return Integer.parseInt(minSecondS[0])*60+Integer.parseInt(minSecondS[1]);
	}
	public static String convertFromSecondToString(int minSecondString){
		String minSecond = minSecondString/60+":"+minSecondString%60;
		return minSecond;
	}
}

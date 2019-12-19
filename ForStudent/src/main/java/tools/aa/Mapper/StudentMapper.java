package tools.aa.Mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface StudentMapper {
	@Select("<script>"
			+ "select studentXH,studentName,studentGender,(gradeBanji+gradeNianji) as studentGradeClass,gradeXueyuan as studentCollege,gradeZhuanye as studentMajor from (select row_number() over(order by studentXH) n,studentXH,studentName,studentGender,b.gradeBanji,b.gradeNianji,b.gradeXueyuan,b.gradeZhuanye from students a left join grades b on a.gradeId=b.gradeId) a "
			+ "where n&gt;=${start} and n&lt;=${end} "
			+ "<if test='studentXH!=null and !\"\".equals(studentXH.trim())'>"
			+ " and studentXH=#{studentXH} "
			+ "</if>"
			+ "<if test='studentName!=null and !\"\".equals(studentName.trim())'>"
			+ " and studentName=#{studentName} "
			+ "</if>"
			+ "<if test='studentCollege!=null and !\"\".equals(studentCollege.trim())'>"
			+ " and gradeXueyuan=#{studentCollege} "
			+ "</if>"
			+ "<if test='studentMajor!=null and !\"\".equals(studentMajor.trim())'>"
			+ " and gradeZhuanye=#{studentMajor} "
			+ "</if>"
			+ "<if test='studentGradeClass!=null and !\"\".equals(studentGradeClass.trim())'>"
			+ " and gradeBanji+gradeNianji=#{studentGradeClass} "
			+ "</if>"
			+ "</script>")
	List<Map<String, Object>> getAllStudent(@Param("studentXH")String studentXH, @Param("studentName")String studentName, @Param("studentCollege")String studentCollege,
			@Param("studentMajor")String studentMajor, @Param("studentGradeClass")String studentGradeClass, @Param("start")int start, @Param("end")int end);

	@Update("update students set password = #{password} where studentXH=#{studentXH}")
	Integer setPasswordForStudent(@Param("studentXH")String studentXH, @Param("password")String studentPassword);

	@Select("select count(1) as overdueSum from checkingIn where studentXH=#{studentXH} and status = 1 and time between #{startTime} and #{endTime}")
	Integer queryCheckForOverdueSum(@Param("studentXH")String studentXH, @Param("startTime")String startTime, @Param("endTime")String endTime);
	@Select("select count(1) as RquestLeaveSum from checkingIn where studentXH=#{studentXH} and status = 3 and time between #{startTime} and #{endTime}")
	Integer queryCheckForRquestLeaveSum(@Param("studentXH")String studentXH, @Param("startTime")String startTime, @Param("endTime")String endTime);
	@Select("select count(1) as TruantSum from checkingIn where studentXH=#{studentXH} and status = 2 and time between #{startTime} and #{endTime}")
	Integer queryCheckForTruantSum(@Param("studentXH")String studentXH, @Param("startTime")String startTime, @Param("endTime")String endTime);
	@Select("select top(1) studentXh,studentName,studentGender,gradeId,password from students where studentXh=#{username}")
	Map<String,Object> getStudentPassword(@Param("username")String username);
	@Select("select courseName,(cast(locationX as varchar)+','+cast(locationY as varchar)) as position from courseSchedule a left join courses b on a.courseId=b.courseId where flag=1 and gradeId=${gradeId}")
	List<Map<String, Object>> getCourseSchedule(@Param("gradeId")String gradeId);
	@Select("select position,status from checkingIn where studentXh=${studentXh} and gradeId=${gradeId} and time>#{startTime}")
	List<Map<String, Object>> getSignInStates(@Param("gradeId")String gradeId, @Param("studentXh")String studentXh, @Param("startTime")String startTime);
	@Select("select top(1)* from grades where gradeId = #{gradeId}")
	Map<String, Object> getGradeInfoByGradeId(@Param("gradeId")String gradeId);
	@Select("select count(1) from checkingIn where studentXh=#{studentXh} and gradeId=#{gradeId} and time>#{startTime} and time<#{endTime} and status=${status}")
	Integer getSignInStatesByTimes(@Param("studentXh")String studentXh, @Param("gradeId")String gradeId, @Param("startTime")String startTime, @Param("endTime")String endTime,@Param("status")int status);
	@Update("update students set password=#{newPassword} where studentXh=#{studentXh}")
	int modifyStudentPassword(@Param("studentXh")String studentXh, @Param("newPassword")String newPassword);
	@Select("select gradeQRcode from grades where gradeId=#{gradeId}")
	String getGradeQRcode(@Param("gradeId")String gradeId);
	@Insert("insert checkingIn(gradeId,studentXh,status,time,position) values(#{gradeId},#{studentXh},#{status},#{time},#{postion})")
	int insertCheckingIn(@Param("gradeId")String gradeId, @Param("studentXh")String studentXh,@Param("status")String status,@Param("postion") String postion, @Param("time")String now);
	@Select("select count(1) from checkingIn where gradeId = #{gradeId} and studentXh=#{studentXh} and (time between #{signInStart} and #{signInEnd})")
	int isSignIn(@Param("signInStart")String signInStart, @Param("signInEnd")String signInEnd, @Param("gradeId")String gradeId, @Param("studentXh")String studentXh);
	@Select("select count(1) from Qingjia where studentXh = #{studentXh} and #{signInEnd} between qingjiaStartTime and qingjiaEndTime")
	int isQingjiaStatus(@Param("studentXh")String studentXh, @Param("signInEnd")String signInEnd);
	@Select("select gradeId,studentXh from students where studentXh not in (select distinct(studentXh) from checkingIn where time between #{start} and #{end})")
	List<Map<String,Object>> getOtherStudents(@Param("start")String start,@Param("end")String end);
	@Delete("delete from checkingIn where status=4")
	int deleteStudentForOverTime();
}

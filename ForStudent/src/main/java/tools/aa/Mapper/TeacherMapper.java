package tools.aa.Mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface TeacherMapper {
	@Select("<script>"
			+ "select f.teacherId,teacherGender,teacherName,teacherDuty from (select row_number() over(order by teacherId) n,teacherId,teacherDuty=stuff((select ','+(gradeXueyuan+gradeZhuanye+gradeBanji+gradeNianji+courseName) from teacherDuty a left join courses b on a.courseId=b.courseId left join grades c on a.gradeId=c.gradeId where teacherId=d.teacherId for xml path('')),1,1,'')from teacherDuty d group by teacherId) f left join teachers e on f.teacherId=e.teacherId "
			+ "where n&gt;=${start} and n&lt;=${end} "
			+ "<if test='teacherId!=null and !\"\".equals(teacherId.trim())'>"
			+ " and f.teacherId=#{teacherId} "
			+ "</if>"
			+ "<if test='teacherName!=null and !\"\".equals(teacherName.trim())'>"
			+ " and teacherName=#{teacherName} "
			+ "</if>"
			+ "<if test='teacherCourse!=null and !\"\".equals(teacherCourse.trim())'>"
			+ " and charindex(#{teacherCourse},teacherDuty)&gt;0 "
			+ "</if>"
			+ "</script>")
	List<Map<String, Object>> getAllTeacher(@Param("teacherId")String teacherId, @Param("teacherName")String teacherName, @Param("teacherCourse")String teacherCourse,@Param("start")int start, @Param("end")int end);
	@Update("update teachers set password = #{password} where teacherId=#{teacherId}")
	Integer setPasswordForTeacher(@Param("teacherId")String teacherId, @Param("password")String teacherPassword);
	@Select("select top(1) teacherId,teacherName,teacherGender,password from teachers where teacherId=#{username}")
	Map<String,Object> getTeacherPassword(@Param("username")String username);
	@Select("select a.id,courseName,c.gradeId,gradeXueyuan,gradeZhuanye,gradeNianji,gradeBanji,gradeQRCode from  teacherDuty a left join courses b on a.courseId=b.courseId left join grades c on a.gradeId=c.gradeId where teacherId=#{teacherId} ")
	List<Map<String, Object>> getTeacherDutys(@Param("teacherId")String teacherId);
	@Update("update teachers set password = #{newPassword} where teacherId = #{teacherId}")
	int modifyStudentPassword(@Param("teacherId")String teacherId, @Param("newPassword")String newPassword);
}

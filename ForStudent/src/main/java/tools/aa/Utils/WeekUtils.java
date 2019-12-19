package tools.aa.Utils;

import java.text.SimpleDateFormat;
import java.util.Calendar;
/**
 * Created by on 2017/4/17.
 */
public class WeekUtils {
    private static SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
 
    // 获得当前周- 周一的日期
    public static  String getMonday(String date) {
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");        
        Calendar cal = Calendar.getInstance();
        try {
            cal.setTime(sdf.parse(date));
            // Calendar默认周日为第一天, 所以设置为1
            cal.set(Calendar.DAY_OF_WEEK, 2);
        } catch (Exception e) {
            e.printStackTrace();
        }        
        return sdf.format(cal.getTime());
    }
 
 
    // 获得当前周- 周日  的日期
    public static String getSaturday(String date) {
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");        
        Calendar cal = Calendar.getInstance();
        try {
            cal.setTime(sdf.parse(date));
            // Calendar默认周日为第一天, 所以设置为1
            cal.set(Calendar.DAY_OF_WEEK, 6);
        } catch (Exception e) {
            e.printStackTrace();
        }        
        return sdf.format(cal.getTime());
    }
    // 获得当前月--开始日期
    public static String getMinMonthDate(String date) {
        Calendar calendar = Calendar.getInstance();
        try {
            calendar.setTime(dateFormat.parse(date));
            calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMinimum(Calendar.DAY_OF_MONTH));
            return dateFormat.format(calendar.getTime());
        } catch (java.text.ParseException e) {
            e.printStackTrace();
        }
        return null;
    }
 
    // 获得当前月--结束日期
    public static String getMaxMonthDate(String date){
        Calendar calendar = Calendar.getInstance();
        try {
            calendar.setTime(dateFormat.parse(date));
            calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
            return dateFormat.format(calendar.getTime());
        }  catch (java.text.ParseException e) {
            e.printStackTrace();
        }
        return null;
    }
}

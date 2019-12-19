package tools.aa.Enum;
/**
 * 学校课程时间安排
 * @author wangjiping
 *
 */
public enum ScheduleTimeEnum {
	ONE("08:00", "08:45",1),
	TWO("9:00", "9:45",2),
	THREE("10:00", "10:45",3),
	FOUR("11:00", "11:45",4),
	
	FIVE("14:00", "14:45",5),
	SIX("15:00", "15:45",6),
	SEVEN("16:00", "16:45",7);
    private String start;
    private String end;
    private int count;

    ScheduleTimeEnum(String start, String end,int count) {
        this.start = start;
        this.end = end;
        this.count = count;
    }

    public String getStart() {
        return start;
    }

    public String getEnd() {
        return end;
    }
    public int getCount(){
    	return count;
    }
}

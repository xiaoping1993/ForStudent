package tools.aa.Enum;
/**
 * http请求返回的code对应值
 * @author wangjiping
 *
 */
public enum ResultEnum {
	UNKONW_ERROR(-1, "未知错误"),
    SUCCESS(0, "成功"), 
    FAILDELEDATA(1,"数据删除失败！"), 
    FAILUPDATEDATA(2,"数据更新失败"), 
    FAILADDATA(3,"数据添加失败!"), 
    UpDateFail(4,"数据更新失败"), 
    DeleDateFail(5,"数据删除失败！"), 
    PasswordFail(6,"用户名密码错误"), 
    AccountHasNotInit(7,"账号未初始化，请联系管理员"), 
    HasNoUser(8,"无此用户"), 
    oldPasswordFail(9,"旧密码错误"), 
    ModifyPasswordFail(10,"密码更新失败"), 
    GradeNotExist(10,"不存在此班级"), 
    QRcodeError(11,"这个二维码不对"), 
    IsNotToSignInTime(12,"还没有到签到时间"), 
    InsertDataFail(13,"插入数据失败"), HasSignIn(14,"状态信息已存入，请勿重复签到");
    private Integer code;

    private String msg;

    ResultEnum(Integer code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public Integer getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }
}

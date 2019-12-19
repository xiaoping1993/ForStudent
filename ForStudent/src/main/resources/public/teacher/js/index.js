var WSM = parent.window.WSM;
WSM.teacher = {};
WSM.teacher.init = function(layer,table,form,laydate) {
	WSM.teacher.initTable("#teachertb",table);
};
WSM.teacher.initTable = function($tableId, table) {
	var teacherId = $("#teacherId").val(),
		teacherName = $("#teacherName").val(),
		teacherCourse = $("#teacherCourse").val();
	table.render({
		elem : $tableId,
		height : '400',
		url : '../Teacher.do?getAllTeacher',
		page : true,
		method : 'post',
		where : {
			teacherId : teacherId,
			teacherName : teacherName,
			teacherCourse : teacherCourse
		},
		cols : [[
		    {field : 'teacherId',title : '教师编号',width : 120,sort : true}, 
		    {field : 'teacherName',title : '教师姓名',width : 120,sort : true},
		    {field : 'teacherGender',title : '教师性别',width : 120,sort : true,
		    	templet: function(data){
		            if(data.teacherGender==1){
		            		return '男'
		            }else if(data.teacherGender==2){
		            		return "女"
		            }else{
		            	return "中性"
		            }
		          }},
		    {field : 'teacherDuty',title : '教师职责',width : 500,sort : true},
		    {title : '编辑',toolbar : '#teacherEdit',fixed : 'right'},
		]],
	});
};
/**
 * 初始化考勤情况
 */
WSM.teacher.initCheckResult = function(){
	var startTime = $("#startTime").val(),
	endTime = $("#endTime").val(),
	teacherXH = $("#operateForCheck").data("teacherXH");
	$.ajax({
		async:true,
		type:'post',
		data:{teacherXH:teacherXH,startTime:startTime,endTime:endTime},
		url:'../Student.do?queryCheck',
		success:function(data){
			if(data.code==0){
				$("#overdueSumContent").text(data.data.data.overdueSum);
				$("#RquestLeaveSumContent").text(data.data.data.RquestLeaveSum);
				$("#TruantSumContent").text(data.data.data.TruantSum);
			}else{
				layer.alert(data.msg);
			}
		},
		error:function(){
			layer.alert("查询失败！");
		}
	});
}
WSM.teacher.bind = function(table, layer, form) {
	$("#queryCheck").click(function(){
		WSM.teacher.initCheckResult();
	});
	$("#teacherSearch").click(function(){
		WSM.teacher.initTable("#teachertb", table);
	});
	// 监听事件
	table.on('tool(teachertb)', function(obj) {
		var data = obj.data // 获得当前行数据
		, layEvent = obj.event;
		if (layEvent === 'teacherInitPassword') {
			layer.confirm("确定初始化密码吗",function(index){
				layer.close(index);
				//重置学生移动端密码（123456）
				var teacherXH = data.teacherId,
				teacherPassword = "123456";
				$.ajax({
					async:true,
					type:'post',
					url:'../Teacher.do?setPasswordForTeacher',
					dataType:'json',
					data:{teacherXH:teacherXH,teacherPassword:teacherPassword},
					success:function(data){
						if(data.code==0){
							//设置密码成功
							layer.alert("密码重置成功，新密码："+teacherPassword);
						}else{
							layer.alert(data.msg);
						}
					},
					error:function(){
						layer.alert("重置密码失败！");
					}
				});
			});
		}else if(layEvent === 'teacherCheckDetail'){
			var teacherXH = data.teacherXH;
			$("#overdueSumContent").text("");
			$("#RquestLeaveSumContent").text("");
			$("#TruantSumContent").text("");
			$("#operateForCheck").data("teacherXH",teacherXH);
			WSM.teacher.initCheckResult();
			//查看学生考勤情况
			layer.open({
				area:['50%','50%'],
				title:'考勤情况',
				type:1,
				content:$("#operateForCheck"),
				btnAlign:'c',
				btn:["关闭"],
				cancel:function(index,layero){
					layer.close(index);
				},
			});
		}
	})
};


(function(){
	layui.use(['element','layer','form','table','laydate'], function(){
		var layer = layui.layer;
		var table = layui.table;
		var form = layui.form;
		var laydate = layui.laydate;
		WSM.teacher.init(layer,table,form,laydate);
		WSM.teacher.bind(table,layer,form);
	})
})();
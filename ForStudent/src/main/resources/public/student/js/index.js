var WSM = parent.window.WSM;
WSM.student = {};
WSM.student.init = function(layer,table,form,laydate) {
	WSM.student.initlayDate(laydate);
	WSM.student.initTable("#studenttb",table);
};
/**
 * 初始化日期组件
 */
WSM.student.initlayDate = function(laydate){
  laydate.render({
    elem: '#startTime', //指定元素
    value:'2018-02-02'
  });
  laydate.render({
	    elem: '#endTime', //指定元素
	    value:'2019-10-02'
	  });
}
WSM.student.initTable = function($tableId, table) {
	var studentXH = $("#studentXH").val(),
		studentName = $("#studentName").val(),
		studentCollege = $("#studentCollege").val(),
		studentMajor = $("#studentMajor").val(),
		studentGradeClass = $("#studentGradeClass").val();
	table.render({
		elem : $tableId,
		height : '400',
		url : '../Student.do?getAllStudent',
		page : true,
		method : 'post',
		where : {
			studentXH : studentXH,
			studentName : studentName,
			studentCollege : studentCollege,
			studentMajor : studentMajor,
			studentGradeClass : studentGradeClass
		},
		cols : [[
		    {field : 'studentXH',title : '学生学号',width : 120,sort : true}, 
		    {field : 'studentName',title : '姓名',width : 120,sort : true},
		    {field : 'studentGender',title : '性别',width : 120,sort : true,
		    	templet: function(data){
		            if(data.studentGender==1){
		            		return '男'
		            }else if(data.studentGender==2){
		            		return "女"
		            }else{
		            	return "中性"
		            }
		          },},
		    {field : 'studentCollege',title : '学院',width : 120,sort : true},
		    {field : 'studentMajor',title : '专业',width : 120,sort : true},
		    {field : 'studentGradeClass',title : '年级班级',width : 200,sort : true},
		    {title : '编辑',toolbar : '#studentEdit',fixed : 'right'},
		]],
	});
};
/**
 * 初始化考勤情况
 */
WSM.student.initCheckResult = function(){
	var startTime = $("#startTime").val(),
	endTime = $("#endTime").val(),
	studentXH = $("#operateForCheck").data("studentXH");
	$.ajax({
		async:true,
		type:'post',
		data:{studentXH:studentXH,startTime:startTime,endTime:endTime},
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
WSM.student.bind = function(table, layer, form) {
	$("#queryCheck").click(function(){
		WSM.student.initCheckResult();
	});
	$("#studentSearch").click(function(){
		WSM.student.initTable("#studenttb", table);
	});
	// 监听事件
	table.on('tool(studenttb)', function(obj) {
		var data = obj.data // 获得当前行数据
		, layEvent = obj.event;
		if (layEvent === 'studentInitPassword') {
			layer.confirm("确定初始化密码吗",function(index){
				layer.close(index);
				//重置学生移动端密码（123456）
				var studentXH = data.studentXH,
				studentPassword = "123456";
				$.ajax({
					async:true,
					type:'post',
					url:'../Student.do?setPasswordForStudent',
					dataType:'json',
					data:{studentXH:studentXH,studentPassword:studentPassword},
					success:function(data){
						if(data.code==0){
							//设置密码成功
							layer.alert("密码重置成功，新密码：123456");
						}else{
							layer.alert(data.msg);
						}
					},
					error:function(){
						layer.alert("重置密码失败！");
					}
				});
			});
		}else if(layEvent === 'studentCheckDetail'){
			var studentXH = data.studentXH;
			$("#overdueSumContent").text("");
			$("#RquestLeaveSumContent").text("");
			$("#TruantSumContent").text("");
			$("#operateForCheck").data("studentXH",studentXH);
			WSM.student.initCheckResult();
			//查看学生考勤情况
			layer.open({
				area:['60%','60%'],
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
		WSM.student.init(layer,table,form,laydate);
		WSM.student.bind(table,layer,form);
	})
})();
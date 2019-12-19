# 一：项目简介
	这是一套学生签到系统，可用于学生毕业论文的软件项目，如果你有兴趣也可以基于此搭建一个功能完善的签到系统；希望通过这个项目能让你对Flutter项目有一定的了解，适合新手学习；系统分为前台后台如下：
	1）java服务端提供后台服务（ForStudent）
	2）Flutter移动端提供功能操作（ForStudent_app）
# 二：技术架构
	java：springboot+springsecrity+sqlserver(具备完善权限机制)
	Flutter：一种统一开发app、ios移动端应用参考：https://flutterchina.club/
# 三：功能介绍
## java服务端:ForStudent
  具备功能：
    1.完善的权限机制：可分配用户角色，角色可配置权限，权限可定位到页面，也可以定位到具体的功能按钮元素

![image](https://github.com/xiaoping1993/ForStudent/raw/master/resource/用户配置.png)

![image](https://github.com/xiaoping1993/ForStudent/raw/master/resource/教师配置.png)

    2.学生管理模块：可以初始化学习移动端密码，和对应考勤情况

![image](https://github.com/xiaoping1993/ForStudent/raw/master/resource/学生管理.png)
    
    3.教师管理模块：查询教师信息，初始化移动端登录密码和对应班级考勤情况

![image](https://github.com/xiaoping1993/ForStudent/raw/master/resource/教师管理.png)

    4.给移动端提供专门的接口服务
## Flutter移动端app:ForStudent_app
### 具备功能：
    1.分为教师登录，学生登录两个模块

![image](https://github.com/xiaoping1993/ForStudent/raw/resource/jieping/app主页.png)

	2.学生内容：可以查看本周课程表，和本周所有签到情况在课程表上通过颜色标记出来；我的模块提供学生基本信息并且可以修改登录密码，查看指定日期考勤情况；签到模块通过扫描班级二维码（这个二维码可以通过教师版修改，后台管理员修改）完成签到，签到模块原理复杂在项目文档中有记载，如果想知道其原理请查找

![image](https://github.com/xiaoping1993/ForStudent/raw/master/resource/学生个人.png)

![image](https://github.com/xiaoping1993/ForStudent/raw/master/resource/学生登录.png)

![image](https://github.com/xiaoping1993/ForStudent/raw/master/resource/课程表.png)

![image](https://github.com/xiaoping1993/ForStudent/raw/master/resource/学生签到.png)

    3.教师内容：可以查看自己信息，角色信息，修改登录密码，通过可以调用自己班级的二维码，并且可以替换它

![image](https://github.com/xiaoping1993/ForStudent/raw/master/resource/教师我的.png)

![image](https://github.com/xiaoping1993/ForStudent/raw/master/resource/教师主页获得班级二维码.png)

![image](https://github.com/xiaoping1993/ForStudent/raw/master/resource/教师获得二维码变更二维码.png)

![image](https://github.com/xiaoping1993/ForStudent/raw/master/resource/学生签到.png)

# 四：部署手册
	1）部署sqlserver环境-》找到resource\ForStudent.sql数据库文件-》初始化数据库
	2）下载ForStudent项目->cd 根目录->mvn clean package->拿到jar包->java -jar jar包
	3）用AndroidStudio打开ForStudent_app有注释可以帮助你了解Flutter并作为你Flutter的开发脚手架->配置好与后台java服务的连接api就可以用了
# 五：资源
resource\助学通APP.mp：app设计稿
resource\助学通后台管理.rp：后台系统设计稿
resource\助学通项目方案.docx：项目设计方案，有兴趣可以看看我的设计过程和思路

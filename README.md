# 一：项目简介
	这是一套学生签到系统，可用于学生毕业论文的软件项目，如果你有兴趣也可以基于此搭建一个功能完善的签到系统；希望通过这个项目能让你对Flutter项目有一定的了解，适合新手学习；系统分为前台后台如下：
	1）java服务端提供后台服务（ForStudent）
	2）Flutter移动端提供功能操作（ForStudent_app）
# 二：技术架构
	java：springboot+springsecrity+sqlserver(具备完善权限机制)
	Flutter：一种统一开发app、ios移动端应用参考：https://flutterchina.club/
# 三：[功能介绍](https://github.com/xiaoping1993/ForStudent/blob/master/resource/功能介绍.md)

# 四：部署手册
	1）部署sqlserver环境-》找到resource\ForStudent.sql数据库文件-》初始化数据库
	2）下载ForStudent项目->cd 根目录->mvn clean package->拿到jar包->java -jar jar包
	3）用AndroidStudio打开ForStudent_app有注释可以帮助你了解Flutter并作为你Flutter的开发脚手架->配置好与后台java服务的连接api就可以用了
# 五：资源
resource\助学通APP.mp：app设计稿

resource\助学通后台管理.rp：后台系统设计稿

resource\助学通项目方案.docx：项目设计方案，有兴趣可以看看我的设计过程和思路


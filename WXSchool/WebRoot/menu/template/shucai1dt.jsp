<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>蔬菜细节</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="viewport"
			content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />

		<style type="text/css">
#qianggou {
	position: fixed;
	left: 20px;
	right: 20px;
	bottom: 5px;
	_position: absolute;
	_top: expression(document.documentElement.clientHeight +                   
 document.documentElement.scrollTop -    this.offsetHeight);
	padding: 10px 0;
	text-align: center;
	background-color: green;
	color: #fff;
}
</style>
	</head>

	<body bgcolor="#EFEFEF">
		<div style="width: 100%">

			<div style="margin: -8px; height: 50px; background-color: green;">
				<span style="color: #fff; line-height: 50px; margin-left: 20px;">微蔬菜</span>
				<a href="shucai1.jsp"><img alt=""
						src="images/shucai/shucaihome.png" width="40px" height="40px"
						style="margin: 5px 20px; float: right;"> </a>
			</div>

			<div
				style="border: 1px solid #aaa; margin-top: 15px; background-color: #fff;">
				<div style="margin: 15px;">
					<div>
						蔬菜标题蔬菜标题
					</div>
					<div style="margin-top: 5px;">
						<img alt="" src="images/shucai/1.jpg" width="100%" height="150px">
					</div>
					<div
						style="padding: 10px 0; margin-top: 5px; background-color: #ccc;">
						￥100元 100人购买
					</div>
				</div>

				<div style="margin: 15px;">
					<div style="margin-top: 25px">
						<div style="width: 100%; overflow: hidden; white-space: nowrap;">
							商品描述--------------------------------
						</div>
						<div style="font-size: 14px; color: #333; margin: 10px 0;">
							商品描述商品描述商品描述商品商品描述商品描述商品描述商品描述商品描述商品描述描述商品描述商品描述商品描述商品描述商品描述商品描述商品描述商品描述商品描述商品描述
						</div>
						<img alt="" src="images/shucai/1.jpg" width="100%" height="150px">
					</div>

					<div style="margin-top: 25px">
						<div style="width: 100%; overflow: hidden; white-space: nowrap;">
							营养价值---------------------------------
						</div>
						<div style="font-size: 14px; color: #333; margin: 10px 0;">
							营养价值营养价值营养价值营养价值营养价值营养价值营养价值营养价值营养价值营养价值营养价值营养价值营养价值营养价值营养价值营养价值营养价值营养价值营养价值营养价值营养价值
						</div>
						<img alt="" src="images/shucai/1.jpg" width="100%" height="150px">
					</div>

					<div style="margin-top: 25px">
						<div style="width: 100%; overflow: hidden; white-space: nowrap;">
							医疗作用---------------------------------
						</div>
						<div style="font-size: 14px; color: #333; margin: 10px 0;">
							医疗作用医疗作用医疗作用医疗作用医疗作用医疗作用医疗作用医疗作用医疗作用医疗作用医疗作用医疗作用医疗作用医疗作用医疗作用医疗作用医疗作用医疗作用医疗作用医疗作用
						</div>
					</div>

					<div style="margin-top: 25px">
						<div style="width: 100%; overflow: hidden; white-space: nowrap;">
							存储范式---------------------------------
						</div>
						<div style="font-size: 14px; color: #333; margin: 10px 0;">
							存储方式存储方式存储方式存储方式存储方式存储方式存储方式存储方式存储方式存储方式存储方式存储方式
						</div>
					</div>
				</div>
			</div>

			<div id="qianggou">
				抢购
			</div>
		</div>
	</body>
</html>

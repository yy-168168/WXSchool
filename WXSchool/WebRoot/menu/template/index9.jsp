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

		<title>模板九</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="viewport"
			content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />

		<style type="text/css">
#foodmenu {
	position: fixed;
	left: 0px;
	right: 0px;
	_position: absolute;
	_top: expression(document.documentElement.clientHeight +     
		   document.documentElement.scrollTop -          this.offsetHeight);
	background-color: #666;
	font-size: 14px;
	color: #fff;
	height: 60px;
	padding: 8px 0 6px 0;
	margin: -8px;
}
</style>
	</head>

	<body bgcolor="#EFEFEF">
		<div style="width: 100%">

			<div id="foodmenu">
				<div
					style="float: left; width: 24.7%; text-align: center; border-right: 1px solid #fff;">
					<img alt="" src="images/modle7/in1.png" width="70%" height="35px">
					<div style="margin-top: 5px;">
						炒菜
					</div>
				</div>
				<div
					style="float: left; width: 24.7%; text-align: center; border-right: 1px solid #fff;">
					<img alt="" src="images/modle7/in1.png" width="70%" height="35px">
					<div style="margin-top: 5px;">
						凉菜
					</div>
				</div>
				<div
					style="float: left; width: 24.7%; text-align: center; border-right: 1px solid #fff;">
					<img alt="" src="images/modle7/in1.png" width="70%" height="35px">
					<div style="margin-top: 5px;">
						主食
					</div>
				</div>
				<div style="float: left; width: 24.7%; text-align: center;">
					<img alt="" src="images/modle7/in1.png" width="70%" height="35px">
					<div style="margin-top: 5px;">
						其他
					</div>
				</div>
			</div>
			<div style="height: 75px;"></div>

			<div style="margin-left: 2%;">
				<div style="float: left; width: 33%">
					<img alt="" src="images/modle9/hspg.jpg" width="90%" height="66px">
				</div>
				<div style="float: right; width: 65%; line-height: 1.5;">
					<span style="font-size: 18px; font-weight: 200;">红烧排骨</span>
					<br />
					<span style="color: #666;">￥10.0元</span>
				</div>
				<div style="clear: both;"></div>
				<div style="border-top: solid 1px #aaa; margin: 10px 0"></div>
			</div>

			<div style="margin-left: 2%;">
				<div style="float: left; width: 33%">
					<img alt="" src="images/modle9/hsqz.jpg" width="90%" height="66px">
				</div>
				<div style="float: right; width: 65%; line-height: 1.5;">
					<span style="font-size: 18px; font-weight: 200;">油淋茄子</span>
					<br />
					<span style="color: #666;">￥10.0元</span>
				</div>
				<div style="clear: both;"></div>
				<div style="border-top: solid 1px #aaa; margin: 10px 0"></div>
			</div>

			<div style="margin-left: 2%;">
				<div style="float: left; width: 33%">
					<img alt="" src="images/modle9/hspg.jpg" width="90%" height="66px">
				</div>
				<div style="float: right; width: 65%; line-height: 1.5;">
					<span style="font-size: 18px; font-weight: 200;">红烧排骨</span>
					<br />
					<span style="color: #666;">￥10.0元</span>
				</div>
				<div style="clear: both;"></div>
				<div style="border-top: solid 1px #aaa; margin: 10px 0"></div>
			</div>

			<div style="margin-left: 2%;">
				<div style="float: left; width: 33%">
					<img alt="" src="images/modle9/hsqz.jpg" width="90%" height="66px">
				</div>
				<div style="float: right; width: 65%; line-height: 1.5;">
					<span style="font-size: 18px; font-weight: 200;">油淋茄子</span>
					<br />
					<span style="color: #666;">￥10.0元</span>
				</div>
				<div style="clear: both;"></div>
				<div style="border-top: solid 1px #aaa; margin: 10px 0"></div>
			</div>

			<div style="margin-left: 2%;">
				<div style="float: left; width: 33%">
					<img alt="" src="images/modle9/hspg.jpg" width="90%" height="66px">
				</div>
				<div style="float: right; width: 65%; line-height: 1.5;">
					<span style="font-size: 18px; font-weight: 200;">红烧排骨</span>
					<br />
					<span style="color: #666;">￥10.0元</span>
				</div>
				<div style="clear: both;"></div>
				<div style="border-top: solid 1px #aaa; margin: 10px 0"></div>
			</div>

			<div style="margin-left: 2%;">
				<div style="float: left; width: 33%">
					<img alt="" src="images/modle9/hsqz.jpg" width="90%" height="66px">
				</div>
				<div style="float: right; width: 65%; line-height: 1.5;">
					<span style="font-size: 18px; font-weight: 200;">油淋茄子</span>
					<br />
					<span style="color: #666;">￥10.0元</span>
				</div>
				<div style="clear: both;"></div>
				<div style="border-top: solid 1px #aaa; margin: 10px 0"></div>
			</div>

			<div style="margin-left: 2%;">
				<div style="float: left; width: 33%">
					<img alt="" src="images/modle9/hspg.jpg" width="90%" height="66px">
				</div>
				<div style="float: right; width: 65%; line-height: 1.5;">
					<span style="font-size: 18px; font-weight: 200;">红烧排骨</span>
					<br />
					<span style="color: #666;">￥10.0元</span>
				</div>
				<div style="clear: both;"></div>
				<div style="border-top: solid 1px #aaa; margin: 10px 0"></div>
			</div>

			<div style="margin-left: 2%;">
				<div style="float: left; width: 33%">
					<img alt="" src="images/modle9/hsqz.jpg" width="90%" height="66px">
				</div>
				<div style="float: right; width: 65%; line-height: 1.5;">
					<span style="font-size: 18px; font-weight: 200;">油淋茄子</span>
					<br />
					<span style="color: #666;">￥10.0元</span>
				</div>
				<div style="clear: both;"></div>
				<div style="border-top: solid 1px #aaa; margin: 10px 0"></div>
			</div>

		</div>
	</body>
</html>

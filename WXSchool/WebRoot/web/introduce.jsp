<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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

<title>微接口</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta name="viewport"
	content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<link type="image/x-icon" rel="shortcut icon" href="<%=basePath %>static_/favicon.ico" />
		<link href="<%=basePath %>static_/mng.css" type="text/css" rel="stylesheet">
<link href="<%=basePath %>static_/myfont.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="<%=basePath %>static_/jquery-1.8.2.min.js">
</script>
		<script type="text/javascript" src="<%=basePath %>static_/mng.js">
</script>
<style type="text/css">
#func {
	margin: 20px 10px;
	border: 1px solid #ccc;
	border-bottom: 0;
	border-radius: 3px;
	border-top-left-radius: 0;
}

#func ul {
	list-style: none;
}

.funTitle {
	padding: 10px;
	background-color: #fafafa;
	border-left: 3px solid #67AD03;
	margin-left: -1px;
	font-weight: bold;
}

.funDetail {
	border-top: 1px solid #ddd;
	border-bottom: 1px solid #ddd;
	padding: 10px;
}
</style>
<script type="text/javascript">
	
</script>

</head>

<body>

	<div style="background-color: #F3F3F3; box-shadow: 0px 2px 6px #B6B6B6">
		<div style="height: 5px; background-color: #67AD03;"></div>
		<div style="padding: 10px 10px 5px 10px;">
			<img alt="" src="static_/logo.png" height="38px" style="vertical-align: bottom;"> 
			<span style="font-size: 20px; font-weight: bold; color: #333;">微接口</span>
			<span style="font-size: 13px; font-family: '华文行楷'; color: #113C64;">-只为校园而生</span>
		</div>
	</div>

	<div id="func">
		<ul>
			<li>
				<div class="funTitle">四六级查询</div>
				<div class="funDetail">
					<div>查询四六级成绩，具备记忆功能</div>
					<div>免费使用</div>
				</div>
			</li>
			<li>
				<div class="funTitle">外卖订餐</div>
				<div class="funDetail">
					<div>简单直观，增加餐店和菜品在微接口后台</div>
					<div>默认有30个餐店的配额，默认配额内免费使用</div>
				</div>
			</li>
			<li>
				<div class="funTitle">寻物招领</div>
				<div class="funDetail">
					<div>社会公益功能，让大家知道掉了东西去哪找，捡到东西去哪告知</div>
					<div>免费使用</div>
				</div>
			</li>
			<li>
				<div class="funTitle">表白墙</div>
				<div class="funDetail">
					<div>校园互动功能</div>
					<div>免费使用</div>
				</div>
			</li>
			<li>
				<div class="funTitle">树洞</div>
				<div class="funDetail">
					<div>校园互动功能</div>
					<div>免费使用</div>
				</div>
			</li>
			<li>
				<div class="funTitle">老乡</div>
				<div class="funDetail">
					<div>查找同城老乡功能</div>
					<div>需要提供学院及专业，免费使用</div>
				</div>
			</li>
			<li>
				<div class="funTitle">随机搭讪</div>
				<div class="funDetail">
					<div>本功能需要记录用户的使用时间，才知道是否在线，公众号后台不是直接对接微接口服务器的无法使用</div>
					<div>免费使用</div>
				</div>
			</li>
			<li>
				<div class="funTitle">随手拍</div>
				<div class="funDetail">
					<div>单列展示，自愿上传</div>
					<div>图片是很消耗服务器内存和流量的元素，默认有50张图片的配额，默认配额内免费使用</div>
				</div>
			</li>
			<li>
				<div class="funTitle">照片墙</div>
				<div class="funDetail">
					<div>双列展示，自愿上传，后台审核，适合照片投票场景</div>
					<div>图片是很消耗服务器内存和流量的元素，默认有50张图片的配额，默认配额内免费使用</div>
				</div>
			</li>
			<li>
				<div class="funTitle">成绩查询/教务功能</div>
				<div class="funDetail">
					<div>成绩查询，选课，课表，以及其它教务功能</div>
					<div>需要单独开发，按教务复杂程度收费</div>
				</div>
			</li>
			<li>
				<div class="funTitle">关于微接口</div>
				<div class="funDetail">
					<div>微接口是校园自发兴趣组织所开发，都是在校大学生。我们热爱新媒体，热爱微信生态圈，热爱开发新事物。微接口一切费用均由组织成员承担，相对于学生来说，一年下来，这些费用还是不低的。虽然很多功能我们都是免费使用，但如果你能资助少许费用，我们也会很高兴，很感谢。</div>
				</div>
			</li>
			<li>
				<div class="funTitle">为什么不开放注册？</div>
				<div class="funDetail">
					<div>1、原则问题：实用。功能实用，数据实用。</div>
					<div>2、注册了不用的人大有人在，这些脏数据会增加我们的服务器成本。</div>
				</div>
			</li>
			<li>
				<div class="funTitle">如何使用？</div>
				<div class="funDetail">
					<div>第一步：提交相关资料，和告知我需要哪些功能</div>
					<div>第二步：内部组织成员配置权限和功能</div>
					<div>第三步：你在现用第三方平台使用融合功能对接微接口</div>
					<div>第四步：测试是否配置成功</div>
					<br/>
					<div>相关资料包括：公众号名称、公众号微信号、原始ID、公众号粉丝数</div>
				</div>
			</li>
			<li>
				<div class="funTitle">功能体验公众号</div>
				<div class="funDetail">
					<div style="text-align: center; font-size: 12px">
						<img alt="" src="static_/qrcode_for_hsdzs.jpg" width="120px"><br/> 
						<span>长按自动识别二维码</span>
					</div>
				</div>
			</li>
		</ul>
	</div>

	<div style="text-align: center; font-size: 13px">
		<span>Copyright © 2013-2015   微接口</span><br/>
		<span>粤ICP备15076611号-1</span>
	</div>
	<%@ include file="../common/tongji.html"%>
</body>
</html>
<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	String token = request.getParameter("token");
	String ac = request.getParameter("ac");
	String topicId = "-1", desc = "", title = "", overTime = "", info = "";
	Topic topic = (Topic) request.getAttribute("topic");
	if (topic != null) {
		topicId = topic.getTopicId() + "";
		title = topic.getTitle();
		desc = topic.getDesc();
		overTime = topic.getOverTime();
		info = topic.getInfo();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>微接口 - 照片活动</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="shortcut icon" href="static_/favicon.ico" type="imagend.microsoft.icon">
		<link rel="icon" href="static_/favicon.ico" type="imagend.microsoft.icon">
		<link href="static_/mng.css" type="text/css" rel="stylesheet">
		<link rel="stylesheet" href="static_/jquery-ui.min.css">
		<script type="text/javascript" src="static_/jquery-1.8.2.min.js">
</script>
		<script type="text/javascript" src="static_/jquery-ui.min.js">
</script>
		<script type="text/javascript"
			src="static_/jquery-ui-timepicker-addon.js">
</script>
		<script type="text/javascript" src="static_/mng.js">
</script>
		<link rel="stylesheet" href="kindeditor/themes/default/default.css" />
		<script charset="utf-8" src="kindeditor/kindeditor-min.js">
</script>
		<script charset="utf-8" src="kindeditor/lang/zh_CN.js">
</script>

		<script type="text/javascript">
var editor;
KindEditor.ready(function(K) {
	editor = K.create('textarea[name="desc"]', {
		resizeType : 0,
		width : '450px',
		height : '350px',
		minWidth : '450px',
		minHeight : '350px',
		allowPreviewEmoticons : false,//预览表情
		allowImageUpload : false,
		filterMOde : false,//过滤标签
		wellFormatMode : false,
		items : [ 'fontsize', 'forecolor', 'hilitecolor', 'bold', 'italic',
				'underline', 'removeformat', 'justifycenter', 'emoticons' ]
	});
	editor.html('<%=desc%>');
});

$(function() {
	$("#overTime").datetimepicker(dataTimeInfo);

	if ('<%=overTime%>' == '3000-01-01 00:00') {
		document.getElementsByName("isAllValid")[0].checked = true;
	}
});

function check() {
	var desc = editor.html();
	var title = document.getElementsByName("title")[0].value;
	var info = document.getElementsByName("info")[0].value;
	var overTime = document.getElementsByName("overTime")[0].value;
	var isAllValid = document.getElementsByName("isAllValid")[0].checked;

	if ($.trim(desc) == "" || $.trim(title) == "") {
		showNotice("不能为空！");
		return false;
	}

	if (title.length > 200 || info.length > 200) {
		showNotice("活动标题或者简要说明数据过长！");
		return false;
	}
	
	if(isAllValid == undefined || isAllValid == false){
		if ($.trim(overTime) == "") {
			showNotice("不能为空！");
			return false;
		}
	}

	$(":button").attr("disabled", true);
	$(":button").val("提交中...");

	var url = "/mngs/topic?ac=<%=ac%>&token=<%=token%>";
	$.post(url, {
		topicId : '<%=topicId%>',
		desc : desc,
		title : title,
		overTime : overTime,
		info : info,
		isAllValid : isAllValid
	}, function(msg) {
		if (msg == "uptfalse" || msg == "addfalse") {
			showNotice("操作失败，请重试！");
			$(":button").attr("disabled", false);
			$(":button").val("保存");
		} else {
			if ('<%=ac%>'.indexOf("add") >= 0) {
				isGoonUpt();
			} else {
				window.location.href = document.referrer;
			}
		}
	});
}
</script>
	</head>

	<body>
		<jsp:include page="head.jsp"></jsp:include>

		<div class="content">
			<div class="left">
				<jsp:include page="/mng/menuLeft.jsp"></jsp:include>
			</div>

			<div class="right">
				<div class="title">
					添加/更新照片活动
					<div style="float: right">
						<a href="javascript:history.go(-1);">返回</a>
					</div>
				</div>
				<div style="padding: 20px;">
					<form method="post">
						<table width="100%" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td class="form_title">
									活动名称
									<span class="myrequired">*</span>
								</td>
								<td>
									<input type="text" name="title" value="<%=title%>"
										class="input_text" size="50">
									<span class="textSpan"></span>
								</td>
							</tr>
							<tr>
								<td class="form_title">
									简要说明
									<span class="myrequired">&nbsp;</span>
								</td>
								<td>
									<textarea name="info" class="textarea" cols="53" rows="3"
										style="resize: none;"><%=info%></textarea>
									<span class="textSpan">字数不要过多</span>
								</td>
							</tr>
							<tr>
								<td class="form_title">
									结束时间
									<span class="myrequired">*</span>
								</td>
								<td>
									<input type="text" name="overTime" value="<%=overTime%>"
										id="overTime" class="input_text" size="50" readonly="readonly">
									<input name="isAllValid" type="checkbox"
										style="margin-left: 15px">
									长期有效
									<span class="textSpan"></span>
								</td>
							</tr>
							<tr>
								<td class="form_title" style="vertical-align: top;">
									规则说明
									<span class="myrequired">*</span>
									<br />
									<span class="textSpan"></span>
								</td>
								<td>
									<textarea name="desc"></textarea>
								</td>
							</tr>
							<tr>
								<td class="form_title">
								</td>
								<td>
									<input type="button" value="保存" class="input_button"
										onclick="check();">
									<div id="erromsg" style="display: inline;"></div>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>
		<%@ include file="../common/foot.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>

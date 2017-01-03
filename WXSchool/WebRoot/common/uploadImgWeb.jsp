<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String userwx = request.getParameter("userwx");
	String wxaccount = request.getParameter("wxaccount");
	String topicId = request.getParameter("topicId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>照片上传</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta name="viewport"
	content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<link href="<%=basePath %>static_/mycommon.css" type="text/css" rel="stylesheet">
<link href="<%=basePath %>static_/myfont.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="<%=basePath%>static_/mycommon.js"></script>
<script type="text/javascript" src="<%=basePath%>static_/jquery-1.8.2.min.js"></script>

<script type="text/javascript">
document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
	WeixinJSBridge.call('hideOptionMenu');
});
		
function check() {
	var content = document.getElementsByName("content")[0].value;

	if ($.trim(content) == "") {
		$("#msg").text("不能为空");
		return false;
	}

	if (content.length > 190) {
		$("#msg").text("消息内容不能超过200字");
		return false;
	}

	$("#submit").attr("disabled", true);
	$("#submit").val("提交中...");

	var url = "/mobile/pic?ac=uploadImgWeb&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
	$.post(url, {
		mediaId : images.serverId,
		topicId : '<%=topicId%>',
		content : content
	}, function(data) {
		if (data == "ok") {
			images.serverId = '';
			$("#uploadBox").slideUp();
			alert("上传成功，审核通过后即可展示，可继续选择照片上传");
			// window.location.reload();
		} else {
			alert("上传失败，请重试！");
		}
		$("#submit").attr("disabled", false);
		$("#submit").val("提 交");
	});
}
</script>
</head>

<body onload="checkMM();">

	<div>
		<input type="button" id="chooseImgBtn" value="选择照片" class="html5btn">
	</div>

	<div id="uploadBox" style="margin-top: 10px; display: none">
		<form method="post" id="pubForm">
			<div class="html5yj">
				<div class="formhead_n">
					<div>
						<span class="glyphicon glyphicon-edit"></span>&nbsp;为照片提供相关信息
					</div>
				</div>
				<div style="padding: 10px 10px 3px 10px">
					<div style="text-align: center;">
						<img id="previewImg" src=""
							style="max-width: 100%; border: 1px #efefef solid;" />
					</div>
					<div class="text1">信息内容</div>
					<textarea rows="4" cols="" name="content" class="html5area_n"
						onclick="clearMsg();"></textarea>
					<hr />
					<input id="submit" type="button" value="提 交" class="html5btn">
					<div id="msg"></div>
				</div>
			</div>
		</form>
	</div>

	<jsp:include page="../common/copyright.jsp" />
	<%@ include file="../common/toolbar.html"%>
	<%@ include file="../common/tongji.html"%>
	
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<script type="text/javascript" src="<%=basePath%>static_/wxjsSDK.js?v=22"></script>
	<script type="text/javascript">
		initJsSDK('<%=wxaccount%>', '<%=userwx%>');

		var images = {
			localId : '',
			serverId : ''
		};
		wx.ready(function() {
			// 选择照片
			$("#chooseImgBtn").click(
					function() {
						// 1判断当前版本是否支持指定 JS 接口，支持批量判断
						// 返回值 {"checkResult":{"chooseImage":true},"errMsg":"checkJsApi:ok"}
						wx.checkJsApi({
							jsApiList : [ 'chooseImage', 'uploadImage' ],
							success : function(res) {
								var checkResult = res.checkResult;
								if (checkResult.chooseImage == false
										|| checkResult.checkJsApi == false) {
									alert("当前微信版本不支持上传图片");
									return false;
								}
							}
						});

						// 2 拍照或从手机相册中选图接口
						wx.chooseImage({
							count : 1, // 默认9
							success : function(res) {
								images.localId = res.localIds[0];
								$("#previewImg").attr("src", images.localId);
								$("#uploadBox").slideDown();
							}
						});
					});

			// 上传照片
			$("#submit").click(function() {
				var content = document.getElementsByName("content")[0].value;

				if ($.trim(content) == "") {
					$("#msg").text("不能为空");
					return false;
				}

				if (images.serverId == '') {
					wx.uploadImage({
						localId : images.localId, // 需要上传的图片的本地ID，由chooseImage接口获得
						isShowProgressTips : 1, // 默认为1，显示进度提示
						success : function(res) {
							images.serverId = res.serverId; // 返回图片的服务器端ID
							check();
						}
					});
				} else {
					check();
				}
			});
		});
	</script>
</body>
</html>

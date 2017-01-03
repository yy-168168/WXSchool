
<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String token = request.getParameter("token");
	String ac = request.getParameter("ac");
	String gsId = "-1", simDesc = "", picUrl = "", tel = "", wxin = "", price = "", old = "5", cate = "1", type = "1", dtlDesc = "";
	Goods goods = (Goods) request.getAttribute("goods");
	if (goods != null) {
		gsId = goods.getGoodsId() + "";
		simDesc = goods.getSimDesc();
		picUrl = goods.getPicUrl();
		tel = goods.getTel();
		wxin = goods.getWxin();
		cate = goods.getCate() + "";
		dtlDesc = goods.getDtlDesc();
		price = goods.getPrice() + "";
		old = goods.getOld() + "";
		type = goods.getType() + "";
	}

	String title = "";
	if (type.equals("1")) {
		title = "二手交易";
	} else if (type.equals("2")) {
		title = "格子铺管理";
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>微接口 - <%=title%></title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="shortcut icon" href="static_/favicon.ico" type="imagend.microsoft.icon">
		<link rel="icon" href="static_/favicon.ico" type="imagend.microsoft.icon">
		<link href="static_/mng.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="static_/jquery-1.8.2.min.js">
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
	editor = K.create('textarea[name="dtlDesc"]', {
		resizeType : 0,
		width : '500px',
		height : '350px',
		minWidth : '500px',
		minHeight : '350px',
		allowPreviewEmoticons : false,//预览表情
		allowImageUpload : false,
		filterMOde : false,//过滤标签
		wellFormatMode : false,
		items : [ 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
				'removeformat', 'justifycenter', 'emoticons' ]
	});
	editor.html('<%=dtlDesc%>');
});

$(function() {
	optionDefaultSelect($("#cate").children(), '<%=cate%>');

	if ('<%=type%>' == "2") {
		$("#old").prop("disabled", "disabled");
	} else {
		optionDefaultSelect($("#old").children(), '<%=old%>');
	}
});

function check() {
	var simDesc = document.getElementsByName("simDesc")[0].value;
	var tel = document.getElementsByName("tel")[0].value;
	var picUrl = document.getElementsByName("picUrl")[0].value;
	var wxin = document.getElementsByName("wxin")[0].value;
	var cate = document.getElementsByName("cate")[0].value;
	var price = document.getElementsByName("price")[0].value;
	var old = document.getElementsByName("old")[0].value;
	var dtlDesc = editor.html();

	if ($.trim(simDesc) == "" || $.trim(tel) == "" || $.trim(picUrl) == ""
			|| $.trim(wxin) == "" || $.trim(price) == ""
			|| $.trim(editor.text()) == "") {
		showNotice("不能为空！");
		return false;
	}

	if (!$.isNumeric(tel)) {
		showNotice("请正确输入手机号！");
		return false;
	}
	if (!$.isNumeric(price)) {
		showNotice("价格为整数！");
		return false;
	}

	if (simDesc.length > 50 || tel.length > 20 || picUrl.length > 200
			|| wxin.length > 50 || dtlDesc.length > 980 || price > 2000) {
		showNotice("有些数据过长！");
		return false;
	}

	$(":button").attr("disabled", true);
	$(":button").val("提交中...");

	var url = "/mngs/bns?ac=<%=ac%>&token=<%=token%>";
	$.post(url, {
		gsId : '<%=gsId%>',
		simDesc : simDesc,
		tel : tel,
		picUrl : picUrl,
		wxin : wxin,
		cate : cate,
		dtlDesc : dtlDesc,
		price : price,
		old : old
	}, function(msg) {
		if (msg == "uptfalse" || msg == "addfalse") {
			showNotice("操作失败，请重试！");
			$(":button").attr("disabled", false);
			$(":button").val("保存");
		} else if (msg == "overMaxNum") {
			showNotice("你已经达到每人配额上限(包括已删除物品)，如需增加配额，请联系微信yy_168168额外申请。");
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
				<jsp:include page="/mng/menuLeft.jsp">
					<jsp:param value="" name="id" />
				</jsp:include>
			</div>

			<div class="right">
				<div class="title">
					更新物品信息
					<div style="float: right">
						<a href="javascript:history.go(-1);">返回</a>
					</div>
				</div>
				<div style="padding: 20px;">
					<form method="post">
						<table width="100%" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td class="form_title">
									简要描述
									<span class="myrequired">*</span>
								</td>
								<td>
									<input type="text" name="simDesc" value="<%=simDesc%>"
										class="input_text" size="50">
									<span class="textSpan">16字为宜</span>
								</td>
							</tr>
							<tr>
								<td class="form_title">
									图片外链地址
									<span class="myrequired">*</span>
								</td>
								<td>
									<input type="text" name="picUrl" value="<%=picUrl%>"
										class="input_text" size="50">
									<br />
									<span class="textSpan">图片大小：宽度为300px，高度不限</span>
									<a href="javascript:tuchuang();" style="font-size: 13px">获取外链</a>
								</td>
							</tr>
							<%
								if (picUrl != null && !picUrl.equals("")) {
							%>
							<tr>
								<td></td>
								<td>
									<img alt="" src="<%=picUrl%>" width="260px"
										style="border: 1px solid #EEE" alt="该图片网址无效，请重新上传">
								</td>
							</tr>
							<%
								}
							%>
							<tr>
								<td class="form_title">
									价格
									<span class="myrequired">*</span>
								</td>
								<td>
									<input type="text" name="price" value="<%=price%>"
										class="input_text" size="50">
								</td>
							</tr>
							<tr>
								<td class="form_title">
									新旧状况
								</td>
								<td>
									<select id="old" name="old" style="width: 300px; padding: 0"
										class="input_text">
										<option value="10">
											全新
										</option>
										<option value="9">
											九成
										</option>
										<option value="8">
											八成
										</option>
										<option value="7">
											七成
										</option>
										<option value="6">
											六成
										</option>
										<option value="5">
											五成
										</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="form_title">
									所属类别
								</td>
								<td>
									<select id="cate" name="cate" style="width: 300px; padding: 0"
										class="input_text">
										<%
											if (type.equals("1")) {
										%>
										<option value="1">
											生活用品
										</option>
										<option value="2">
											电子产品
										</option>
										<option value="3">
											书籍资料
										</option>
										<option value="4">
											鞋包服装
										</option>
										<option value="5">
											运动户外
										</option>
										<option value="10">
											其它
										</option>
										<%
											} else {
										%>
										<option value="1">
											鞋包服装
										</option>
										<option value="2">
											护肤彩妆
										</option>
										<option value="3">
											美食特产
										</option>
										<option value="4">
											日用百货
										</option>
										<option value="5">
											珠饰镜表
										</option>
										<option value="6">
											电子产品
										</option>
										<option value="10">
											其它
										</option>
										<%
											}
										%>
									</select>
								</td>
							</tr>
							<tr>
								<td class="form_title">
									手机号
									<span class="myrequired">*</span>
								</td>
								<td>
									<input type="text" name="tel" value="<%=tel%>"
										class="input_text" size="50">
								</td>
							</tr>
							<tr>
								<td class="form_title">
									微信号
									<span class="myrequired">*</span>
								</td>
								<td>
									<input type="text" name="wxin" value="<%=wxin%>"
										class="input_text" size="50">
								</td>
							</tr>
							<tr>
								<td class="form_title" style="vertical-align: top;">
									详细描述
									<span class="myrequired">*</span>
									<br />
									<span class="textSpan"></span>
								</td>
								<td>
									<textarea name="dtlDesc"></textarea>
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

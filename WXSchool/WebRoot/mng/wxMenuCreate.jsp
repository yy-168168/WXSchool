<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String token = request.getParameter("token");
%>
<%
	Account account = (Account) request.getAttribute("account");
	String appId = "", appSecret = "", hideAppSecret = "";
	if (account != null) {
		appId = account.getAppId();
		appSecret = account.getAppSecret();
		
		if(!appSecret.equals("")){
			for(int i = 0; i < appSecret.length()-4; i++){
				hideAppSecret += "*";
			}
			hideAppSecret += appSecret.substring(appSecret.length()-4);
		}
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>微接口 - 自定义菜单</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="shortcut icon" href="static_/favicon.ico" type="imagend.microsoft.icon">
		<link rel="icon" href="static_/favicon.ico" type="imagend.microsoft.icon">
		<link href="static_/mng.css" type="text/css" rel="stylesheet">
		<link href="static_/myfont.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="static_/jquery-1.8.2.min.js">
</script>
		<script type="text/javascript" src="static_/mng.js">
</script>

		<style type="text/css">
.operate {
	cursor: pointer;
	float: right;
	color: #888;
}

.menuName {
	cursor: pointer;
	float: left;
	padding-right: 100px;
}

.firstMenu {
	background-color: #eee;
	padding: 10px;
}

.secondMenu li {
	padding: 8px 5px 5px 0;
	font-size: 13px;
	display: block;
}

#menu_right #allFunc {
	margin: 20px;
	line-height: 1.7;
}

.otherFunc {
	font-size: 13px;
}

.otherFunc label {
	font-weight: normal;
}

#menuRank ul {
	list-style: none;
	padding: 0;
	margin: 0;
}

#menuRank ul li {
	padding-bottom: 5px;
}
</style>
		<script type="text/javascript">
function createMenu() {
	var appId = document.getElementsByName("appId")[0].value;
	var appSecret = document.getElementsByName("appSecret")[0].value;

	if ($.trim(appId) == "" || $.trim(appSecret) == "") {
		showNotice("不能为空！");
		return false;
	}
	
	if(appSecret.indexOf("**") > -1){
		appSecret = '<%=appSecret %>';
	}

	if ($(".oneMenu").length == 0) {
		showNotice("请先设置菜单！");
		return false;
	}

	$("#c_m").attr("disabled", true);
	$("#c_m").val("提交中...");

	var url = "/mngs/wxmn?ac=create&token=<%=token%>";
	$.post(url, {
		appId : appId,
		appSecret : appSecret
	}, function(msg) {
		if (msg == "ok") {
			showNotice("创建菜单成功！");
		} else if (msg == "wrong1") {
			showNotice("AppId或者AppSecret不正确！");
		} else if (msg == "wrong2") {
			showNotice("菜单数据不正确！");
		} else if (msg == "error") {
			showNotice("提交出错，请重试！");
		} else {
			showNotice(msg);
			//alert(msg);
		}
	});

	$("#c_m").attr("disabled", false);
	$("#c_m").val("创建菜单");
}

var cur_menuId = 1;
function show_add_update_MenuName_dialog(level, menuId, obj) {
	if (level == 1) {
		if ($(".oneMenu").length >= 3) {
			showNotice("一级菜单最多只能设置3个");
		} else {
			document.getElementsByName("operateType1")[0].value = "add";
			show_hide("firstMenu_name");
		}
	} else if (level == 2) {
		var curSecondMenuSize = $(obj).parentsUntil(".oneMenu").next(
				".secondMenu").find("li").length;
		if (curSecondMenuSize >= 5) {
			showNotice("二级菜单最多只能设置5个");
		} else {
			document.getElementsByName("operateType2")[0].value = "add";
			show_hide("secondMenu_name");
		}
	} else if (level == 3) {
		var firstMenuName = $(obj).parent().prev().text();
		document.getElementsByName("operateType1")[0].value = "upt";
		document.getElementsByName("firstMenu_name")[0].value = $
				.trim(firstMenuName);
		show_hide("firstMenu_name");
	} else if (level == 4) {
		var secondMenuName = $(obj).parent().prev().text();
		document.getElementsByName("operateType2")[0].value = "upt";
		document.getElementsByName("secondMenu_name")[0].value = $
				.trim(secondMenuName);
		show_hide("secondMenu_name");
	}
	cur_menuId = menuId;
}

function add_update_MenuName(level) {
	var menuName;
	var operateType;

	if (level == 1) {
		menuName = document.getElementsByName("firstMenu_name")[0].value;
		menuName = unescape(menuName.replace(/\\/g, "%"));//unicode转码
		if (menuName == ""
				|| menuName.replace(/[^\x00-\xff]/g, "**").length > 8) {
			return false;
		}
		operateType = document.getElementsByName("operateType1")[0].value;
	} else if (level == 2) {
		menuName = document.getElementsByName("secondMenu_name")[0].value;
		menuName = unescape(menuName.replace(/\\/g, "%"));//unicode转码
		if (menuName == ""
				|| menuName.replace(/[^\x00-\xff]/g, "**").length > 16) {
			return false;
		}
		operateType = document.getElementsByName("operateType2")[0].value;
	}

	var url;
	if (operateType == "add") {
		url = "/mngs/wxmn?ac=addMenuName&token=<%=token%>";
	} else if (operateType == "upt") {
		url = "/mngs/wxmn?ac=updateMenuName&token=<%=token%>";
	}

	$.post(url, {
		menuId : cur_menuId,
		menuName : menuName
	}, function(data) {
		window.location.reload();
	});
}

function setMenuInfo(menuId) {
	var url = "/mngs/wxmn?ac=getMenuInfo&token=<%=token%>";
	$.post(url, {
		menuId : menuId
	}, function(data) {
		var obj = $.parseJSON(data);
		if (obj != null && obj != "") {
			setMenuInfo_html(obj.type, obj.content, obj.menuId);
		}
	});
}

function setMenuInfo_html(type_, content_, menuId_) {
	var html = "<div id='allFunc'><label><input type='radio' name='type' value='click' checked='checked'>&nbsp;发送消息：填入关键字</label><br />"
			+ "<label><input type='radio' name='type' value='view'>&nbsp;跳转到网页：填入网址</label>"
			+ "<div class='otherFunc'><span>以下为不常用功能：</span><br/>"
			+ "<label><input type='radio' name='type' value='scancode_push' title='扫码推事件'>&nbsp;扫码推事件：填入关键字</label><br />"
			+ "<label><input type='radio' name='type' value='scancode_waitmsg' title='扫码推事件且弹出消息接收中提示框'>&nbsp;扫码带提示：填入关键字</label><br />"
			+ "<label><input type='radio' name='type' value='pic_photo_or_album' title='弹出拍照或者相册发图'>&nbsp;拍照或者相册发图：填入关键字</label><br />"
			+ "<label><input type='radio' name='type' value='pic_sysphoto' title='弹出系统拍照发图'>&nbsp;系统拍照发图：填入关键字</label><br />"
			+ "<label><input type='radio' name='type' value='pic_weixin' title='弹出微信相册发图器'>&nbsp;微信相册发图器：填入关键字</label><br />"
			+ "<label><input type='radio' name='type' value='location_select' title='弹出地理位置选择器'>&nbsp;发送位置：填入关键字</label>"
			+ "</div><input type='text' name='content' value='"
			+ content_
			+ "' class='input_text' style='width: 100%; margin-bottom: 10px;'><br /><input type='hidden' name='menuId' value='"
			+ menuId_
			+ "'><input type='button' value='保 存' onclick='updateMenuInfo();'>&nbsp;<span id='erromsg'></span></div>";
	$("#menu_right").html(html);
	optionDefaultSelect(document.getElementsByName("type"), type_);
}

function updateMenuInfo() {
	var menuId = document.getElementsByName("menuId")[0].value;
	var content = document.getElementsByName("content")[0].value;
	var type = $("input[name='type']:checked").val();

	if ($.trim(content) == "") {
		$("#erromsg").text("请填入内容！");
		return false;
	}

	var url = "/mngs/wxmn?ac=updateMenuInfo&token=<%=token%>";
	$.post(url, {
		menuId : menuId,
		content : content,
		type : type
	}, function(data) {
		if (data == "true") {
			$("#erromsg").text("提交成功！");
		} else {
			$("#erromsg").text("提交失败，请重试！");
		}
	});
}

function deleteMenu(menuId) {
	if (confirm("确认要删除？")) {
		var url = "/mngs/wxmn?ac=deleteMenu&token=<%=token%>";
		$.post(url, {
			menuId : menuId
		}, function(data) {
			window.location.reload();
		});
	}
}

function show_updateMenuRank_dialog(menuId) {
	var url = "/mngs/wxmn?ac=getMenuById&token=<%=token%>";
	$
			.post(
					url,
					{
						menuId : menuId
					},
					function(data) {
						var obj = $.parseJSON(data);
						if (obj != null && obj != "") {
							var html = "";
							$
									.each(
											obj,
											function(i, m) {
												html += "<li><input type='text' name='rank' value='"
														+ m.rank
														+ "' class='input_text' size='1' maxlength='2' style='text-align: center;'>"
														+ "<input type='hidden' name='rank_menuId' value='"
														+ m.menuId
														+ "'>&nbsp;&nbsp;&nbsp;&nbsp;"
														+ m.name + "</li>";
											});
							$("#menuRank ul").html(html);
							show_hide("menuRank");
						}
					});
}

function updateMenuRank(level) {
	var a_rank = document.getElementsByName("rank");
	var a_rank_menuId = document.getElementsByName("rank_menuId");

	var rank = "", rank_menuId = "";
	for ( var i = 0; i < a_rank.length; i++) {
		var rankValue = a_rank[i].value;
		var rankMenuIdValue = a_rank_menuId[i].value;

		if ($.isNumeric(rankValue)) {
			rank += rankValue + "|";
		} else {
			return false;
		}

		if ($.isNumeric(rankMenuIdValue)) {
			rank_menuId += rankMenuIdValue + "|";
		} else {
			return false;
		}
	}

	var url = "/mngs/wxmn?ac=updateMenuRank&token=<%=token%>";
	$.post(url, {
		rankMenuId : rank_menuId,
		rank : rank
	}, function(data) {
		window.location.reload();
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
					自定义菜单生成
					<div style="float: right">
						<a href="http://code.iamcal.com/php/emoji/" target="_blank">PHP Emoji</a>
						<a href="/mngs/wxmn?ac=index2&token=<%=token%>">方法二</a>
					</div>
				</div>
				<div style="padding: 20px;">

					<form method="post">
						<table width="100%" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td class="form_title">
									AppId
									<span class="myrequired">*</span>
								</td>
								<td>
									<input type="text" name="appId" value="<%=appId%>"
										class="input_text" size="50">
									<span class="textSpan"></span>
								</td>
							</tr>
							<tr>
								<td class="form_title">
									AppSecret
									<span class="myrequired">*</span>
								</td>
								<td>
									<input type="text" name="appSecret" value="<%=hideAppSecret%>"
										class="input_text" size="50">
									<span class="textSpan"></span>
								</td>
							</tr>
							<tr>
								<td colspan="2" style="padding: 10px 60px;">
									<table width="100%" cellpadding="0" cellspacing="0" border="1"
										bordercolor="#DDD" style="min-height: 400px">
										<tr bgcolor="#F4F5F9" height="30px">
											<td width="50%">
												菜单管理
												<div class="operate">
													<span class="glyphicon glyphicon-plus"
														onclick="show_add_update_MenuName_dialog('1','1',this);"
														title="新增一级菜单"></span>
												</div>
											</td>
											<td>
												动作设置
											</td>
										</tr>
										<tr valign="top">
											<td>
												<div id="menu_left">



													<!-- 
													<div class="oneMenu">
														<%for (int i = 0; i < 3; i++) {%>
														<div class="firstMenu">
															<div class="menuName">
																菜单名
															</div>
															<div class="operate">
																<span class="glyphicon glyphicon-plus"
																	onclick="show_add_update_MenuName_dialog('2','',this);"
																	title="新增二级菜单"></span>&nbsp;
																<span class="glyphicon glyphicon-pencil"
																	onclick="show_add_update_MenuName_dialog('3','',this);"
																	title="编辑菜单名称"></span>&nbsp;
																<span class="glyphicon glyphicon-resize-vertical"
																	onclick="show_updateMenuRank_dialog('11');"
																	title="设置顺序"></span>&nbsp;
																<span class="glyphicon glyphicon-trash"
																	onclick="deleteMenu('11');" title="删除该菜单"></span>
															</div>
															<div style="clear: both"></div>
														</div>
														<div class="secondMenu">
															<ul>
																<%for (int j = 0; j < 1; j++) {%>
																<li>
																	<div class="menuName">
																		菜单名
																	</div>
																	<div class="operate">
																		<span class="glyphicon glyphicon-pencil"
																			onclick="show_add_update_MenuName_dialog('4','',this);"
																			title="编辑菜单名称"></span>&nbsp;
																		<span class="glyphicon glyphicon-trash"
																			onclick="deleteMenu('11');" title="删除该菜单"></span>
																	</div>
																	<div style="clear: both"></div>
																</li>
																<%}%>
															</ul>
														</div>
														<%}%>
													</div>
													 -->






													<%
														List<WxMenu> wxMenus = (List<WxMenu>) request.getAttribute("wxMenus");
														int listSize = wxMenus == null ? 0 : wxMenus.size();
														for (int i = 0; i < listSize; i++) {
															WxMenu firstWxMenu = wxMenus.get(i);
															int firstWxMenuId = firstWxMenu.getMenuId();

															if (firstWxMenu.getParentId() == 1) {
													%>
													<div class="oneMenu">
														<div class="firstMenu">
															<div class="menuName"
																onclick="setMenuInfo('<%=firstWxMenuId%>');">
																<%=firstWxMenu.getName()%>
															</div>
															<div class="operate">
																<span class="glyphicon glyphicon-plus"
																	onclick="show_add_update_MenuName_dialog('2', '<%=firstWxMenuId%>',this);"
																	title="新增二级菜单"></span>&nbsp;
																<span class="glyphicon glyphicon-pencil"
																	onclick="show_add_update_MenuName_dialog('3','<%=firstWxMenuId%>',this);"
																	title="编辑菜单名称"></span>&nbsp;
																<span class="glyphicon glyphicon-sort-by-order"
																	onclick="show_updateMenuRank_dialog('<%=firstWxMenuId%>');"
																	title="设置菜单顺序"></span>&nbsp;
																<span class="glyphicon glyphicon-trash"
																	onclick="deleteMenu('<%=firstWxMenuId%>');"
																	title="删除该菜单"></span>
															</div>
															<div style="clear: both"></div>
														</div>
														<div class="secondMenu">
															<ul>
																<%
																	for (int j = 0; j < listSize; j++) {
																				WxMenu secondWxMenu = wxMenus.get(j);
																				int secondWxMenuId = secondWxMenu.getMenuId();

																				if (secondWxMenu.getParentId() == firstWxMenuId) {
																%>
																<li>
																	<div class="menuName"
																		onclick="setMenuInfo('<%=secondWxMenuId%>');">
																		<%=secondWxMenu.getName()%>
																	</div>
																	<div class="operate">
																		<span class="glyphicon glyphicon-pencil"
																			onclick="show_add_update_MenuName_dialog('4','<%=secondWxMenuId%>',this);"
																			title="编辑菜单名称"></span>&nbsp;
																		<span class="glyphicon glyphicon-trash"
																			onclick="deleteMenu('<%=secondWxMenuId%>');"
																			title="删除该菜单"></span>
																	</div>
																	<div style="clear: both"></div>
																</li>
																<%
																	}
																			}
																%>
															</ul>
														</div>
													</div>
													<%
														}
														}
													%>
												</div>
											</td>
											<td>
												<div id="menu_right">
													<div style="font-size: 14px; margin: 50px 20px;">
														先添加一个菜单，然后点击菜单名字，即可为其设置响应动作
													</div>
												</div>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="center">
									<input id="c_m" type="button" value="创建菜单" class="input_button"
										onclick="createMenu();">
									<div id="erromsg" style="display: inline;"></div>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>

		<!-- 新增一级菜单 -->
		<div class="screenShadow"></div>
		<div id="firstMenu_name" class="infoOfScreenCenter"
			style="padding: 50px;">
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
				<tr align="center">
					<td>
						<span style="font-size: 20px; font-weight: 700;">新增一级菜单</span>
						<br />
						<span class="textSpan">菜单名称名字不多于4个汉字或8个字母</span>
					</td>
				</tr>
				<tr>
					<td height="60px" align="center">
						<input type="text" name="firstMenu_name" class="input_text"
							style="width: 90%">
					</td>
				</tr>
				<tr>
					<td align="center">
						<input type="hidden" name="operateType1" value="">
						<input id="submit" type='button' value='提 交'
							class='input_button_special' style='width: 200px;'
							onclick='add_update_MenuName("1");'>
						&nbsp;&nbsp;&nbsp;
						<a href='javascript:show_hide();' style='vertical-align: bottom;'>取消</a>
					</td>
				</tr>
			</table>
		</div>

		<!-- 新增二级菜单 -->
		<div class="screenShadow"></div>
		<div id="secondMenu_name" class="infoOfScreenCenter"
			style="padding: 50px;">
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
				<tr align="center">
					<td>
						<span style="font-size: 20px; font-weight: 700;">新增二级菜单</span>
						<br />
						<span class="textSpan">菜单名称名字不多于8个汉字或16个字母</span>
					</td>
				</tr>
				<tr>
					<td height="60px" align="center">
						<input type="text" name="secondMenu_name" class="input_text"
							style="width: 90%">
					</td>
				</tr>
				<tr>
					<td align="center">
						<input type="hidden" name="operateType2" value="">
						<input id="submit" type='button' value='提 交'
							class='input_button_special' style='width: 200px;'
							onclick='add_update_MenuName("2");'>
						&nbsp;&nbsp;&nbsp;
						<a href='javascript:show_hide();' style='vertical-align: bottom;'>取消</a>
					</td>
				</tr>
			</table>
		</div>

		<!-- 排序设置 -->
		<div class="screenShadow"></div>
		<div id="menuRank" class="infoOfScreenCenter"
			style="padding: 20px 50px;">
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
				<tr align="center">
					<td>
						<span style="font-size: 20px; font-weight: 700;">设置菜单顺序</span>
					</td>
				</tr>
				<tr align="center">
					<td>
						<ul></ul>
					</td>
				</tr>
				<tr align="center">
					<td>
						<input id="submit" type='button' value='提 交'
							class='input_button_special' style='width: 200px;'
							onclick='updateMenuRank("2");'>
						&nbsp;&nbsp;&nbsp;
						<a href='javascript:show_hide();' style='vertical-align: bottom;'>取消</a>
					</td>
				</tr>
			</table>
		</div>

		<%@ include file="../common/foot.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>

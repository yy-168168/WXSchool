<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	String token = request.getParameter("token");
	Page p = (Page) request.getAttribute("page");
	String type = request.getParameter("type");
	if (type == null) {
		type = "1";
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>微接口 - 交易管理</title>

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
		<script type="text/javascript">
function check() {
	var mn = syncSubmit("/mngs/bns?ac=getmn&token=<%=token%>&type=<%=type%>");
	if (mn == "overMaxNum") {
		showNotice("你已经达到每人配额上限(包括已删除物品)，如需增加配额，请联系微信yy_168168额外申请。");
	} else {
		location.href = "/mngs/bns?ac=addGsU_&token=<%=token%>&type=<%=type%>";
	}
}

function delete_(id) {
	syncSubmit("/mngs/bns?ac=deleteGs&token=<%=token%>&gsId=" + id);
	window.location.reload();
}

$(function() {
	var type = <%=type%>;
	$(".title .item:nth-child(" + type + ")").css("background-color", "#FFF");
});
</script>
	</head>

	<body>
		<jsp:include page="head.jsp"></jsp:include>

		<div class="content">
			<div class="title" style="border-top-left-radius: 5px;">
				<div class="item"
					onclick="location='/mngs/bns?ac=listU&token=<%=token%>&type=1'">
					二手交易
				</div>
				<div class="item"
					onclick="location='/mngs/bns?ac=listU&token=<%=token%>&type=2'">
					格子铺
				</div>
				<span style="font-size: 14px; color: #555;"></span>
				<div style="float: right">
					<a href="javascript:window.location.reload();">刷新</a>
				</div>
			</div>

			<div class="list">
				<table width="100%" cellpadding="0" cellspacing="0" id="sortTable">
					<thead>
						<tr bgcolor="#F1F1F1">
							<th width="8%">
								编号
							</th>
							<th>
								简要描述
							</th>
							<th width="8%">
								价格
							</th>
							<%
								if (type.equals("1")) {
							%>
							<th width="8%">
								新旧
							</th>
							<%
								}
							%>
							<th width="8%">
								浏览量
							</th>
							<th width="9%">
								类别
							</th>
							<th width="15%">
								上传/更新时间
							</th>
							<th width="10%">
								操作
							</th>
						</tr>
					</thead>
					<%
						List<Goods> goodses = (List<Goods>) request.getAttribute("goodses");
						for (int i = 0; goodses != null && i < goodses.size(); i++) {
							Goods goods = goodses.get(i);
					%>
					<tr align="center">
						<td>
							No.<%=(p.getCurPage() - 1) * p.getEveryPage() + i + 1%>
						</td>
						<td align="left">
							<%=goods.getSimDesc()%>
						</td>
						<td>
							￥<%=goods.getPrice()%>
						</td>
						<%
							if (type.equals("1")) {
						%>
						<td>
							<%
								String[] olds = { "五成", "六成", "七成", "八成", "九成", "全新" };
							%>
							<%=olds[goods.getOld() - 5]%>
						</td>
						<%
							}
						%>
						<td>
							<%=goods.getVisitPerson()%>
						</td>
						<td>
							<%
								String[][] cates = {
											{ "", "生活用品", "电子产品", "书籍资料", "鞋包服装", "运动户外", "", "",
													"", "", "其它" },
											{ "", "鞋包服装", "护肤彩妆", "美食特产", "日用百货", "珠饰镜表", "电子产品",
													"", "", "", "其它" } };
							%>
							<%=cates[goods.getType() - 1][goods.getCate()]%>
						</td>
						<td>
							<%=goods.getPubTime()%><br /><%=goods.getUptTime()%>
						</td>
						<td>
							<%
								int status = goods.getStatus();
									if (status == -1) {
							%>
							已删除
							<%
								} else {
							%>
							<a
								href="/mngs/bns?ac=getGsU&token=<%=token%>&gsId=<%=goods.getGoodsId()%>">编辑</a>
							<a href="javascript:delete_('<%=goods.getGoodsId()%>');">删除</a>
							<%
								}
							%>


						</td>
					</tr>
					<%
						}
					%>
				</table>

				<div style="margin-top: 15px;">
					<input type="button" value="新增物品" class="input_button"
						onclick="check();">
					<div style="float: right;">
						<jsp:include page="/mng/page.jsp">
							<jsp:param value="/mngs/bns" name="loc" />
						</jsp:include>
					</div>
					<div style="clear: both;"></div>
				</div>
			</div>
		</div>
		<%@ include file="../common/foot.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>

<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath_nop = request.getScheme() + "://"
			+ request.getServerName();
	String basePath = basePath_nop + ":" + request.getServerPort()
			+ path + "/";

	String token = request.getParameter("token");
	String type = request.getParameter("type");
	if (type == null) {
		type = "1";
	}
	String title = "", p_url = "";
	if (type.equals("1")) {
		title = "二手交易";
		p_url = "自定义回复二手交易地址链接：/bns?ac=list&type=1";
	} else if (type.equals("2")) {
		title = "格子铺管理";
		p_url = "自定义回复格子铺地址链接：/bns?ac=list&type=2";
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

		<script type="text/javascript">
function delete_(id) {
	syncSubmit("/mngs/bns?ac=deleteGs&token=<%=token%>&gsId=" + id);
	window.location.reload();
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
					<%=title%>
					<div style="float: right">
						<a href="javascript:window.location.reload();">刷新</a>
					</div>
				</div>
				<div class="list">
					<div
						style="margin-bottom: 15px; border-radius: 5px; padding: 8px 10px; background-color: #eee;">
						<%=p_url%>
					</div>
					<table width="100%" cellpadding="0" cellspacing="0" id="sortTable">
						<thead>
							<tr bgcolor="#F1F1F1">
								<th>
									简要描述
								</th>
								<th width="9%">
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
								<th width="8.5%">
									浏览量
								</th>
								<th width="11%">
									类别
								</th>
								<th width="18%">
									上传/更新时间
								</th>
								<th width="12%">
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
								<a
									href="/mngs/bns?ac=getGs&token=<%=token%>&gsId=<%=goods.getGoodsId()%>">编辑</a>
								<a href="javascript:delete_('<%=goods.getGoodsId()%>');">删除</a>
							</td>
						</tr>
						<%
							}
						%>
					</table>

					<div style="margin-top: 15px;">
						<div style="float: right;">
							<jsp:include page="/mng/page.jsp">
								<jsp:param value="/mngs/bns" name="loc" />
							</jsp:include>
						</div>
						<div style="clear: both;"></div>
					</div>
				</div>
			</div>
		</div>

		<%@ include file="../common/foot.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>

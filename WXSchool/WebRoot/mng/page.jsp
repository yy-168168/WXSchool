<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	Enumeration<String> em = request.getParameterNames();
	String url = "";

	while (em != null && em.hasMoreElements()) {
		String name = em.nextElement();
		String value = request.getParameter(name);

		if (name.equals("loc")) {
			if (url.equals("")) {
				url = value;
			} else if (value.indexOf("?") > 0) {
				url = value + "&" + url.substring(1);
			} else {
				url = value + "?" + url.substring(1);
			}
		} else if (!name.equals("c_p")) {
			url += "&" + name + "=" + value;
		}
	}

	Page p = (Page) request.getAttribute("page");
	int curPage = 1;
	int totalPage = 0;
	int pageStyle = 1;
	boolean hasNext = false;
	if (p != null) {
		curPage = p.getCurPage();
		totalPage = p.getTotalPage();
		hasNext = p.isHasNext();
		pageStyle = p.getPageStyle();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>分页</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">

		<script type="text/javascript">
var curPage = parseInt('<%=curPage%>');
var totalPage = parseInt('<%=totalPage%>');
var hasNext = ('<%=hasNext%>');

function paging(but) {
	var targetPage;
	if (but == 'first') {
		if (curPage <= 1) {
			return false;
		} else {
			targetPage = 1;
		}
	}
	if (but == 'pre') {
		if (curPage < 2) {
			return false;
		} else {
			targetPage = curPage - 1;
		}
	}
	if (but == 'next') {
		if (curPage < totalPage || hasNext == 'true') {
			targetPage = curPage + 1;
		} else {
			return false;
		}
	}
	if (but == 'end') {
		if (curPage >= totalPage) {
			return false;
		} else {
			targetPage = totalPage;
		}
	}
	if (but == 'npage') {
		var npage = document.getElementsByName("npage")[0].value;
		if ($.trim(npage) == '' || isNaN(npage)) {
			return false;
		} else if (npage < 1) {
			return false;
		} else {
			targetPage = parseInt(npage);
		};
	}

	var url = '<%=url%>';
	if (url.indexOf("?") > 0) {
		window.location.href = url + "&c_p=" + targetPage;
	} else {
		window.location.href = url + "?&c_p=" + targetPage;
	}
	return false;
}
</script>
	</head>

	<body>
		<%if(pageStyle == 1){%><input type="button" value="首页" onclick="return paging('first');"><%} %>
		<input type="button" value="上一页" onclick="return paging('pre');">
		
		第<%=curPage%>页<%if(pageStyle == 1){%>/共<%=totalPage%>页<%} %>
		
		<input type="button" value="下一页" onclick="return paging('next');">
		<%if(pageStyle == 1){%><input type="button" value="尾页" onclick="return paging('end');"><%} %>
		<form style="padding: 0; margin: 0; display: inline;">
			<input type="text" size="2" name="npage" maxlength="6" align="middle"
				style="text-align: center;">
			<input type="submit" value="跳转" onclick="return paging('npage');">
		</form>
	</body>
</html>

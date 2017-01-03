<%@ page language="java" import="java.util.*" pageEncoding="utf-8"
	contentType="text/html; charset=utf-8"%>
<%
	response.setContentType("text/html; charset=utf-8");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String px = request.getParameter("px");
	String py = request.getParameter("py");
	String tar = request.getParameter("tar");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>周边搜索</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="viewport"
			content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<link type="image/x-icon" rel="shortcut icon" href="static_/favicon.ico" />
		<script type="text/javascript" src="/static_/jquery-1.8.2.min.js">
</script>
		<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.5&ak=8079e888ed39985d6c2869d64af2ae2f">
</script>

		<style type="text/css">
#allmap {
	width: 100%;
	height: 92%;
	margin: 5px 0 0 0;
}

#query {
	height: 28px;
	width: 30.5%;
}

#show {
	height: 28px;
	width: 68%;
	float: right;
}
</style>
		<script type="text/javascript">
var pCenter;
var map;
var json;
var walk;

$(function() {
	var px = '<%=px%>';
	var py = '<%=py%>';
	var tar = '<%=tar%>';
	initMap(px, py);
	showSelectAndAll(px, py, tar);

	$("#query").change(function() {
		var query = $("#query option:selected").val();
		showSelectAndAll(px, py, query);
	});

	$("#show").change(function() {
		var i = $("#show option").index($("#show option:selected"));
		if (i != 0) {
			showLine(json.results, (i - 1));
		}
	});
});

function initMap(px, py) {
	pCenter = new BMap.Point(py, px);
	map = new BMap.Map("allmap");
	map.centerAndZoom(pCenter, 15);
	map.addControl(new BMap.NavigationControl( {
		anchor : BMAP_ANCHOR_BOTTOM_RIGHT,
		type : BMAP_NAVIGATION_CONTROL_ZOOM
	}));
	walk = new BMap.WalkingRoute(map, {
		renderOptions : {
			map : map,
			autoViewport : true
		}
	});
}

function showSelectAndAll(px, py, tar) {
	map.clearOverlays();
	$.ajax( {
		type : "get",
		url : "/mobile/map",
		data : "px=" + px + "&py=" + py + "&tar=" + tar,
		success : function(msg) {
			json = eval("(" + msg + ")");
			if (json == 'wrong') {
				$("#allmap").text("显示地图出错，请稍后重试");
			} else {
				showSelect(json.results);
				addMarkers(json);
			}
		}
	});
}

function showSelect(rs) {
	var op;
	var minZoom = 18;
	$("#show").empty();
	$("#show").append("<option>请选择具体位置</option>");
	$.each(rs, function(i, r) {
		op = new BMap.Point(r.lng, r.lat);
		r.distance = parseInt(map.getDistance(pCenter, op));
		$("#show").append(
				"<option>" + (String.fromCharCode(65 + i)) + r.name + "(约"
						+ r.distance + "米 )" + "</option>");

		var curZoom = zoom(r.distance);
		if (curZoom < minZoom) {
			minZoom = curZoom;
		}
	});
	map.setZoom(minZoom);
	map.panTo(pCenter);
}

//缩放级别
function zoom(dis) {
	var zoom;
	if (dis < 300) {
		zoom = 18;
	} else if (dis < 600) {
		zoom = 17;
	} else if (dis < 1200) {
		zoom = 16;
	} else if (dis < 2000) {
		zoom = 15;
	} else if (dis < 4500) {
		zoom = 14;
	} else if (dis < 8000) {
		zoom = 13;
	} else {
		zoom = 12;
	}
	return zoom;
}

//显示线路
function showLine(rs, i) {
	var pl = new BMap.Point(rs[i].lng, rs[i].lat);
	walk.search(pCenter, pl);
	walk.setMarkersSetCallback(function(pois) {
		pois[0].title = "您当前所在位置";
		pois[1].title = rs[i].address + "<br/>" + rs[i].name;
	});
}

//添加标注
function addMarkers(j) {
	var iw = 29;
	//设置当前所在地标注
	var icon = new BMap.Icon("static_/markers.png", new BMap.Size(iw, 35));
	icon.setImageOffset(new BMap.Size(-66, -156));
	var poi = new BMap.Point(j.lng, j.lat);
	addMarker(poi, icon);

	//设置搜索位置的标注
	icon = new BMap.Icon("static_/markers.png", new BMap.Size(iw, 30));
	$.each(j.results, function(i, rp) {
		icon.setImageOffset(new BMap.Size(-iw * i, 0));
		poi = new BMap.Point(rp.lng, rp.lat);
		addMarker(poi, icon);
	});
}

function addMarker(poi, icon) {
	var marker = new BMap.Marker(poi);
	marker.setIcon(icon);
	map.addOverlay(marker);
}
</script>
	</head>

	<body bgcolor="#F3F1DA">
		<div>
			<select id="query">
				<option value="公共厕所">
					公共厕所
				</option>
				<option value="银行">
					银行
				</option>
				<option value="网吧">
					网吧
				</option>
				<option value="商城">
					超市
				</option>
				<option value="酒店">
					酒店
				</option>
				<option value="商场">
					商场
				</option>
				<option value="火车票代售点">
					火车票代售点
				</option>
				<option value="旅游景点">
					旅游景点
				</option>
				<option value="公交站">
					公交站
				</option>
				<option value="地铁站">
					地铁站
				</option>
				<option value="麦当劳">
					麦当劳
				</option>
				<option value="肯德基">
					肯德基
				</option>
				<option value="德克士">
					德克士
				</option>
			</select>
			<select id="show"></select>
		</div>
		<div id="allmap"></div>
	</body>
</html>

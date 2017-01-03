$(function() {
	$(".content").css('height', document.body.clientHeight - 75 - 40 - 40);
	
	$("input[type='text']").click(function() {
		$("#erromsg").text("");
		$(".erromsg").text("");
	});
});

function syncSubmit(url) {
	var xhr;
	if (window.ActiveXObject) {
		xhr = new ActiveXObject('Microsoft.XMLHTTP');
	} else if (window.XMLHttpRequest) {
		xhr = new XMLHttpRequest();
	}

	xhr.open('POST', url, false);
	xhr.send(null);
	return xhr.responseText;
}

function showNotice(text) {
	if ($("#showNotice").length == 0) {
		var div = "<div id='showNotice'></div>";
		$(div).appendTo("body");
	}
	$("#showNotice").text(text);
	$("#showNotice").css("top", (document.body.clientHeight / 2 - 70));
	$("#showNotice").fadeIn(1000).delay(1500).fadeOut(1500);
}

function optionDefaultSelect(obj, val) {
	$.each(obj, function(i, n) {
		if (n.value == val) {
			n.selected = "selected";
			n.checked = "checked";
		}
	});
}

function goonAdd() {
	document.getElementsByTagName('form')[0].reset();
	$(".input_button").attr("disabled", false);
	$(".input_button").val("保存");
	window.location.reload();
}

function isGoonUpt() {
	$("body").append(
			"<div class='screenShadow'></div>"
					+ "<div id='goonAdd' class='infoOfScreenCenter'"
					+ " style='margin-top: -120px'>"
					+ "<div style='padding: 30px 60px 50px'>"
					+ "<input type='button' value='继续添加'	"
					+ "onclick='goonAdd();' " + "class='input_button_special'>"
					+ "<input type='button' value='完 成'	 "
					+ "onclick='location=document.referrer;' "
					+ "class='input_button_special'></div></div>");
	show_hide('goonAdd');
}

function show_hide(id) {
	var display = $(".screenShadow").css("display");
	if (display == 'none') {
		$(".screenShadow").slideDown();
		$("#"+id).slideDown();
	} else {
		$(".screenShadow").slideUp();
		$(".infoOfScreenCenter").slideUp();
	}
}

function bigImg(obj, token, wxaccount, userwx){
	$.get("/mngs/user?ac=updateWxUserInfo&token="+token+"&wxaccount="+wxaccount+"&userwx="+userwx);
	var imgUrl = obj.src;
	var img_i = imgUrl.lastIndexOf('/');
	if(img_i > -1){
		imgUrl = imgUrl.substring(0, img_i)+ "/0";
	}
	window.open(imgUrl);
}

function insertBlack(token, userwx, cate){
	var url = "/mngs/black?ac=add&token="+token+"&userwx="+userwx+"&cate="+cate;
	$.post(url, function(data){
		if(data == "true"){
			showNotice("拉黑成功");
		}else{
			showNotice("操作失败");
		}
	});
}

var dataTimeInfo = {
				timeFormat : "HH:mm",
				dateFormat : "yy-mm-dd",
				prevText : '上月',
				nextText : '下月',
				closeText : '关闭',
				currentText : '现在',
				monthNames : [ '一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月',
						'九月', '十月', '十一月', '十二月' ],
				monthNamesShort : [ '一', '二', '三', '四', '五', '六', '七', '八',
						'九', '十', '十一', '十二' ],
				dayNames : [ '星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六' ],
				dayNamesShort : [ '周日', '周一', '周二', '周三', '周四', '周五', '周六' ],
				dayNamesMin : [ '日', '一', '二', '三', '四', '五', '六' ],
				weekHeader : '周',
				firstDay : 1,
				showMonthAfterYear : true,
				yearSuffix : '年',
				timeOnlyTitle : '选择时间',
				timeText : '时间',
				hourText : '时',
				minuteText : '分',
				secondText : '秒',
				millisecText : '微秒',
				timezoneText : '时区',
				amNames : [ 'AM', 'A' ],
				pmNames : [ 'PM', 'P' ],
				isRTL : false
			};
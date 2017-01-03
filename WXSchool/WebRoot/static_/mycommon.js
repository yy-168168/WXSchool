function paging(but, scurPage, stotalPage, url) {
	var curPage = parseInt(scurPage);
	var totalPage = parseInt(stotalPage);
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
		if (curPage >= totalPage) {
			return false;
		} else {
			targetPage = curPage + 1;
		}
	}
	if (but == 'end') {
		if (curPage >= totalPage) {
			return false;
		} else {
			targetPage = totalPage;
		}
	}
	window.location.href = url + "&c_p=" + targetPage;
}

function setPersonIdAndPassword(w, u){
	if(w == null || u == null || w == 'null' || u == 'null'){
		return false;
	}
	
	var url = "mobile/stu?ac=getStuForScore&wxaccount="+w+"&userwx="+u;
	$.get(url, function(data){
		var obj = null;
		try{
			obj = $.parseJSON(data);
		}catch(e){
		}
		
		var psId = "", pwd = "";
		if(obj != null && obj.personId != null){
			psId = obj.personId;
			pwd = obj.password;
		}
		document.getElementsByName("username")[0].value = psId;
		document.getElementsByName("password")[0].value = pwd;
	});
}

function showNotice(text) {
	if ($("#showNotice").length == 0) {
		var div = "<div id='showNotice'></div>";
		$(div).appendTo("body");
		// $("#showNotice").css("top", (document.body.scrollTop + document.body.clientHeight / 2));
	}
	$("#showNotice").html(text);
	$("#showNotice").fadeIn(800).delay(1500).fadeOut(500);
}

function updateTopicVisitPerson(wxaccount, topicId) {
	if (wxaccount == null || wxaccount == 'null' || topicId == null
			|| topicId == 'null') {
		return false;
	}
	var url = "/mobile/topic?ac=updatePersonNum&wxaccount=" + wxaccount + "&topicId="
			+ topicId;
	$.get(url);
}

function updateArticleVisitPerson(wxaccount, aId) {
	if(wxaccount == null || wxaccount == 'null' || aId == null || aId == 'null'){
		return false;
	}
	var url ="/mobile/article?ac=updateVisitPerson&wxaccount=" + wxaccount + "&aId=" + aId;
	$.get(url);
}

function getArticleVisitPerson(wxaccount, aId) {
	if(wxaccount == null || wxaccount == 'null' || aId == null || aId == 'null'){
		return 0;
	}
	var url ="/mobile/article?ac=getVisitPerson&wxaccount=" + wxaccount + "&aId=" + aId;
	var xhr;
	if (window.ActiveXObject) {
		xhr = new ActiveXObject('Microsoft.XMLHTTP');
	} else if (window.XMLHttpRequest) {
		xhr = new XMLHttpRequest();
	}

	xhr.open('GET', url, false);
	xhr.send(null);
	return xhr.responseText;
}

function getTopic(wxaccount, topicId) {
	if (wxaccount == null || wxaccount == 'null' || topicId == null
			|| topicId == 'null') {
		return null;
	}
	var url = "/mobile/topic?ac=getTopic_JSON&wxaccount=" + wxaccount + "&topicId=" + topicId;
	var xhr;
	if (window.ActiveXObject) {
		xhr = new ActiveXObject('Microsoft.XMLHTTP');
	} else if (window.XMLHttpRequest) {
		xhr = new XMLHttpRequest();
	}

	xhr.open('GET', url, false);
	xhr.send(null);
	return xhr.responseText;
}

function checkInDiv(x, y) {
	var left = $("#bar_menu").offset().left;
	var top = $("#bar_menu").offset().top;
	var width = $("#bar_menu").width();
	var height = $("#bar_menu").height();
	if (x >= left && x <= (left + width) && y >= top && y <= (top + height)) {
		return true;
	}
	return false;
}

function hideMenu(e){
	var display = $("#bar_menu").css("display");
		if (display == "block") {
			 var tar = e.target.id;
			if (tar != "showMenu" && tar != "showMenu_") {
				var x = e.clientX;
				var y = e.clientY;
				var rs = checkInDiv(x, y);
				if (rs == false) {
					$("#bar_menu").slideUp();
				}
			}
		}
}

function showMenu(){
	var display = $("#bar_menu").css("display");
		if (display == "none") {
			$("#bar_menu").slideDown();
		} else {
			$("#bar_menu").slideUp();
		}
}

function menuClick(obj,url){
	obj.style.backgroundColor = '#050505';
	window.location.href = url;
}

function resetAll() {
	document.form.reset();
}

function clearMsg() {
	$("#msg").text("");
}

function checkMM() {
	
}

function checkMM_new() {
	var browser = {
		versions : function() {
			var u = navigator.userAgent, app = navigator.appVersion;
			return {
				trident : u.indexOf('Trident') > -1, //IE内核
				presto : u.indexOf('Presto') > -1, //opera内核
				webKit : u.indexOf('AppleWebKit') > -1, //苹果、谷歌内核
				symbian : u.indexOf('Symbian') > -1, //塞班系统
				gecko : u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1, //火狐内核
				mobile : !!u.match(/AppleWebKit.*Mobile/)
						|| !!u.match(/Windows Phone/) || !!u.match(/Android/)
						|| !!u.match(/MQQBrowser/),
				ios : !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
				android : u.indexOf('Android') > -1 || u.indexOf('Linux') > -1, //android终端或者uc浏览器
				iPhone : u.indexOf('iPhone') > -1 || u.indexOf('Mac') > -1, //是否为iPhone或者QQHD浏览器
				iPad : u.indexOf('iPad') > -1, //是否iPad
				webApp : u.indexOf('Safari') == -1 //是否web应该程序，没有头部与底部
			};
		}()
	};

	if (browser.versions.ios == true || browser.versions.android == true
			|| browser.versions.iPhone == true || browser.versions.iPad == true
			|| browser.versions.mobile == true) {
	}else{
		$.get("/mobile/log?ac=webIllegal",{content:navigator.userAgent});
		window.location.href = '/common/error_mobile.html';
	}
}

function showScreenNotice_text(text, align){
	$("#showScreenNotice_text").remove();
	var sn= "<div class='screenNotice' id='showScreenNotice_text' onclick='hideScreenNotice();'><table width='100%' height='100%' border=0 style='color:#fff;'><tr height='70%' align="+align+"><td style='padding:0 30px'>"+text+"</td></tr><tr align='center' valign=top><td><input type='button' value='知道了' style='color: #fff;background-color: #000;border: 1px solid #fff;border-radius: 5px;width: 120px;height: 35px;'></td></tr></table></div>";
	$("body").append(sn);
	$("#showScreenNotice_text").slideDown();
}

function showScreenNotice_img(src){
	// $("#bar_menu").hide();
	$("#showScreenNotice_img").remove();
	var sn = "<div class='screenNotice' id='showScreenNotice_img' onclick='hideScreenNotice();'><table width='100%' height='100%' border=0 style='color:#fff;'><tr height='70%' align='right' valign='top'><td><img src='"+src+"' /></td></tr><tr align='center' valign=top><td><input type='button' value='知道了' style='color: #fff;background-color: #000;border: 1px solid #fff;border-radius: 5px;width: 120px;height: 35px;'></td></tr></table></div>";
	$("body").append(sn);
	$("#showScreenNotice_img").slideDown();
}

function hideScreenNotice(){
	$(".screenNotice").slideUp();
	// $(".screenNotice").hide();
}

function optionDefaultSelect(obj, val) {
	$.each(obj, function(i, n) {
		if (n.value == val) {
			n.selected = "selected";
		}
	});
}

function replace_em(str){
	str = str.replace(/\</g,'&lt;');
	str = str.replace(/\>/g,'&gt;');
	str = str.replace(/\n/g,'<br/>');
	str = str.replace(/\[em_([0-9]*)\]/g,'<img height="15px" src="static_/qqface/$1.gif" border="0" />');
	return str;
}

function addCookie(name, value, expiresMins){
	var cookieString = name+"="+escape(value);
	if(expiresMins != null){
		var date=new Date();
		date.setTime(date.getTime() + expiresMins*60*1000);
		cookieString = cookieString+";expires="+date.toGMTString();
	}
	document.cookie = cookieString;
}

function getCookie(name){
	var strCookie = document.cookie;
	var arrCookie = strCookie.split(";");
	for(var i = 0; i < arrCookie.length; i++){
		var arr = arrCookie[i].split("=");
		if(arr[0].replace(/^\s+|\s+$/g,"")==name){
			return unescape(arr[1]);
		}
	}
	return "";
} 

function screenImg(obj){
	if ($("#bigImgLayer").length == 0) {
		var div = "<div id='bigImgLayer' class='screenNotice' style='opacity: 1' onclick='hideScreenNotice()'>"
			+"<table width='100%' height='100%' cellpadding='0' cellspacing='0'><tr>"
			+"<td align='center'><img alt='' src=''></td></tr></table>"
			+"<div style='position: fixed; z-index: 100; bottom: 100px; left: 50%; margin-left: -40px; font-size: 13px; color: #fff; "
			+"background-color: #000; padding: 6px 15px; border-radius: 5px;'>轻触退出</div></div>";
		$(div).appendTo("body");
	}
	$("#bigImgLayer table img").attr("src", obj.src);
	
	var clientHeight = document.body.clientHeight;
	if($(obj).height() > clientHeight*0.9){
		$("#bigImgLayer table img").css("height", (clientHeight*0.9));
		$("#bigImgLayer table img").css("width", "");
	}else{
		$("#bigImgLayer table img").css("width", "100%");
		$("#bigImgLayer table img").css("height", "");
	}
	
	$("#bigImgLayer").slideDown();
}

function vote(obj, type, topicId, userwx, wxaccount, token){
	var id = $(obj).parent().attr("id");
	if (flagId != id) {
		flagId = id;
		var url = "mobile/vote?ac=addSupportNum";
		if(type == "oppose"){
			url = "/mobile/vote?ac=incOpposeNum";
		}
		$.get(url, {
			topicId : topicId,
			voteId : id,
			userwx : userwx,
			wxaccount : wxaccount,
			token : token
		}, function(data) {
			if (data == 'yes') {
				var $span;
				if(type == "oppose"){
					$span = $(obj).find("#on");
				}else{
					$span = $(obj).find("#sn");
				}
				var num = parseInt($span.text());
				$span.text(num + 1);
				$(obj).css("color", "red");
			}else if(data == 'expire'){
				showNotice('活动已过期');
			}else if(data == 'wrong'){
				showNotice('出错啦');
			}else if(data == 'hasVote'){
				showNotice('今天已投过啦');
			}
		});
	}
}

//状态提示框-加载
function weui_loadingToast(msg){
	if ($("#loadingToast").length == 0) {
		var html = '<div id="loadingToast" class="weui_loading_toast" style="display:none;">'
				    +'<div class="weui_mask_transparent"></div>'
				    +'<div class="weui_toast">'
				        +'<div class="weui_loading">'
				            +'<div class="weui_loading_leaf weui_loading_leaf_0"></div>'
				            +'<div class="weui_loading_leaf weui_loading_leaf_1"></div>'
				            +'<div class="weui_loading_leaf weui_loading_leaf_2"></div>'
				            +'<div class="weui_loading_leaf weui_loading_leaf_3"></div>'
				            +'<div class="weui_loading_leaf weui_loading_leaf_4"></div>'
				            +'<div class="weui_loading_leaf weui_loading_leaf_5"></div>'
				            +'<div class="weui_loading_leaf weui_loading_leaf_6"></div>'
				            +'<div class="weui_loading_leaf weui_loading_leaf_7"></div>'
				            +'<div class="weui_loading_leaf weui_loading_leaf_8"></div>'
				            +'<div class="weui_loading_leaf weui_loading_leaf_9"></div>'
				            +'<div class="weui_loading_leaf weui_loading_leaf_10"></div>'
				            +'<div class="weui_loading_leaf weui_loading_leaf_11"></div>'
				        +'</div>'
				        +'<p class="weui_toast_content" id="weui_msg"></p>'
				    +'</div>'
				+'</div>';
		$(html).appendTo("body");
	}
	$("#loadingToast #weui_msg").text(msg);
	$("#loadingToast").show();
}

//消息弹出框
function weui_dialogAlert(msg, type, callback){
	var typeCode = '';
	switch(type){
		case 'info': typeCode = '<i class="weui_icon_msg weui_icon_info"></i>'; break;
		case 'warn': typeCode = '<i class="weui_icon_msg weui_icon_warn"></i>'; break;
		case 'waiting': typeCode = '<i class="weui_icon_msg weui_icon_waiting"></i>'; break;
		default: typeCode = '<i class="weui_icon_msg weui_icon_success"></i>';
	}
	
	if ($("#dialog2").length == 0) {
		var html = '<div class="weui_dialog_alert" id="dialog2" style="display:none;">'
		    +'<div class="weui_mask"></div>'
		    +'<div class="weui_dialog">'
		        +'<div class="weui_dialog_hd"><strong class="weui_dialog_title">'+typeCode+'</strong></div>'
		        +'<div class="weui_dialog_bd" id="weui_msg"></div>'
		        +'<div class="weui_dialog_ft">'
		            +'<a href="javascript:weui_dialogAlert_callBack(\''+callback+'\')" class="weui_btn_dialog primary">确定</a>'
		        +'</div>'
		    +'</div>'
		+'</div>';
	$(html).appendTo("body");
	}
	$("#dialog2 #weui_msg").text(msg);
	$("#dialog2").show();
}

function weui_dialogAlert_callBack(callback){
	if(callback == 'exit'){
		WeixinJSBridge.invoke('closeWindow', {}, function(res) {
			//alert(res.err_msg);
		});
	}else if(callback == 'hide'){
		$('#dialog2').hide();
	}
}

//表单检测并报错
function weui_checkForm(){
	var isValid = true;
	$(".weui_cell").each(function(){
		var $weui_input = $(this).find(".weui_input");
		if($.trim($weui_input.val()) == ""){
			$(this).addClass("weui_cell_warn");
			isValid = false;
		}
	}).on("click", function(){
		$(this).removeClass("weui_cell_warn");
	});
	return isValid;
}
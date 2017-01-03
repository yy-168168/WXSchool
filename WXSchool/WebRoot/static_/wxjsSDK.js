/**
 * 
 */

function initJsSDK(wxaccount, userwx) {
	var wxSign = {
		appId : '',
		timestamp : '',
		nonceStr : '',
		signature : ''
	};
	
	//获取验证参数
	$.ajax({
		url : "mobile/other?ac=wxSign",
		data : {
			wxaccount : wxaccount,
			userwx : userwx,
			pageUrl : window.location.toString()
		},
		async : false,
		type : 'POST',
		success : function(data) {
			var obj = $.parseJSON(data);
			wxSign.appId = obj[0];
			wxSign.timestamp = obj[1];
			wxSign.nonceStr = obj[2];
			wxSign.signature = obj[3];
		}
	});

	//验证
	wx.config({
		debug : false,
		appId : wxSign.appId,
		timestamp : wxSign.timestamp,
		nonceStr : wxSign.nonceStr,
		signature : wxSign.signature,
		jsApiList : [ 'checkJsApi', 'onMenuShareTimeline',
				'onMenuShareAppMessage', 'onMenuShareQQ', 'onMenuShareWeibo',
				'onMenuShareQZone', 'hideMenuItems', 'showMenuItems',
				'hideAllNonBaseMenuItem', 'showAllNonBaseMenuItem',
				'translateVoice', 'startRecord', 'stopRecord',
				'onVoiceRecordEnd', 'playVoice', 'onVoicePlayEnd',
				'pauseVoice', 'stopVoice', 'uploadVoice', 'downloadVoice',
				'chooseImage', 'previewImage', 'uploadImage', 'downloadImage',
				'getNetworkType', 'openLocation', 'getLocation',
				'hideOptionMenu', 'showOptionMenu', 'closeWindow',
				'scanQRCode', 'chooseWXPay', 'openProductSpecificView',
				'addCard', 'chooseCard', 'openCard' ]
	});
}

//分享到朋友圈
function shareTimeline(shareData){
	wx.onMenuShareTimeline({
		title: shareData.title, // 分享标题
	    link: shareData.link, // 分享链接
	    imgUrl: shareData.imgUrl, // 分享图标
	    success: function () { 
	        // 用户确认分享后执行的回调函数
	    },
	    cancel: function () { 
	        // 用户取消分享后执行的回调函数
	    }
	});
}

//发送给朋友
function shareAppMessage(shareData){
	wx.onMenuShareAppMessage({
		title: shareData.title, // 分享标题
	    link: shareData.link, // 分享链接
	    imgUrl: shareData.imgUrl, // 分享图标
	    desc: shareData.desc, // 分享描述
	    type: '', // 分享类型,music、video或link，不填默认为link
	    dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
	    success: function () { 
	        // 用户确认分享后执行的回调函数
	    },
	    cancel: function () { 
	        // 用户取消分享后执行的回调函数
	    }
	});
}

//分享到QQ
function shareQQ(shareData){
	wx.onMenuShareQQ({
		title: shareData.title, // 分享标题
	    link: shareData.link, // 分享链接
	    imgUrl: shareData.imgUrl, // 分享图标
	    desc: shareData.desc, // 分享描述
	    success: function () { 
	       // 用户确认分享后执行的回调函数
	    },
	    cancel: function () { 
	       // 用户取消分享后执行的回调函数
	    }
	});
}

//分享到腾讯微博
function shareWeibo(shareData){
	wx.onMenuShareWeibo({
		title: shareData.title, // 分享标题
	    link: shareData.link, // 分享链接
	    imgUrl: shareData.imgUrl, // 分享图标
	    desc: shareData.desc, // 分享描述
	    success: function () { 
	       // 用户确认分享后执行的回调函数
	    },
	    cancel: function () { 
	        // 用户取消分享后执行的回调函数
	    }
	});
}

//分享到QQ空间
function shareQZone(shareData){
	wx.onMenuShareQZone({
		title: shareData.title, // 分享标题
	    link: shareData.link, // 分享链接
	    imgUrl: shareData.imgUrl, // 分享图标
	    desc: shareData.desc, // 分享描述
	    success: function () { 
	       // 用户确认分享后执行的回调函数
	    },
	    cancel: function () { 
	        // 用户取消分享后执行的回调函数
	    }
	});
}

//分享所需参数
var shareData = {
	    title: document.title,
	    desc: '微信JS-SDK,帮助第三方为用户提供更优质的移动web服务',
	    link: 'http://demo.open.weixin.qq.com/jssdk/',
	    imgUrl: 'http://mmbiz.qpic.cn/mmbiz/icTdbqWNOwNRt8Qia4lv7k3M9J1SKqKCImxJCt7j9rHYicKDI45jRPBxdzdyREWnk0ia0N5TMnMfth7SdxtzMvVgXg/0'
	  };
function setShareInfo(wxaccount, aId){
	var url = "mobile/article?ac=getArt&wxaccount=" + wxaccount + "&aId=" + aId;
	
	$.ajax({
		url : url,
		async : false,
		success : function(res){
			var obj = null;
			try{
				obj = $.parseJSON(res);
			}catch(e){
				return false;
			}
			
			shareData.link = obj.locUrl;
			shareData.title = obj.title;
			shareData.desc = obj.desc;
			shareData.imgUrl = obj.picUrl;
		}
	});
}

//修改网址参数
function changeParam(key, newVal){
	var currentURL = window.location.toString();
	var targetURL = '';
	var i_userwx = currentURL.indexOf(key);
	var i_dengyu = currentURL.indexOf("=", i_userwx);
	var i_lianjie = currentURL.indexOf("&", i_userwx);
	if(i_lianjie > -1){
		var val = currentURL.substring(i_dengyu+1, i_lianjie);
		targetURL = currentURL.replace(val, newVal);
	}else{
		var val = currentURL.substring(i_dengyu+1);
		targetURL = currentURL.replace(val, newVal);
	}
	return targetURL;
}

wx.error(function(res) {
	alert(res.errMsg);
});
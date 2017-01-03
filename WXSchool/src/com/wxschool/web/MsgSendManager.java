package com.wxschool.web;

import java.util.*;

import com.wxschool.entity.*;

public class MsgSendManager {

	private static MsgSendManager msm;

	public static MsgSendManager instance() {
		if (msm == null) {
			msm = new MsgSendManager();
		}
		return msm;
	}

	/**
	 * 回复文本消息
	 * 
	 * @param user
	 *            接收方帐号（收到的OpenID）
	 * @param developer
	 *            开发者微信号
	 * @param Content
	 *            回复的消息内容
	 */
	public String replyText(String user, String developer, String content) {
		String replyXML = "<xml><ToUserName><![CDATA[%1$s]]></ToUserName><FromUserName><![CDATA[%2$s]]></FromUserName><CreateTime>%3$s</CreateTime><MsgType><![CDATA[text]]></MsgType><Content><![CDATA[%4$s]]></Content></xml>";

		String replyStr = String.format(replyXML, user, developer,
				new Date().getTime(), content);
		return replyStr;
	}

	/**
	 * 回复图片消息
	 * 
	 * @param user
	 *            接收方帐号（收到的OpenID）
	 * @param developer
	 *            开发者微信号
	 * @param mediaId
	 *            通过上传多媒体文件，得到的id
	 */
	public String replyImage(String user, String developer, String mediaId) {
		String replyXML = "<xml><ToUserName><![CDATA[%1$s]]></ToUserName><FromUserName><![CDATA[%2$s]]></FromUserName><CreateTime>%3$s</CreateTime><MsgType><![CDATA[image]]></MsgType><Image><MediaId><![CDATA[%4$s]]></MediaId></Image></xml>";

		String replyStr = String.format(replyXML, user, developer,
				new Date().getTime(), mediaId);
		return replyStr;
	}

	/**
	 * 回复语音消息
	 * 
	 * @param user
	 *            接收方帐号（收到的OpenID）
	 * @param developer
	 *            开发者微信号
	 * @param mediaId
	 *            通过上传多媒体文件，得到的id
	 */
	public String replyVoice(String user, String developer, String mediaId) {
		String replyXML = "<xml><ToUserName><![CDATA[%1$s]]></ToUserName><FromUserName><![CDATA[%2$s]]></FromUserName><CreateTime>%3$s</CreateTime><MsgType><![CDATA[voice]]></MsgType><Voice><MediaId><![CDATA[%4$s]]></MediaId></Voice></xml>";

		String replyStr = String.format(replyXML, user, developer,
				new Date().getTime(), mediaId);
		return replyStr;
	}

	/**
	 * 回复视频消息
	 * 
	 * @param user
	 *            接收方帐号（收到的OpenID）
	 * @param developer
	 *            开发者微信号
	 * @param mediaId
	 *            通过上传多媒体文件，得到的id
	 * @param titel
	 *            视频消息的标题
	 * @param description
	 *            视频消息的描述
	 */
	public String replyVedio(String user, String developer, String mediaId,
			String titel, String description) {
		String replyXML = "<xml><ToUserName><![CDATA[%1$s]]></ToUserName><FromUserName><![CDATA[%2$s]]></FromUserName><CreateTime>%3$s</CreateTime><MsgType><![CDATA[vedio]]></MsgType><Vedio><MediaId><![CDATA[%4$s]]></MediaId><Title><![CDATA[%5$s]]></Title><Description><![CDATA[%6$s]]></Description></Vedio></xml>";

		String replyStr = String.format(replyXML, user, developer,
				new Date().getTime(), mediaId, titel, description);
		return replyStr;
	}

	/**
	 * 回复音乐消息
	 * 
	 * @param user
	 *            接收方帐号（收到的OpenID）
	 * @param developer
	 *            开发者微信号
	 * @param titel
	 *            音乐标题
	 * @param description
	 *            音乐描述
	 * @param musicUrl
	 *            音乐链接
	 * @param hqMusicUrl
	 *            高质量音乐链接，WIFI环境优先使用该链接播放音乐
	 * @param thumbMediaId
	 *            缩略图的媒体id，通过上传多媒体文件，得到的id
	 */
	public String replyMusic(String user, String developer, String title,
			String description, String musicUrl, String hqMusicUrl,
			String thumbMediaId) {
		String replyXML = "<xml><ToUserName><![CDATA[%1$s]]></ToUserName><FromUserName><![CDATA[%2$s]]></FromUserName><CreateTime>%3$s</CreateTime><MsgType><![CDATA[music]]></MsgType><Music><Title><![CDATA[%4$s]]></Title><Description><![CDATA[%5$s]]></Description><MusicUrl><![CDATA[%6$s]]></MusicUrl><HQMusicUrl><![CDATA[%7$s]]></HQMusicUrl><ThumbMediaId><![CDATA[%8$s]]></ThumbMediaId></Music></xml>";

		String replyStr = String.format(replyXML, user, developer,
				new Date().getTime(), title, description, musicUrl, hqMusicUrl,
				thumbMediaId);
		return replyStr;
	}

	/**
	 * 回复图文消息
	 * 
	 * @param user
	 *            接收方帐号（收到的OpenID）
	 * @param developer
	 *            开发者微信号
	 * @param ArticleCount
	 *            图文消息个数，限制为10条以内
	 * @param Title
	 *            图文消息标题
	 * @param Description
	 *            图文消息描述
	 * @param PicUrl
	 *            图片链接，支持JPG、PNG格式，较好的效果为大图360*200，小图200*200
	 * @param Url
	 *            点击图文消息跳转链接
	 */
	public String replyNews(String user, String developer, News news) {
		List<News> nsList = new ArrayList<News>();
		nsList.add(news);
		return replyNewsList(user, developer, nsList);
	}

	// 多图文
	public String replyNewsList(String user, String developer, List<News> nsList) {
		String replyXML1 = "<xml><ToUserName><![CDATA[%1$s]]></ToUserName>"
				+ "<FromUserName><![CDATA[%2$s]]></FromUserName>"
				+ "<CreateTime>%3$s</CreateTime>"
				+ "<MsgType><![CDATA[news]]></MsgType>";
		String replyXML2 = "<ArticleCount>%1$s</ArticleCount><Articles>";
		String replyXML3 = "<item><Title><![CDATA[%1$s]]></Title>"
				+ "<Description><![CDATA[%2$s]]></Description>"
				+ "<PicUrl><![CDATA[%3$s]]></PicUrl>"
				+ "<Url><![CDATA[%4$s]]></Url></item>";
		String replyXML4 = "</Articles><FuncFlag>1</FuncFlag></xml>";
		StringBuffer sb = new StringBuffer();

		String replyStr = String.format(replyXML1, user, developer,
				new Date().getTime());
		sb.append(replyStr);

		replyStr = String.format(replyXML2, nsList.size());
		sb.append(replyStr);

		for (int i = 0; i < nsList.size(); i++) {
			News news = nsList.get(i);
			replyStr = String.format(replyXML3, news.getTitle(),
					news.getDescription(), news.getPicUrl(), news.getUrl());
			sb.append(replyStr);
		}

		sb.append(replyXML4);
		String reply = sb.toString();
		sb = null;
		return reply;
	}

	/**
	 * 接入多客服系统
	 * 
	 * @param user
	 *            接收方帐号（收到的OpenID）
	 * @param developer
	 *            开发者微信号
	 * @param Content
	 *            回复的消息内容
	 */
	public String replyCustomerService(String user, String developer) {
		String replyXML = "<xml><ToUserName><![CDATA[%1$s]]></ToUserName><FromUserName><![CDATA[%2$s]]></FromUserName><CreateTime>%3$s</CreateTime><MsgType><![CDATA[transfer_customer_service]]></MsgType></xml>";

		String replyStr = String.format(replyXML, user, developer,
				new Date().getTime());
		return replyStr;
	}
}

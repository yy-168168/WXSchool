package com.wxschool.dpo;

import java.util.TimerTask;
import java.util.UUID;

import com.wxschool.dao.ChatTextDao;
import com.wxschool.dao.LogDao;
import com.wxschool.dao.WxUserDao;
import com.wxschool.entity.ChatRecord;
import com.wxschool.entity.Config;
import com.wxschool.entity.News;
import com.wxschool.entity.WxUser;

/**
 * 搭讪功能发送客服消息
 * 
 * @author Administrator
 * 
 */
public class ChatMsgSendTimer extends TimerTask {

	private ChatRecord record;

	public ChatMsgSendTimer(ChatRecord record) {
		this.record = record;
	}

	@Override
	public void run() {
		try {
			String wxaccount = record.getWxaccount();
			String from = record.getFrom();
			String to = record.getTo();

			WxUserDao wxUserDao = new WxUserDao();
			WxUser wxUser = wxUserDao.getUser_simple(wxaccount, from);

			if (wxUser != null) {
				ChatTextDao chatDao = new ChatTextDao();
				boolean exist = chatDao.existUnreadRecord(wxaccount, to, from);// 对方是否有未读消息

				if (exist) {
					WechatService wechatService = new WechatService();
					String token = wechatService.getAccessToken(wxaccount);

					if (token != null) {
						News news = new News();
						news.setTitle("你收到一张来自火星的小纸条");
						news.setDescription("--该消息来自【搭讪小纸条】");
						news.setPicUrl(wxUser.getHeadImgUrl());
						news.setUrl(Config.SITEURL
								+ "/mobile/chat/text?ac=list&wxaccount="
								+ wxaccount + "&userwx=" + to + "&to="
								+ UUID.randomUUID().toString()
								+ wxUser.getUserId());

						String result = wechatService.sendCustomMsg_news(token,
								wxaccount, to, news);// 发送图文客服消息
						if (result.equals("ok")) {
							wxUser = wxUserDao.getUser_simple(wxaccount, to);
							if (wxUser != null && !wxUser.isSendMsg()) {
								result = wechatService
										.sendCustomMsg_text(token, wxaccount,
												to,
												"如果你不想被【小纸条】打扰，点击进入你收到的火星小纸条页面，再点击右上角设置，将'是否被搜索到'置为灰色即可");// 发送文字客服消息

								if (result.equals("ok")) {
									wxUserDao.updateField(wxaccount, to,
											"isSendMsg", "1");// 将是否推送过免打扰消息置为已发送
								}
							}
						}
					}
					wechatService = null;
				}
				chatDao = null;
			}
			wxUser = null;
			wxUserDao = null;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "ChatMsgSendTimer错误");
		}
	}

}

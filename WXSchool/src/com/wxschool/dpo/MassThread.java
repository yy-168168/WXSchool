package com.wxschool.dpo;

import com.wxschool.dao.LogDao;
import com.wxschool.dao.WxUserDao;
import com.wxschool.entity.Config;

/*
 * 群发
 */
public class MassThread implements Runnable {
	private String wxaccount;
	private String content;
	private String condition;

	public MassThread(String wxaccount, String condition, String content) {
		this.wxaccount = wxaccount;
		this.content = content;
		this.condition = condition;
	}

	public void run() {
		try {
			WxUserDao wxUserDao = new WxUserDao();
			String[] openIds = null;
			if (condition.equals("")) {
				openIds = wxUserDao.getOpenIds(wxaccount,
						Config.WECHATCUSTOMMSGVALIDTIME);
			} else {
				openIds = wxUserDao.getOpenIdsOfSql(condition, wxaccount,
						Config.WECHATCUSTOMMSGVALIDTIME);
			}
			wxUserDao = null;

			if (openIds != null) {
				WechatService wechatService = new WechatService();
				String token = wechatService.getAccessToken(wxaccount);
				if (token != null) {
					for (int i = 0; i < openIds.length; i++) {
						wechatService.sendCustomMsg_text(token, wxaccount,
								openIds[i], content);
					}
				}
				wechatService = null;
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"群发错误;wxaccount:" + wxaccount + ",content:" + content);
		}
	}
}

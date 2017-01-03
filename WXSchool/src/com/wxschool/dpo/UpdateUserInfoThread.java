package com.wxschool.dpo;

import com.wxschool.dao.LogDao;
import com.wxschool.dao.WxUserDao;
import com.wxschool.entity.WxUser;

/*
 * 更新用户微信信息
 */
public class UpdateUserInfoThread implements Runnable {

	private String wxaccount;
	private String[] openIds;

	public UpdateUserInfoThread(String wxaccount, String[] openIds) {
		this.wxaccount = wxaccount;
		this.openIds = openIds;
	}

	public void run() {
		try {
			WechatService wechatService = new WechatService();
			String token = wechatService.getAccessToken(wxaccount);
			if (token != null) {
				for (int i = 0; i < openIds.length; i++) {
					WxUser wxUser = wechatService
							.getUserInfo(token, openIds[i]);
					if (wxUser != null) {
						wxUser.setWxaccount(wxaccount);
						WxUserDao wxUserDao = new WxUserDao();
						wxUserDao.updateUser(wxUser);
					}
				}
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "UpdateUserInfoThread出错；");
		}
	}
}

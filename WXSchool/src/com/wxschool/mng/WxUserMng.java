package com.wxschool.mng;

import java.io.IOException;
import java.io.Writer;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.wxschool.dao.LogDao;
import com.wxschool.dao.WxUserDao;
import com.wxschool.dpo.WechatService;
import com.wxschool.entity.Page;
import com.wxschool.entity.WxUser;
import com.wxschool.util.BackJs;

public class WxUserMng extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		String ac = request.getParameter("ac");
		WxUserDao wxUserDao = new WxUserDao();

		if (ac.equals("lista")) {
			Object[][] accounts = wxUserDao.getAccountData();

			request.setAttribute("accounts", accounts);
			request.getRequestDispatcher("/mng/wxuser_accountList.jsp")
					.forward(request, response);
		} else if (ac.equals("listu")) {
			String scurPage = request.getParameter("c_p");
			String wxaccount = request.getParameter("wxaccount");
			String orderBy = request.getParameter("orderBy");

			if (orderBy == null) {
				orderBy = "userId";
			}

			int curPage = 1;
			if (scurPage != null) {
				curPage = Integer.parseInt(scurPage);
			}

			int totalRecord = wxUserDao.getTotalRecord(wxaccount);
			Page page = new Page(curPage, 20, totalRecord);

			List<WxUser> users = wxUserDao.getUsers(wxaccount, page, orderBy);

			request.setAttribute("page", page);
			request.setAttribute("users", users);
			request.getRequestDispatcher("/mng/wxUserList.jsp").forward(
					request, response);
		} else if (ac.equals("getUserListFromWX")) {
			String wxaccount = request.getParameter("wxaccount");
			String openId = request.getParameter("openId");
			Writer writer = response.getWriter();

			WechatService wechatService = new WechatService();
			String token = wechatService.getAccessToken(wxaccount);

			if (token == null) {
				LogDao.getLog().addNorLog("从微信获取accessToken出错");
				writer.write("从微信获取accessToken出错");
			} else {
				boolean isGoon = true;
				while (isGoon) {
					String[] s_openIds = wechatService.getUserList(token,
							openId);

					if (s_openIds == null) {
						LogDao.getLog().addNorLog("从微信获取openId列表出错");
						writer.write("从微信获取openId列表出错");
						isGoon = false;
					} else {
						int size = s_openIds.length;
						for (int i = 0; isGoon && i < size - 1; i++) {
							// 获取s_openIds[i]的微信资料
							WxUser user = wechatService.getUserInfo(token,
									s_openIds[i]);
							if (user == null) {
								LogDao.getLog().addNorLog(
										"获取" + s_openIds[i] + "的微信资料出错；上一个为"
												+ s_openIds[i - 1]);
								writer.write("获取" + s_openIds[i]
										+ "的微信资料出错；上一个为" + s_openIds[i - 1]);
								isGoon = false;
							} else {
								// 插入数据库
								user.setWxaccount(wxaccount);
								wxUserDao.addUser(user);
							}
							try {
								Thread.sleep(100);// 暂停100毫秒
							} catch (InterruptedException e) {
							}
						}
						openId = s_openIds[size - 1];
						if (size != 10001) {
							isGoon = false;
						}
					}
				}
			}
			wechatService = null;
			return;
		} else if (ac.equals("search")) {
			String kw = request.getParameter("keyword");
			String wxaccount = request.getParameter("wxaccount");

			Page page = new Page(1, 50, 50);

			List<WxUser> users = wxUserDao.searchUsersByNickname(wxaccount, kw,
					page);

			request.setAttribute("page", page);
			request.setAttribute("users", users);
			request.getRequestDispatcher("/mng/wxUserList.jsp").forward(
					request, response);
		} else if (ac.equals("updateWxUserInfo")) {
			String wxaccount = request.getParameter("wxaccount");
			String userwx = request.getParameter("userwx");
			boolean isSuccess = false;

			WechatService wechatService = new WechatService();
			String token = wechatService.getAccessToken(wxaccount);

			if (token != null) {
				WxUser user = wechatService.getUserInfo(token, userwx);

				if (user != null) {
					user.setWxaccount(wxaccount);
					isSuccess = wxUserDao.updateUser(user);
				}
			}
			wechatService = null;
			BackJs.backJs(isSuccess + "", response);
		} else if (ac.equals("changeLevel")) {
			String wxaccount = request.getParameter("wxaccount");
			String userwx = request.getParameter("userwx");
			String level = request.getParameter("level");

			boolean result = wxUserDao.updateField(wxaccount, userwx, "level",
					level);
			BackJs.backJs(result + "", response);
		}
		wxUserDao = null;
	}
}

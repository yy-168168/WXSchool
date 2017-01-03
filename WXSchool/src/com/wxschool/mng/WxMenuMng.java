package com.wxschool.mng;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.wxschool.dao.AccountDao;
import com.wxschool.dao.WxMenuDao;
import com.wxschool.dpo.WechatService;
import com.wxschool.entity.Account;
import com.wxschool.entity.WxMenu;
import com.wxschool.util.BackJs;

public class WxMenuMng extends HttpServlet {

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
		String wxid = (String) request.getAttribute("wxid");
		WxMenuDao wxMenuDao = new WxMenuDao();

		if (ac.equals("index")) {
			AccountDao accountDao = new AccountDao();
			Account account = accountDao.getAccountOfSecurityData(wxid);
			accountDao = null;

			List<WxMenu> wxMenus = wxMenuDao.getMenus(wxid);

			request.setAttribute("wxMenus", wxMenus);
			request.setAttribute("account", account);
			request.getRequestDispatcher("/mng/wxMenuCreate.jsp").forward(
					request, response);
		} else if (ac.equals("index2")) {
			request.getRequestDispatcher("/mng/wxMenuCreateSelf.jsp").forward(
					request, response);
		} else if (ac.equals("createSelf")) {
			String appId = request.getParameter("appId");
			String appSecret = request.getParameter("appSecret");
			String body = request.getParameter("body");

			AccountDao accountDao = new AccountDao();
			accountDao.updateAppInfo(wxid, appId, appSecret);
			accountDao = null;

			WechatService wechatService = new WechatService();
			String token = wechatService.getAccessToken(wxid);
			String reply = "error";
			if (token == null) {
				reply = "wrong1";
			} else {
				String msg = wechatService.createMenu(token, body);
				if (msg == null) {
				} else if (msg.equals("ok")) {
					reply = "ok";
				} else if (msg.equals("wrong")) {
					reply = "wrong2";
				} else {
					reply = msg;
				}
			}
			wechatService = null;
			BackJs.backJs(reply, response);
		} else if (ac.equals("create")) {
			String appId = request.getParameter("appId");
			String appSecret = request.getParameter("appSecret");

			AccountDao accountDao = new AccountDao();
			accountDao.updateAppInfo(wxid, appId, appSecret);
			accountDao = null;

			WechatService wechatService = new WechatService();
			String token = wechatService.getAccessToken(wxid);
			String reply = "error";
			if (token == null) {
				reply = "wrong1";
			} else {
				StringBuffer sb = new StringBuffer("{\"button\":[");
				List<WxMenu> wxMenus = wxMenuDao.getMenus(wxid);
				int listSize = wxMenus.size();
				for (int i = 0; i < listSize; i++) {
					WxMenu firstMenu = wxMenus.get(i);
					int firstMenuId = firstMenu.getMenuId();
					if (firstMenu.getParentId() == 1) {
						sb.append("{\"name\":\"" + firstMenu.getName() + "\",");

						boolean isHasSubButton = false;
						StringBuffer sub = new StringBuffer("\"sub_button\":[");
						for (int j = 0; j < listSize; j++) {
							WxMenu secondMenu = wxMenus.get(j);
							if (secondMenu.getParentId() == firstMenuId) {
								isHasSubButton = true;
								sub.append("{");
								String type = secondMenu.getType();
								sub.append("\"type\":\"" + type + "\",");

								sub.append("\"name\":\"" + secondMenu.getName()
										+ "\",");
								if (type.equals("click")) {
									sub.append("\"key\":\""
											+ secondMenu.getContent() + "\"");
								} else if (type.equals("view")) {
									sub.append("\"url\":\""
											+ secondMenu.getContent() + "\"");
								} else {
									sub.append("\"key\":\""
											+ secondMenu.getContent() + "\"");
								}
								sub.append("},");
							}
						}
						sub = sub.deleteCharAt(sub.length() - 1);
						sub.append("]");

						if (isHasSubButton) {// 有子菜单
							sb.append(sub);
						} else {
							String type = firstMenu.getType();
							sb.append("\"type\":\"" + type + "\",");
							if (type.equals("click")) {
								sb.append("\"key\":\"" + firstMenu.getContent()
										+ "\"");
							} else if (type.equals("view")) {
								sb.append("\"url\":\"" + firstMenu.getContent()
										+ "\"");
							} else {
								sb.append("\"key\":\"" + firstMenu.getContent()
										+ "\"");
							}
						}

						sb.append("},");
					}
				}
				sb = sb.deleteCharAt(sb.length() - 1);
				sb.append("]}");

				String body = sb.toString();

				String msg = wechatService.createMenu(token, body);
				if (msg == null) {
				} else if (msg.equals("ok")) {
					reply = "ok";
				} else if (msg.equals("wrong")) {
					reply = "wrong2";
				} else {
					reply = msg;
				}
			}
			wechatService = null;
			BackJs.backJs(reply, response);
		} else if (ac.equals("addMenuName")) {
			String menuName = request.getParameter("menuName");
			String menuId = request.getParameter("menuId");

			if (menuId == null || menuId.equals("")) {
				menuId = "1";
			}

			boolean isSuccess = wxMenuDao.addMenuName(wxid, menuId, menuName);
			BackJs.backJs(isSuccess + "", response);
		} else if (ac.equals("updateMenuName")) {
			String menuName = request.getParameter("menuName");
			String menuId = request.getParameter("menuId");

			boolean isSuccess = wxMenuDao.updateMenuName(menuId, menuName);
			BackJs.backJs(isSuccess + "", response);
		} else if (ac.equals("updateMenuInfo")) {
			String menuId = request.getParameter("menuId");
			String type = request.getParameter("type");
			String content = request.getParameter("content");

			boolean isSuccess = wxMenuDao.updateMenuInfo(menuId, type, content);
			BackJs.backJs(isSuccess + "", response);
		} else if (ac.equals("getMenuInfo")) {
			String menuId = request.getParameter("menuId");

			WxMenu wxMenu = wxMenuDao.getMenuInfo(menuId);
			BackJs.backJs(JSONObject.toJSONString(wxMenu), response);
		} else if (ac.equals("deleteMenu")) {
			String menuId = request.getParameter("menuId");

			boolean isSuccess = wxMenuDao.deleteMenu(menuId);
			BackJs.backJs(isSuccess + "", response);
		} else if (ac.equals("getMenuById")) {
			String menuId = request.getParameter("menuId");

			List<WxMenu> wxMenus = wxMenuDao.getMenus(wxid, menuId);
			BackJs.backJs(JSONArray.toJSONString(wxMenus), response);
		} else if (ac.equals("updateMenuRank")) {
			String s_rankMenuId = request.getParameter("rankMenuId");
			String s_rank = request.getParameter("rank");

			String[] a_rankMenuId = s_rankMenuId.split("\\|");
			String[] a_rank = s_rank.split("\\|");

			boolean isSuccess = wxMenuDao.updateMenuRank(a_rankMenuId, a_rank);
			BackJs.backJs(isSuccess + "", response);
		}
		wxMenuDao = null;
	}
}

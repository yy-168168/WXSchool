package com.wxschool.mng;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONObject;
import com.wxschool.dao.AdminDao;
import com.wxschool.entity.Admin;
import com.wxschool.util.BackJs;

public class LoginMng extends HttpServlet {

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
		AdminDao adminDao = new AdminDao();

		if (ac == null) {
			response.sendRedirect("/mng/");
		} else if (ac.equals("login")) {
			String key = request.getParameter("key").trim();
			Admin admin = adminDao.getAdminByKey(key);

			BackJs.backJs(JSONObject.toJSONString(admin), response);
		} else if (ac.equals("index")) {
			String token = request.getParameter("token");
			Admin admin = adminDao.getAdminByToken(token);

			if (admin == null || admin.getWxaccount() == null) {
				response.sendRedirect("/mng/");
			} else {

				adminDao.changeStatus(admin.getUserwx(), 1);// 已登录

				String type = admin.getType();
				if (type.equals("bns")) {
					response.sendRedirect("/mngs/bns?ac=listU&token=" + token);
				} else if (type.equals("account") || type.equals("admin")
						|| type.equals("res")) {
					response.sendRedirect("/mngs/account?ac=index&token="
							+ token);
				} else {
					response.sendRedirect("/mng/");
				}
			}
		} else if (ac.equals("exit")) {
			String wxid = request.getParameter("wxid");
			adminDao.changeStatus(wxid, 0);

			response.sendRedirect("/mng/");
		}
		adminDao = null;
	}
}

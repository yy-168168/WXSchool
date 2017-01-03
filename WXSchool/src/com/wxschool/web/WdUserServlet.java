package com.wxschool.web;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONObject;
import com.wxschool.dao.WdUserDao;
import com.wxschool.entity.WdUser;
import com.wxschool.util.BackJs;

public class WdUserServlet extends HttpServlet {

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
		WdUserDao wdu = new WdUserDao();

		if (ac.equals("login")) {
			String pwd = request.getParameter("pwd").trim();
			WdUser user = wdu.getUserByPwd(pwd);

			BackJs.backJs(JSONObject.toJSONString(user), response);
		} else if (ac.equals("bind")) {
			String token = request.getParameter("token");
			String wdaccount = request.getParameter("wdaccount").trim();
			String wdpwd = request.getParameter("wdpwd").trim();
			WdUser user = wdu.checkBind(wdaccount, wdpwd);

			String str = "error";
			if (user == null) {
			} else if (user.getWdaccount() == null) {
				str = "false";
			} else {
				user.setToken(token);
				boolean b = wdu.updateWdUser(user);
				str = (b == true) ? "true" : "error";
			}

			BackJs.backJs(str, response);
		}
		wdu = null;
	}
}

package com.wxschool.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONObject;
import com.wxschool.dao.*;
import com.wxschool.entity.Account;
import com.wxschool.util.BackJs;

public class AccountServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html");

		String ac = request.getParameter("ac");
		String wxaccount = request.getParameter("wxaccount");

		AccountDao accountDao = new AccountDao();

		if (ac == null) {
		} else if (ac.equals("updateUseAccount")) {
			String type = request.getParameter("type");
			accountDao.updateFiled(wxaccount, type, 1);
		} else if (ac.equals("getAccount")) {
			Account account = accountDao.getAccount(wxaccount);
			BackJs.backJs(JSONObject.toJSONString(account), response);
		} else if (ac.equals("getContent")) {
			String type = request.getParameter("type");
			String guideUrl = accountDao.getContent(wxaccount, type);
			BackJs.backJs(guideUrl, response);
		}
		accountDao = null;
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html");

		String ac = request.getParameter("ac");

		if (ac == null) {
		}
	}

}

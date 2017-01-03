package com.wxschool.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONArray;
import com.wxschool.dpo.ExpressService;
import com.wxschool.dpo.WechatService;
import com.wxschool.util.BackJs;

public class OtherServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String ac = request.getParameter("ac");
		// String userwx = request.getParameter("userwx");
		String wxaccount = request.getParameter("wxaccount");

		if (ac == null) {
		} else if (ac.equals("query")) {
			String com = request.getParameter("com");
			String num = request.getParameter("num");

			ExpressService expressDpo = new ExpressService();
			String result = expressDpo.getExpress(wxaccount, com, num);
			result = result.replace("\n", "<br/>");

			String CNname = ExpressService.getCNname(com);
			request.setAttribute("com", CNname);
			request.setAttribute("result", result);
			request.getRequestDispatcher("/tools/expressQuery.jsp").forward(
					request, response);
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String ac = request.getParameter("ac");

		if (ac.equals("")) {
		} else if (ac.equals("wxSign")) {
			String pageUrl = request.getParameter("pageUrl");
			int i = pageUrl.indexOf("#");
			if (i > -1) {
				pageUrl = pageUrl.substring(0, i);
			}

			WechatService service = new WechatService();
			String[] result = service.jsSign(pageUrl);
			BackJs.backJs(JSONArray.toJSONString(result), response);
		}
	}
}

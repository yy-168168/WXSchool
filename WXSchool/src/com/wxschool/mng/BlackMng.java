package com.wxschool.mng;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wxschool.dao.BlackDao;
import com.wxschool.util.BackJs;

public class BlackMng extends HttpServlet {

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
		BlackDao blackDao = new BlackDao();

		if (ac.equals("add")) {
			String wxaccount = request.getParameter("wxaccount");
			if (wxaccount == null) {
				wxaccount = wxid;
			}

			String userwx = request.getParameter("userwx");
			String cate = request.getParameter("cate");

			boolean result = blackDao.addBlack(wxaccount, userwx, cate);
			BackJs.backJs(result + "", response);
		}
	}
}

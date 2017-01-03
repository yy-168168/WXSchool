package com.wxschool.mng;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wxschool.dao.MassDao;
import com.wxschool.dpo.MassThread;
import com.wxschool.entity.Mass;

public class MassMng extends HttpServlet {

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

		if (ac.equals("mass")) {
			request.getRequestDispatcher("/mng/massSend.jsp").forward(request,
					response);
		} else if (ac.equals("send")) {
			String content = request.getParameter("content");
			String condition = request.getParameter("condition");

			// 将内容添加至数据库
			Mass mass = new Mass();
			mass.setContent(content);
			mass.setWxaccount(wxid);
			MassDao massDao = new MassDao();
			massDao.addMass(mass);

			// 群发线程
			MassThread massSender = new MassThread(wxid, condition, content);
			Thread t = new Thread(massSender);
			t.start();

			return;
		}
	}
}

package com.wxschool.mng;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.wxschool.dao.AdminDao;
import com.wxschool.entity.Admin;
import com.wxschool.entity.Page;

public class AdminMng extends HttpServlet {

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
		// String wxid = (String) request.getAttribute("wxid");
		AdminDao adminDao = new AdminDao();

		if (ac.equals("list")) {
			String scurPage = request.getParameter("c_p");
			String wxaccount = request.getParameter("wxaccount");

			int curPage = 1;
			if (scurPage != null) {
				curPage = Integer.parseInt(scurPage);
			}

			int totalRecord = adminDao.getTotalRecord();
			Page page = new Page(curPage, 20, totalRecord);
			List<Admin> admins = adminDao.getAdmins(wxaccount, page);

			request.setAttribute("page", page);
			request.setAttribute("admins", admins);
			request.getRequestDispatcher("/mng/adminList.jsp").forward(request,
					response);
		} else if (ac.equals("delete_")) {
			String userwx = request.getParameter("userwx");
			adminDao.changeStatus(userwx, -1);
		}
		adminDao = null;
	}
}

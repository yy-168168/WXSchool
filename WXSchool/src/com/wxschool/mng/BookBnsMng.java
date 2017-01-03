package com.wxschool.mng;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wxschool.dao.DqorderDao;
import com.wxschool.entity.Dqorder;
import com.wxschool.entity.Page;

public class BookBnsMng extends HttpServlet {

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
		DqorderDao expressDao = new DqorderDao();

		if (ac.equals("list")) {
			String status = request.getParameter("status");
			String company = request.getParameter("company");
			String scurPage = request.getParameter("c_p");
			String type = request.getParameter("type");

			int curPage = 1;
			if (scurPage != null) {
				curPage = Integer.parseInt(scurPage);
			}

			if (company == null || company.equals("null")) {
				company = "default";
			}

			Page page = null;
			List<Dqorder> orders = null;
			if (status == null || status.equals("null") || status.equals("1")) {
				int totalRecord = expressDao.getTotalRecordByStatus(wxid,
						company, type, 0);
				page = new Page(curPage, 12, totalRecord);
				orders = expressDao.getOrdersByStatus(wxid, company, page,
						type, 0);
			} else if (status.equals("2")) {
				int totalRecord = expressDao.getTotalRecordByStatus(wxid,
						company, type, 1);
				page = new Page(curPage, 12, totalRecord);
				orders = expressDao.getOrdersByStatus(wxid, company, page,
						type, 1);
			} else if (status.equals("3")) {
				int totalRecord = expressDao.getTotalRecord(wxid, company,
						type, 0);
				page = new Page(curPage, 12, totalRecord);
				orders = expressDao.getOrders(wxid, company, page, type, 0);
			}

			request.setAttribute("page", page);
			request.setAttribute("orders", orders);

			if (type.equals("1")) {
				request.getRequestDispatcher("/mng/expressList.jsp").forward(
						request, response);
			} else if (type.equals("2")) {
				request.getRequestDispatcher("/mng/tranTicketList.jsp")
						.forward(request, response);
			}
		} else if (ac.equals("delete_")) {
			String orderId = request.getParameter("orderId");
			expressDao.changeStatus(orderId, -1);
		}
		expressDao = null;
	}
}

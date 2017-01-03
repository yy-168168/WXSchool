package com.wxschool.web;

import java.io.IOException;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wxschool.dao.ArticleDao;
import com.wxschool.dao.BnsDao;
import com.wxschool.dao.DqorderDao;
import com.wxschool.entity.Dqorder;
import com.wxschool.entity.Merchant;
import com.wxschool.entity.Page;
import com.wxschool.util.BackJs;
import com.wxschool.util.CommonUtil;

public class BookBnsServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");

		String ac = request.getParameter("ac");
		String wxaccount = request.getParameter("wxaccount");
		String userwx = request.getParameter("userwx");

		DqorderDao expressDao = new DqorderDao();

		if (ac == null) {
		} else if (ac.equals("isOpen")) {
			String aId = request.getParameter("aId");
			String merchantId = request.getParameter("merchantId");

			ArticleDao articleDao = new ArticleDao();
			articleDao.updateVisitPerson(aId);
			articleDao = null;

			BnsDao bnsDao = new BnsDao();
			bnsDao.updateVisitPerson_merchant(wxaccount, merchantId);// 访问量

			Merchant merchant = bnsDao.getMerchant(wxaccount, merchantId);
			if (merchant == null) {
				throw new IOException();
			} else {
				String startTime = merchant.getStartTime();

				if (startTime != null) {
					String endTime = merchant.getEndTime();
					int startTimeHour = Integer.parseInt(startTime.substring(0,
							2));
					int startTimeMinute = Integer.parseInt(startTime.substring(
							3, 5));
					int endTimeHour = Integer.parseInt(endTime.substring(0, 2));
					int endTimeMinute = Integer.parseInt(endTime
							.substring(3, 5));

					Calendar calendar = Calendar.getInstance();
					int curHour = calendar.get(Calendar.HOUR_OF_DAY);
					int curMinute = calendar.get(Calendar.MINUTE);

					if ((curHour > startTimeHour && curHour < endTimeHour)
							|| (curHour == startTimeHour && curMinute >= startTimeMinute)
							|| (curHour == endTimeHour && curMinute <= endTimeMinute)) {// 营业时间内
						response.sendRedirect(merchant.getLocUrl());
					} else {
						request.setAttribute("merchant", merchant);
						request.getRequestDispatcher("/bookbns/notOpen.jsp")
								.forward(request, response);
					}
				}
			}
			bnsDao = null;
		} else if (ac.equals("toHasPickup")) {
			String orderId = request.getParameter("orderId");

			boolean isSuccess = expressDao.pickUp(orderId, userwx);
			BackJs.backJs(isSuccess + "", response);
		} else if (ac.equals("express")) {
			Dqorder order = expressDao.getLastOrder(wxaccount, userwx, "1");

			request.setAttribute("order", order);
			request.getRequestDispatcher("/bookbns/expressOrder.jsp").forward(
					request, response);
		} else if (ac.equals("tran")) {

			request.getRequestDispatcher("/bookbns/tranTicketOrder.jsp")
					.forward(request, response);
		} else if (ac.equals("list")) {
			String status = request.getParameter("status");
			String company = request.getParameter("company");
			String scurPage = request.getParameter("c_p");
			String type = request.getParameter("type");

			int curPage = CommonUtil.parseInt(scurPage, 1);

			if (company == null || company.equals("null")) {
				company = "default";
			}

			Page page = null;
			List<Dqorder> orders = null;
			if (status == null || status.equals("null") || status.equals("no")) {
				int totalRecord = expressDao.getTotalRecordByStatus(wxaccount,
						company, type, 0);
				page = new Page(curPage, 20, totalRecord);
				orders = expressDao.getOrdersByStatus(wxaccount, company, page,
						type, 0);
			} else if (status.equals("yes")) {
				int totalRecord = expressDao.getTotalRecordByStatus(wxaccount,
						company, type, 1);
				page = new Page(curPage, 20, totalRecord);
				orders = expressDao.getOrdersByStatus(wxaccount, company, page,
						type, 1);
			} else if (status.equals("all")) {
				int totalRecord = expressDao.getTotalRecord(wxaccount, company,
						type, 0);
				page = new Page(curPage, 20, totalRecord);
				orders = expressDao
						.getOrders(wxaccount, company, page, type, 0);
			} else if (status.equals("my")) {
				int totalRecord = expressDao.getTotalRecordByOperator(
						wxaccount, userwx, company, type);
				page = new Page(curPage, 20, totalRecord);
				orders = expressDao.getOrdersByOperator(wxaccount, userwx,
						company, page, type);
			}

			request.setAttribute("page", page);
			request.setAttribute("orders", orders);

			if (type.equals("1")) {
				request.getRequestDispatcher("/bookbns/expressList.jsp")
						.forward(request, response);
			} else if (type.equals("2")) {
				request.getRequestDispatcher("/bookbns/tranTicketList.jsp")
						.forward(request, response);
			}
		}
		expressDao = null;
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");

		String ac = request.getParameter("ac");
		String wxaccount = request.getParameter("wxaccount");
		String userwx = request.getParameter("userwx");

		DqorderDao expressDao = new DqorderDao();

		if (ac == null) {
		} else if (ac.equals("addOrder")) {
			String name = request.getParameter("name");
			String tel = request.getParameter("tel");
			String address = request.getParameter("address");
			String company = request.getParameter("company");
			String info = request.getParameter("info");
			String loc_time = request.getParameter("loc_time");
			String sendTime = request.getParameter("sendTime");
			String type = request.getParameter("type");

			Dqorder express = new Dqorder();
			express.setAddress(address);
			express.setCompany(company);
			express.setInfo(info);
			express.setName(name);
			express.setTel(tel);
			express.setUserwx(userwx);
			express.setWxaccount(wxaccount);
			express.setLoc_time(loc_time);
			express.setSendTime(sendTime);
			express.setType(type);

			boolean isSuccess = expressDao.addOrder(express);
			BackJs.backJs(isSuccess + "", response);
		}
		expressDao = null;
	}
}

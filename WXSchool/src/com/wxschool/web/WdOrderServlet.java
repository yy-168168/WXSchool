package com.wxschool.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONArray;
import com.wxschool.dao.WdOrderDao;
import com.wxschool.dao.WdUserDao;
import com.wxschool.entity.Page;
import com.wxschool.entity.WdOrder;
import com.wxschool.entity.WdUser;
import com.wxschool.util.BackJs;
import com.wxschool.util.CommonUtil;

public class WdOrderServlet extends HttpServlet {

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
		String uid = (String) request.getAttribute("uid");
		WdOrderDao wdo = new WdOrderDao();

		if ("getWdoInDb".equals(ac)) {
			String orderNum = request.getParameter("orderNum");
			List<WdOrder> orders = wdo.getOrderInDb(uid, orderNum);

			BackJs.backJs(JSONArray.toJSONString(orders), response);
		} else if ("getWdoInWd".equals(ac)) {
			String orderNum = request.getParameter("orderNum");
			WdUserDao userDao = new WdUserDao();
			WdUser user = userDao.getUserByUid(uid);
			userDao = null;
			List<WdOrder> orders = wdo.getOrderInWd(user, orderNum);

			BackJs.backJs(JSONArray.toJSONString(orders), response);
		} else if ("addWdo".equals(ac)) {
			String orderNum = request.getParameter("orderNum");
			WdUserDao userDao = new WdUserDao();
			WdUser user = userDao.getUserByUid(uid);
			userDao = null;

			List<WdOrder> orders = wdo.getOrderInWd(user, orderNum);
			String reply = "error";
			if (orders == null) {
			} else if (orders.size() == 0) {
				reply = "wrong";
			} else {
				for (int i = 0, len = orders.size(); i < len; i++) {
					WdOrder order = orders.get(i);
					int r = wdo.addOrder(order);
					if (r == 1) {
						reply = "ok";
					}
				}
			}

			BackJs.backJs(reply, response);
		} else if ("list".equals(ac)) {
			String month = request.getParameter("m");
			String day = request.getParameter("d");
			String scurPage = request.getParameter("c_p");

			int curPage = CommonUtil.parseInt(scurPage, 1);

			int totalRecord = wdo.getTotalRecordByDate(uid, month, day);
			Page page = new Page(curPage, 20, totalRecord);
			List<WdOrder> wdos = wdo.getOrderByDate(uid, month, day, page);
			Object[][] datas = wdo.getSumByDate(uid, month, day);

			request.setAttribute("datas", datas);
			request.setAttribute("page", page);
			request.setAttribute("wdos", wdos);
			request.getRequestDispatcher("/wd/orderList.jsp").forward(request,
					response);
		} else {
			Page page = new Page(1, 10, 10);
			List<WdOrder> wdos = wdo.getOrderByPage(uid, page);

			request.setAttribute("wdos", wdos);
			request.getRequestDispatcher("/wd/index.jsp").forward(request,
					response);
		}
		wdo = null;
	}
}

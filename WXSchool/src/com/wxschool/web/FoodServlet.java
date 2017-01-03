package com.wxschool.web;

import java.io.*;
import java.util.List;

import javax.servlet.*;
import javax.servlet.http.*;

import com.wxschool.dao.*;
import com.wxschool.entity.*;

public class FoodServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html");

		String ac = request.getParameter("ac");
		String wxaccount = request.getParameter("wxaccount");
		// String userwx = request.getParameter("userwx");

		FoodDao fDao = new FoodDao();

		if (ac == null) {
		} else if (ac.equals("updateVisitPerson")) {
			String resId = request.getParameter("resId");
			fDao.updateVisitPerson(resId);
		} else if (ac.equals("getRess")) {
			String area = request.getParameter("area");
			if (area == null || area == "") {
				area = "1";
			}

			List<Res> ress = fDao.getRessByArea(wxaccount, area);

			request.setAttribute("ress", ress);
			request.getRequestDispatcher("/food/allres.jsp").forward(request,
					response);
		} else if (ac.equals("getFoods")) {
			String resId = request.getParameter("resId");

			List<Food> foods = fDao.getFoodsById(resId);
			Res res = fDao.getResById(resId);

			request.setAttribute("res", res);
			request.setAttribute("foods", foods);
			request.getRequestDispatcher("/food/res.jsp").forward(request,
					response);
		}
		fDao = null;
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html");

		/*
		 * else if (ac.equals("getress")) { List<Res> ress =
		 * fDao.getRess(wxaccount);
		 * 
		 * request.setAttribute("ress", ress);
		 * request.getRequestDispatcher("/food/allresnew.jsp").forward(request,
		 * response); } else if (ac.equals("getfoods")) { String resId =
		 * request.getParameter("resId");
		 * 
		 * List<Food> foods = fDao.getFoodsById(resId); int tempOrderSize =
		 * fDao.getTempOrderSize(wxaccount, userwx); Res res =
		 * fDao.getResById(Integer.parseInt(resId));
		 * 
		 * request.setAttribute("res", res);
		 * request.setAttribute("tempOrderSize", tempOrderSize);
		 * request.setAttribute("foods", foods);
		 * request.getRequestDispatcher("/food/oneres.jsp").forward(request,
		 * response); } else if (ac.equals("addtemporder")) { String resId =
		 * request.getParameter("resId"); String foodId =
		 * request.getParameter("foodId"); int hasOrder =
		 * fDao.hasOrder(wxaccount, userwx, resId, foodId); if (hasOrder == 0)
		 * {// 没订 boolean b = fDao.addTempOrder(wxaccount, userwx, resId,
		 * foodId); backJs(b + ""); } else { backJs(false + ""); } } else if
		 * (ac.equals("gettemporder")) { List<Order> tempOrders =
		 * fDao.getTempOrders(wxaccount, userwx);
		 * 
		 * request.setAttribute("tempOrders", tempOrders);
		 * request.getRequestDispatcher("/food/cart.jsp").forward(request,
		 * response); } else if (ac.equals("updateOrderAmount")) { String
		 * tempOrderId = request.getParameter("tempOrderId"); String num =
		 * request.getParameter("num"); boolean b =
		 * fDao.updateOrderAmount(tempOrderId, Integer .parseInt(num)); backJs(b
		 * + ""); } else if (ac.equals("deleteTempOrder")) { String tempOrderId
		 * = request.getParameter("tempOrderId");
		 * fDao.deleteTempOrder(tempOrderId); }
		 */
	}
}

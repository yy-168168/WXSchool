package com.wxschool.mng;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wxschool.dao.AdminDao;
import com.wxschool.dao.FoodDao;
import com.wxschool.dao.TopicDao;
import com.wxschool.entity.Admin;
import com.wxschool.entity.Food;
import com.wxschool.entity.Page;
import com.wxschool.entity.Res;
import com.wxschool.entity.Topic;
import com.wxschool.util.BackJs;

public class FoodMng extends HttpServlet {

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
		FoodDao foodDao = new FoodDao();

		if (ac.equals("listr")) {
			String scurPage = request.getParameter("c_p");
			int curPage = 1;
			if (scurPage != null) {
				curPage = Integer.parseInt(scurPage);
			}

			int totalRecord = foodDao.getTotalRecordofResByWxaccount(wxid);
			Page page = new Page(curPage, 10, totalRecord);
			List<Res> ress = foodDao.getRessByPage(wxid, page);

			request.setAttribute("page", page);
			request.setAttribute("ress", ress);
			request.getRequestDispatcher("/mng/resList.jsp").forward(request,
					response);
		} else if (ac.equals("getRes")) {
			String resId = request.getParameter("resId");
			Res res = foodDao.getResById(resId);

			request.setAttribute("res", res);
			request.getRequestDispatcher("/mng/resAddorUpt.jsp?ac=uptRes")
					.forward(request, response);
		} else if (ac.equals("addRes_")) {
			request.getRequestDispatcher("/mng/resAddorUpt.jsp?ac=addRes")
					.forward(request, response);
		} else if (ac.equals("uptRes") || ac.equals("addRes")) {
			String resId = request.getParameter("resId");
			String resName = request.getParameter("resName").trim();
			String address = request.getParameter("address").trim();
			String notice = request.getParameter("notice").trim();
			String picUrl = request.getParameter("picUrl").trim();
			String locUrl = request.getParameter("locUrl").trim();
			String tel = request.getParameter("tel").trim();
			String sort = request.getParameter("sort").trim();
			String area = request.getParameter("area");

			Res res = new Res();
			res.setResId(Integer.parseInt(resId));
			res.setResName(resName);
			res.setAddress(address);
			res.setNotice(notice);
			res.setPicPath(picUrl);
			res.setLocUrl(locUrl);
			res.setTel(tel);
			res.setArea(area);
			res.setWxaccount(wxid);

			boolean isSuccess = false;
			if (ac.equals("uptRes")) {
				AdminDao adminDao = new AdminDao();
				Admin admin = adminDao.getAdminByUserwx(wxid);

				if (admin != null) {
					String type = admin.getType();
					if (type.equals("account")) {
						res.setSort(Integer.parseInt(sort));
						isSuccess = foodDao.updateRes(res);
					} else if (type.equals("res")) {
						isSuccess = foodDao.updateRes_merchant(res);
					}
					BackJs.backJs("upt" + isSuccess, response);
				}

				admin = null;
				adminDao = null;

				BackJs.backJs("uptfalse", response);
			} else if (ac.equals("addRes")) {
				AdminDao adminDao = new AdminDao();
				Admin admin = adminDao.getAdminByUserwx(wxid);

				if (admin != null) {
					String type = admin.getType();
					int totalRecord = 0;
					if (type.equals("account")) {
						totalRecord = foodDao
								.getTotalRecordofResByWxaccount(wxid);
						res.setSort(Integer.parseInt(sort));
					} else if (type.equals("res")) {
						totalRecord = foodDao
								.getTotalRecordofResByMerchantId(wxid);
						res.setWxaccount(admin.getWxaccount());
						res.setSort(1);
					}

					// 获取容量
					TopicDao topicDao = new TopicDao();
					Topic topic = topicDao.getTopic(wxid, "5");
					int maxNum = topic.getCapacity();

					if (totalRecord < maxNum) {
						res.setMerchantId(wxid);
						isSuccess = foodDao.addRes(res);
						BackJs.backJs("add" + isSuccess, response);
					} else {
						BackJs.backJs("over", response);
					}
				}
				admin = null;
				adminDao = null;

				BackJs.backJs("addfalse", response);
			}
		} else if (ac.equals("deleter")) {
			String resId = request.getParameter("resId");
			foodDao.deleteRes(resId);
		} else if (ac.equals("listf")) {
			String resId = request.getParameter("resId");
			String scurPage = request.getParameter("c_p");
			int curPage = 1;
			if (scurPage != null) {
				curPage = Integer.parseInt(scurPage);
			}

			int totalRecord = foodDao.getTotalRecordofFood(resId);
			Page page = new Page(curPage, 10, totalRecord);
			List<Food> foods = foodDao.getFoodsByPage(resId, page);

			request.setAttribute("page", page);
			request.setAttribute("foods", foods);
			request.getRequestDispatcher("/mng/foodList.jsp").forward(request,
					response);
		} else if (ac.equals("getFood")) {
			String foodId = request.getParameter("foodId");
			Food food = foodDao.getFoodById(foodId);

			request.setAttribute("food", food);
			request.getRequestDispatcher("/mng/foodAddorUpt.jsp?ac=uptFood")
					.forward(request, response);
		} else if (ac.equals("addFood_")) {
			String resId = request.getParameter("resId");
			request.getRequestDispatcher(
					"/mng/foodAddorUpt.jsp?ac=addFood&resId=" + resId).forward(
					request, response);
		} else if (ac.equals("uptFood") || ac.equals("addFood")) {
			String resId = request.getParameter("resId");
			String foodId = request.getParameter("foodId");
			String foodName = request.getParameter("foodName").trim();
			String price = request.getParameter("price").trim();
			String type = request.getParameter("type");
			String sort = request.getParameter("sort");
			String locUrl = request.getParameter("locUrl");

			Food food = new Food();
			food.setFoodName(foodName);
			food.setPrice(price);
			food.setType(Integer.parseInt(type));
			food.setSort(Integer.parseInt(sort));
			food.setLocUrl(locUrl);

			boolean isSuccess = false;
			if (ac.equals("uptFood")) {
				food.setFoodId(Integer.parseInt(foodId));
				isSuccess = foodDao.updateFood(food);
				BackJs.backJs("upt" + isSuccess, response);
			} else if (ac.equals("addFood")) {
				isSuccess = foodDao.addFood(food, resId);
				BackJs.backJs("add" + isSuccess, response);
			}
		} else if (ac.equals("deletef")) {
			String foodId = request.getParameter("foodId");
			foodDao.deleteFood(foodId);
		} else if (ac.equals("listrm")) {
			String scurPage = request.getParameter("c_p");
			int curPage = 1;
			if (scurPage != null) {
				curPage = Integer.parseInt(scurPage);
			}

			int totalRecord = foodDao.getTotalRecordofResByMerchantId(wxid);
			Page page = new Page(curPage, 10, totalRecord);
			List<Res> ress = foodDao.getRessByPage_merchant(wxid, page);

			request.setAttribute("page", page);
			request.setAttribute("ress", ress);
			request.getRequestDispatcher("/mng/resList.jsp").forward(request,
					response);
		}
		foodDao = null;
	}
}

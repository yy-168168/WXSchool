package com.wxschool.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONArray;
import com.wxschool.dao.StudentDao;
import com.wxschool.entity.Page;
import com.wxschool.entity.Student;
import com.wxschool.util.BackJs;

public class FriendServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html");

		String ac = request.getParameter("ac");
		// String wxaccount = request.getParameter("wxaccount");
		// String userwx = request.getParameter("userwx");

		if (ac == null) {
		} else if (ac.equals("list")) {
			request.getRequestDispatcher("/education/listFellow.jsp").forward(
					request, response);
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html");

		String ac = request.getParameter("ac");
		String wxaccount = request.getParameter("wxaccount");
		String userwx = request.getParameter("userwx");

		if (ac == null) {
		} else if (ac.equals("isExist")) {
			StudentDao studentDao = new StudentDao();
			Student stu = studentDao.getStuForFellow(wxaccount, userwx);
			studentDao = null;

			String reply = "";
			if (stu == null) {// 出错
				reply = "error";
			} else if (stu.getProvince() == null) {// 没有该用户
				StudentDao stuDao = new StudentDao();
				boolean isSuccess = stuDao.addStuOfDefault(wxaccount, userwx);
				if (!isSuccess) {
					reply = "error";
				} else {
					reply = "notExist";
				}
			} else if (stu.getProvince().equals("")) {// 有用户没有该数据
				reply = "notExist";
			} else {
				String province = stu.getProvince();
				reply = province;
			}
			BackJs.backJs(reply, response);
		} else if (ac.equals("getFellow")) {
			String province = request.getParameter("province");
			String city = request.getParameter("city");
			String s_page = request.getParameter("page");
			int curPage = Integer.parseInt(s_page);
			Page page = new Page(curPage, 20, 20);

			StudentDao studentDao = new StudentDao();
			List<Student> fellows = studentDao.getStusForFellow(wxaccount,
					province, city, page);
			studentDao = null;

			BackJs.backJs(JSONArray.toJSONString(fellows), response);
		}
	}
}

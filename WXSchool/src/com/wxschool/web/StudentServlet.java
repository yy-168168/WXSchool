package com.wxschool.web;

import java.io.*;
import java.net.URLDecoder;
import java.util.List;

import javax.servlet.*;
import javax.servlet.http.*;

import com.alibaba.fastjson.JSONObject;
import com.wxschool.dao.StudentDao;
import com.wxschool.entity.Page;
import com.wxschool.entity.Student;
import com.wxschool.util.BackJs;
import com.wxschool.util.CommonUtil;

public class StudentServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String ac = request.getParameter("ac");
		String userwx = request.getParameter("userwx");
		String wxaccount = request.getParameter("wxaccount");

		StudentDao stuDao = new StudentDao();

		if (ac == null) {
		} else if (ac.equals("stuInfo")) {
			Student stu = stuDao.getStuAll(wxaccount, userwx);

			if (stu == null) {
			} else if (stu.getStuId() == 0) {
				stuDao.addStuOfDefault(wxaccount, userwx);
			}

			request.setAttribute("stu", stu);
			request.getRequestDispatcher("/education/stuInfo.jsp").forward(
					request, response);
		} else if (ac.equals("getStuForScore")) {
			Student stu = stuDao.getStuForScore(wxaccount, userwx);

			if (stu == null) {// 出错
			} else if (stu.getPersonId() == null) {// 没有该用户
				stuDao.addStuOfDefault(wxaccount, userwx);
			}

			BackJs.backJs(JSONObject.toJSONString(stu), response);
		} else if (ac.equals("getStuByStuNum")) {
			String stuNum = request.getParameter("stuNum").trim();

			Student stu = stuDao.getStuByStuNum(wxaccount, stuNum);

			BackJs.backJs(JSONObject.toJSONString(stu), response);
		} else if (ac.equals("list")) {
			String grade = request.getParameter("grade");
			grade = grade == null ? "" : grade;
			String sex = request.getParameter("sex");
			sex = sex == null ? "0" : sex.equals("") ? "0" : sex;
			String province = request.getParameter("province");
			province = province == null ? "" : URLDecoder.decode(province,
					"utf-8");
			province = new String(province.getBytes(), "gbk");
			String depart = request.getParameter("depart");
			depart = depart == null ? "" : URLDecoder.decode(depart, "utf-8");
			String scurPage = request.getParameter("c_p");
			int curPage = CommonUtil.parseInt(scurPage, 1);

			// System.out.println(grade + "  " + sex + "  " + province + "  "
			// + depart + "  " + curPage);

			Student conditon = new Student();
			conditon.setGrade(grade);
			conditon.setSex(Integer.parseInt(sex));
			conditon.setDepart(depart);
			conditon.setMajor("");
			conditon.setProvince(province);
			conditon.setCity("");

			int totalRecord = stuDao.getTotalRecord_register(wxaccount,
					conditon);
			Page page = new Page(curPage, 20, totalRecord);
			List<Student> stus = stuDao.getRegStus_condition(wxaccount,
					conditon, page);
			stuDao = null;

			request.setAttribute("page", page);
			request.setAttribute("stus", stus);
			request.getRequestDispatcher("/education/listStu.jsp").forward(
					request, response);
		}
		stuDao = null;
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String ac = request.getParameter("ac");
		String userwx = request.getParameter("userwx");
		String wxaccount = request.getParameter("wxaccount");

		StudentDao stuDao = new StudentDao();

		if (ac == null) {
		} else if (ac.equals("updateStuAll")) {
			// String personId = request.getParameter("personId").trim();
			// String password = request.getParameter("password").trim();
			String stuName = request.getParameter("stuName").trim();
			String stuNum = request.getParameter("stuNum").trim();
			String grade = request.getParameter("grade").trim();
			String depart = request.getParameter("depart").trim();
			String major = request.getParameter("major").trim();
			String province = request.getParameter("province").trim();
			String city = request.getParameter("city").trim();
			String county = request.getParameter("county").trim();
			String find = request.getParameter("find").trim();
			String sex = request.getParameter("sex").trim();

			Student stu = new Student();
			stu.setStuName(stuName);
			stu.setStuNum(stuNum);
			stu.setDepart(depart);
			stu.setMajor(major);
			stu.setGrade(grade);
			stu.setProvince(province);
			stu.setCity(city);
			stu.setCounty(county);
			stu.setFind(find);
			stu.setSex(Integer.parseInt(sex));
			stu.setUserwx(userwx);
			stu.setWxaccount(wxaccount);

			boolean b = stuDao.updateStuAll(stu);

			BackJs.backJs(b + "", response);
		} else if (ac.equals("isReg")) {
			boolean isReg = stuDao.isReg(wxaccount, userwx);

			BackJs.backJs(isReg + "", response);
		}
		stuDao = null;
	}
}

package com.wxschool.mng;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wxschool.dao.PicDao;
import com.wxschool.entity.Course;
import com.wxschool.entity.Page;
import com.wxschool.entity.Pic;
import com.wxschool.util.BackJs;

public class CourseMng extends HttpServlet {

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
		PicDao picDao = new PicDao();

		if (ac.equals("list")) {
			String scurPage = request.getParameter("c_p");

			int curPage = 1;
			if (scurPage != null) {
				curPage = Integer.parseInt(scurPage);
			}

			int totalRecord = picDao.getTotalRecord(wxid, 2);
			Page page = new Page(curPage, 10, totalRecord);

			List<Pic> pics = picDao.getPicsByPage(wxid, page, 2, "picId");
			List<Course> courses = picToCourse(pics);

			request.setAttribute("page", page);
			request.setAttribute("courses", courses);
			request.getRequestDispatcher("/mng/courseList.jsp").forward(
					request, response);
		} else if (ac.equals("getCourse")) {
			String courseId = request.getParameter("courseId");
			Pic pic = picDao.getPicById(courseId);

			Course course = new Course();
			course.setCourseId(pic.getPicId());
			course.setPicUrl(pic.getPicUrl());
			String title = pic.getTitle();
			course.setGrade(title.substring(0, 4));
			course.setMajor(title.substring(5, title.length() - 4));

			request.setAttribute("course", course);
			request.getRequestDispatcher("/mng/courseUpt.jsp").forward(request,
					response);
		} else if (ac.equals("addCourse_")) {
			request.getRequestDispatcher("/mng/courseAdd.jsp?wxid=" + wxid)
					.forward(request, response);
		} else if (ac.equals("uptCourse") || ac.equals("addCourse")) {
			String courseId = request.getParameter("courseId");
			String grade = request.getParameter("grade").trim();
			String major = request.getParameter("major").trim();
			String picUrl = request.getParameter("picUrl").trim();

			Pic pic = new Pic();
			pic.setWxaccount(wxid);
			pic.setType(2);
			pic.setPicUrl(picUrl);
			pic.setTitle(grade + "级" + major + "专业课表");

			boolean isSuccess = false;
			if (ac.equals("uptCourse")) {
				pic.setPicId(Integer.parseInt(courseId));
				isSuccess = picDao.updatePic(pic);
				BackJs.backJs("upt" + isSuccess, response);
			} else if (ac.equals("addCourse")) {
				isSuccess = picDao.addPic(pic);
				BackJs.backJs("add" + isSuccess, response);
			}
		} else if (ac.equals("delete_")) {
			String courseId = request.getParameter("courseId");
			picDao.changeStatus(courseId, -1);
		} else if (ac.equals("search")) {
			String kw = request.getParameter("keyword");

			Page page = new Page(1, 15, 15);
			List<Pic> pics = picDao.searchByKeyword(wxid, kw, page, 2);
			List<Course> courses = picToCourse(pics);

			request.setAttribute("page", page);
			request.setAttribute("courses", courses);
			request.getRequestDispatcher("/mng/courseList.jsp").forward(
					request, response);
		}
		picDao = null;
	}

	private List<Course> picToCourse(List<Pic> pics) {
		List<Course> courses = new ArrayList<Course>();

		for (int i = 0, len = pics.size(); i < len; i++) {
			Pic pic = pics.get(i);

			Course course = new Course();
			course.setCourseId(pic.getPicId());
			course.setVisitPerson(pic.getVisitPerson());
			String desc = pic.getTitle();
			course.setGrade(desc.substring(0, 5));
			course.setMajor(desc.substring(5, desc.length() - 4));

			courses.add(course);
		}
		return courses;
	}
}

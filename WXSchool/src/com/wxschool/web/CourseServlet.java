package com.wxschool.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wxschool.dao.*;
import com.wxschool.entity.*;
import com.wxschool.util.BackJs;

public class CourseServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html");

		String userwx = request.getParameter("userwx");
		String wxaccount = request.getParameter("wxaccount");
		String ac = request.getParameter("ac");

		CourseDao cDao = new CourseDao();

		if (ac == null) {
		} else if (ac.equals("course")) {
			StudentDao studentDao = new StudentDao();
			Student stu = studentDao.getStuForCourse(wxaccount, userwx);
			studentDao = null;

			if (stu == null) {// 出错
				throw new IOException();
			} else if (stu.getDepart() == null) {// 没有该用户
				StudentDao stuDao = new StudentDao();
				boolean isSuccess = stuDao.addStuOfDefault(wxaccount, userwx);
				if (!isSuccess) {
					throw new IOException();
				} else {
					response.sendRedirect("/course/register.jsp?wxaccount="
							+ wxaccount + "&userwx=" + userwx);
				}
			} else if (stu.getDepart().equals("")) {// 有用户没有该数据
				response.sendRedirect("/course/register.jsp?wxaccount="
						+ wxaccount + "&userwx=" + userwx);
			} else {
				response.setContentType("text/html;charset=utf-8");
				response.getWriter()
						.print("<script type='text/javascript'>alert('您已注册，此网址已失效！');</script>");
			}
		} else if (ac.equals("getCourseById")) {
			String courseId = request.getParameter("courseId");

			Course course = cDao.getCourseById(courseId);

			request.setAttribute("course", course);
			request.getRequestDispatcher("/course/updateCourse.jsp").forward(
					request, response);
		} else if (ac.equals("getCoursesByDay")) {
			String grade = request.getParameter("grade");
			String major = request.getParameter("major");
			String day = request.getParameter("day");

			Student stu = new Student();
			stu.setGrade(grade);
			stu.setMajor(major);
			List<Course> courses = cDao.getCoursesByDay(wxaccount, grade,
					major, Integer.parseInt(day));

			request.setAttribute("stu", stu);
			request.setAttribute("courses", courses);
			request.getRequestDispatcher("/course/showDayCourse.jsp").forward(
					request, response);
		} else if (ac.equals("getWeekCourses")) {
			StudentDao studentDao = new StudentDao();
			Student stu = studentDao.getStuForCourse(wxaccount, userwx);
			studentDao = null;

			List<CourseList> courseList = cDao.getCourseList(wxaccount,
					stu.getGrade(), stu.getMajor());
			if (courseList != null && courseList.size() == 0) {
				response.sendRedirect("/course/courseState.jsp?wxaccount="
						+ wxaccount + "&userwx=" + userwx);
			}
			request.setAttribute("courseList", courseList);
			request.getRequestDispatcher("/course/showWeekCourse.jsp").forward(
					request, response);
		}
		cDao = null;
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html");

		String userwx = request.getParameter("userwx");
		String wxaccount = request.getParameter("wxaccount");
		String ac = request.getParameter("ac");

		CourseDao cDao = new CourseDao();

		if (ac == null) {
		} else if (ac.equals("updateCourse") || ac.equals("addCourse")) {
			String day = request.getParameter("day").trim();
			String courseName = request.getParameter("courseName").trim();
			String teacher = request.getParameter("teacher").trim();
			String address = request.getParameter("address").trim();
			String startLession = request.getParameter("startLession").trim();
			String endLession = request.getParameter("endLession").trim();
			String startWeek = request.getParameter("startWeek").trim();
			String endWeek = request.getParameter("endWeek").trim();
			String isDifWeek = request.getParameter("isDifWeek").trim();

			Course course = new Course();
			course.setDay(Integer.parseInt(day));
			course.setCoureName(courseName);
			course.setTeacher(teacher);
			course.setAddress(address);
			course.setStartLession(Integer.parseInt(startLession));
			course.setEndLession(Integer.parseInt(endLession));
			course.setStartWeek(Integer.parseInt(startWeek));
			course.setEndWeek(Integer.parseInt(endWeek));
			course.setIsDifWeek(Integer.parseInt(isDifWeek));

			boolean b = false;
			if (ac.equals("addCourse")) {
				StudentDao studentDao = new StudentDao();
				Student stu = studentDao.getStuForCourse(wxaccount, userwx);
				studentDao = null;

				course.setMajor(stu.getMajor());
				course.setGrade(stu.getGrade());
				course.setWxaccount(wxaccount);
				b = cDao.addCourse(course);
			} else if (ac.equals("updateCourse")) {
				String courseId = request.getParameter("courseId").trim();
				course.setCourseId(Integer.parseInt(courseId));
				b = cDao.updateCourse(course);
			}
			BackJs.backJs(b + "", response);
		} else if (ac.equals("deleteCourse")) {
			String courseId = request.getParameter("courseId");

			boolean b = cDao.deleteCourse(courseId);
			BackJs.backJs(b + "", response);
		} else if (ac.equals("updateStu")) {
			String depart = request.getParameter("depart").trim();
			String major = request.getParameter("major").trim();
			String grade = request.getParameter("grade").trim();

			Student stu = new Student();
			stu.setDepart(depart);
			stu.setMajor(major);
			stu.setUserwx(userwx);
			stu.setWxaccount(wxaccount);
			stu.setGrade(grade);

			StudentDao studentDao = new StudentDao();
			boolean isSuccess = studentDao.updateStuByCourse(stu);
			studentDao = null;

			BackJs.backJs(isSuccess + "", response);
		}
		cDao = null;
	}
}

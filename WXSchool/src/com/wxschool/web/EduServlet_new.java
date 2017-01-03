package com.wxschool.web;

import java.io.IOException;
import java.io.OutputStream;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONObject;
import com.wxschool.dao.CookieDao;
import com.wxschool.dao.StudentDao;
import com.wxschool.dpo.CetService;
import com.wxschool.dpo.EduService;
import com.wxschool.entity.Student;
import com.wxschool.entity.ValidateCode;
import com.wxschool.util.BackJs;

public class EduServlet_new extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		String ac = request.getParameter("ac");
		String userwx = request.getParameter("userwx");
		String wxaccount = request.getParameter("wxaccount");

		if (ac == null) {// 进入登录页面

			request.getRequestDispatcher("/education/hsdLogin.jsp").forward(
					request, response);
		} else if (ac.equals("checkEduAccess")) {// 检测教务平台是否可用

			EduService eduService = new EduService();
			String result = eduService.checkEduAccess();

			BackJs.backJs(result, response);
		} else if (ac.equals("getValidateCode")) {// 获取教务平台验证码
			EduService eduService = new EduService();
			ValidateCode validateCode = eduService.getValidateCode();
			eduService = null;

			if (validateCode != null) {
				response.setContentType("image/jpeg");
				OutputStream out = response.getOutputStream();
				ImageIO.write(validateCode.getBufferedImage(), "jpg", out);
				out.flush();
				out.close();
				
				CookieDao cookieDao = new CookieDao();
				cookieDao.addDefaultCookie(wxaccount, userwx);
				cookieDao.updateCookie(wxaccount, userwx, validateCode.getCookieStr());
				//request.getSession().setAttribute("cookie", validateCode.getCookieStr());
				validateCode = null;
			}
		} else if (ac.equals("score")) {// 进入成绩页面

			request.getRequestDispatcher("/education/hsdScore.jsp").forward(
					request, response);
		} else if (ac.equals("cet")) {// 进入CET页面
			StudentDao studentDao = new StudentDao();
			Student stu = studentDao.getStuForCet(wxaccount, userwx);

			if (stu == null) {// 出错
			} else if (stu.getCetNum() == null) {// 没有该用户
				studentDao.addStuOfDefault(wxaccount, userwx);
			}
			studentDao = null;

			request.setAttribute("stu", stu);
			request.getRequestDispatcher("/education/cetQuery_xuexin.jsp")
					.forward(request, response);
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		String ac = request.getParameter("ac");
		String userwx = request.getParameter("userwx");
		String wxaccount = request.getParameter("wxaccount");

		if (ac == null) {
		} else if (ac.equals("login")) {// 登录
			String username = request.getParameter("username").trim();
			String password = request.getParameter("password").trim();
			String code = request.getParameter("code").trim();
			String token = request.getParameter("token");

			CookieDao cookieDao = new CookieDao();
			String cookieStr = cookieDao.getCookie(wxaccount, userwx);
			cookieDao = null;
			//String cookieStr = (String)request.getSession().getAttribute("cookie");

			EduService eduService = new EduService();
			String result = eduService.isLogin(cookieStr, username, password,
					code,token);

			if (result.equals("ok")) {
				Student stu = eduService.getStuInfo(cookieStr);
				if (stu != null) {
					stu.setPersonId(username);
					stu.setPassword(password);
					stu.setUserwx(userwx);
					stu.setWxaccount(wxaccount);

					StudentDao stuDao = new StudentDao();
					stuDao.updateStuByScore(stu);
					stuDao = null;
				}
			} else {
				Student stu = new Student();
				stu.setPersonId(username);
				stu.setPassword(password);
				stu.setUserwx(userwx);
				stu.setWxaccount(wxaccount);

				StudentDao stuDao = new StudentDao();
				stuDao.addStuByScore(stu);
				stuDao = null;
			}
			eduService = null;
			BackJs.backJs(JSONObject.toJSONString(result), response);
		} else if (ac.equals("getScore")) {// 获取成绩
			CookieDao cookieDao = new CookieDao();
			String cookieStr = cookieDao.getCookie(wxaccount, userwx);
			cookieDao = null;

			EduService eduService = new EduService();
			String[][] score = eduService.getScore(cookieStr);

			String result = "wrong";
			if (score == null) {
			} else if (score.length == 0) {
				result = "gradeOne";
			} else if (score[0][0].equals("false")) {
				result = score[0][1];
			} else {
				BackJs.backJs(JSONObject.toJSONString(score), response);
				return;
			}

			eduService = null;
			BackJs.backJs(JSONObject.toJSONString(result), response);
		} else if (ac.equals("solve")) {// 评教
			CookieDao cookieDao = new CookieDao();
			String cookieStr = cookieDao.getCookie(wxaccount, userwx);
			cookieDao = null;

			EduService eduService = new EduService();
			boolean isSuccess = eduService.evaluate(cookieStr);
			String result = isSuccess ? "ok" : "wrong";

			eduService = null;
			BackJs.backJs(JSONObject.toJSONString(result), response);
		} else if (ac.equals("myCourse")) {// 我的校选修
			CookieDao cookieDao = new CookieDao();
			String cookieStr = cookieDao.getCookie(wxaccount, userwx);
			cookieDao = null;

			EduService eduService = new EduService();
			String result = eduService.myCourse(cookieStr);

			if (result != null && !result.equals("no")) {
				StudentDao stuDao = new StudentDao();
				stuDao.updateStuBySelCourse(wxaccount, userwx, result);
				stuDao = null;
			}

			eduService = null;
			BackJs.backJs(JSONObject.toJSONString(result), response);
		} else if (ac.equals("getCet")) {// 获取CET
			String cetNum = request.getParameter("cetNum");
			String cetName = request.getParameter("cetName");

			Student stu = new Student();
			stu.setCetNum(cetNum);
			stu.setCetName(cetName);
			stu.setWxaccount(wxaccount);
			stu.setUserwx(userwx);

			StudentDao studentDao = new StudentDao();
			studentDao.updateStuByCet(stu);
			studentDao = null;

			CetService cetDao = new CetService();
			String cet = cetDao.getCET(cetNum, cetName);
			cetDao = null;

			BackJs.backJs(JSONObject.toJSONString(cet), response);
		}
	}

}

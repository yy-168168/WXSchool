package com.wxschool.web.api;

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
import com.wxschool.dpo.EduApiService;
import com.wxschool.entity.Student;
import com.wxschool.entity.ValidateCode;
import com.wxschool.util.BackJs;

/**
 * 牡丹江医学院教务功能
 * 
 * @author Administrator
 * 
 */
public class MdjmuServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		String ac = request.getParameter("ac");
		String userwx = request.getParameter("userwx");
		String wxaccount = request.getParameter("wxaccount");

		if (ac == null) {
		} else if (ac.equals("score")) {

			request.getRequestDispatcher("/edu/api/mdjmuLogin.jsp").forward(
					request, response);
		} else if (ac.equals("result")) {

			request.getRequestDispatcher("/edu/api/mdjmuScore.jsp").forward(
					request, response);
		} else if (ac.equals("getValidateCode")) {
			EduApiService apiService = new EduApiService();
			ValidateCode validateCode = apiService.getValidateCode();
			apiService = null;

			if (validateCode != null) {
				response.setContentType("image/jpeg");
				OutputStream out = response.getOutputStream();
				ImageIO.write(validateCode.getBufferedImage(), "jpg", out);
				out.flush();
				out.close();

				CookieDao cookieDao = new CookieDao();
				cookieDao.addDefaultCookie(wxaccount, userwx);
				cookieDao.updateCookie(wxaccount, userwx, validateCode
						.getCookieStr());
				validateCode = null;
			}
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		String ac = request.getParameter("ac");
		String userwx = request.getParameter("userwx");
		String wxaccount = request.getParameter("wxaccount");

		if (ac == null) {
		} else if (ac.equals("login")) {
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String code = request.getParameter("code");

			CookieDao cookieDao = new CookieDao();
			String cookieStr = cookieDao.getCookie(wxaccount, userwx);
			cookieDao = null;

			EduApiService apiService = new EduApiService();
			String result = apiService.isLogin(cookieStr, username, password,
					code);
			if (result.equals("ok") && userwx != null) {
				Student stu = new Student();
				stu.setPersonId(username);
				stu.setPassword(password);
				stu.setUserwx(userwx);
				stu.setWxaccount(wxaccount);

				StudentDao stuDao = new StudentDao();
				stuDao.updateStuByScore(stu);
				stuDao = null;
			}

			apiService = null;
			BackJs.backJs(JSONObject.toJSONString(result), response);
		} else if (ac.equals("getScore")) {
			String yearTerm = request.getParameter("yearTerm");

			CookieDao cookieDao = new CookieDao();
			String cookieStr = cookieDao.getCookie(wxaccount, userwx);
			cookieDao = null;

			EduApiService apiService = new EduApiService();
			String[][] score = apiService.getScore(cookieStr, yearTerm);
			apiService = null;

			BackJs.backJs(JSONObject.toJSONString(score), response);
		}
	}
}

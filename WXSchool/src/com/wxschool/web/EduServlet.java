package com.wxschool.web;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.client.HttpClient;
import org.apache.http.impl.client.CloseableHttpClient;
import com.alibaba.fastjson.JSONObject;
import com.wxschool.dao.StudentDao;
import com.wxschool.dpo.BookService;
import com.wxschool.dpo.ScoreService;
import com.wxschool.entity.Student;
import com.wxschool.util.BackJs;

public class EduServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		String ac = request.getParameter("ac");
		String userwx = request.getParameter("userwx");
		String wxaccount = request.getParameter("wxaccount");

		if (ac == null) {
		} else if (ac.equals("score")) {
			String aId = request.getParameter("aId");
			response.sendRedirect("/mobile/edun?bns=score&wxaccount="
					+ wxaccount + "&userwx=" + userwx + "&aId=" + aId);
		} else if (ac.equals("myCourse")) {
			String aId = request.getParameter("aId");
			response.sendRedirect("/mobile/edun?bns=myCourse&wxaccount="
					+ wxaccount + "&userwx=" + userwx + "&aId=" + aId);
		} else if (ac.equals("cet")) {
			String aId = request.getParameter("aId");
			response.sendRedirect("/mobile/edun?ac=cet&wxaccount=" + wxaccount
					+ "&userwx=" + userwx + "&aId=" + aId);
		} else if (ac.equals("bookSearch")) {

			request.getRequestDispatcher("/edu/bookSearch.jsp").forward(
					request, response);
		} else if (ac.equals("getBorrowList")) {
			String stuNum = request.getParameter("stuNum");

			BookService bookDpo = new BookService();
			String[][] borrowList = bookDpo.searchBorrowList(stuNum, stuNum);
			bookDpo = null;

			BackJs.backJs(JSONObject.toJSONString(borrowList), response);
		} else if (ac.equals("getExpireList")) {
			String stuNum = request.getParameter("stuNum");

			BookService bookDpo = new BookService();
			String[][] expireList = bookDpo.searchExpireList(stuNum);
			bookDpo = null;

			BackJs.backJs(JSONObject.toJSONString(expireList), response);
		} else if (ac.equals("course") || ac.equals("sport")) {// 校选修或者体育选修

			request.getRequestDispatcher("/edu/hsdLogin.jsp").forward(request,
					response);
		} else if (ac.equals("fee")) {

			request.getRequestDispatcher("/edu/fee.jsp").forward(request,
					response);
		} else if (ac.equals("getAllCourse") || ac.equals("getAllSport")) {// 选课
			HttpSession session = request.getSession();
			HttpClient httpClient = (CloseableHttpClient) session
					.getAttribute("client");

			ScoreService scoreService = new ScoreService();
			String[] info = scoreService.getComfirmInfoOfCourse(httpClient);

			if (info != null) {
				if (ac.equals("getAllCourse")) {
					String[][] courses = scoreService.getAllCourse(httpClient,
							info[0], 1);
					request.setAttribute("courses", courses);
				} else if (ac.equals("getAllSport")) {
					String[][] courses = scoreService.getAllCourse(httpClient,
							info[1], 2);
					request.setAttribute("courses", courses);
				}
			}

			request.getRequestDispatcher("/edu/selCourse.jsp").forward(request,
					response);
		} else if (ac.equals("showMyCourse") || ac.equals("showMySport")) {// 我的选课
			HttpSession session = request.getSession();
			HttpClient httpClient = (CloseableHttpClient) session
					.getAttribute("client");

			ScoreService scoreService = new ScoreService();
			String result = null;
			if (ac.equals("showMyCourse")) {
				result = scoreService.myCourse(httpClient);
			} else if (ac.equals("showMySport")) {
				result = scoreService.mySport(httpClient);
			}
			scoreService = null;

			if (result != null && !result.equals("no")) {
				StudentDao stuDao = new StudentDao();
				stuDao.updateStuBySelCourse(wxaccount, userwx, result);
				stuDao = null;
			}

			BackJs.backJs(JSONObject.toJSONString(result), response);
		} else if (ac.equals("test")) {
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String code = request.getParameter("code");

			HttpSession session = request.getSession();
			HttpClient httpClient = (CloseableHttpClient) session
					.getAttribute("client");

			ScoreService sDao = new ScoreService();
			String result = sDao.isLogin(httpClient, username, password, code);

			if (result.equals("ok")) {
				String[][] scores = null;
				BackJs.backJs(JSONObject.toJSONString(scores), response);
				httpClient = null;
				return;
			}
			sDao = null;
			BackJs.backJs(JSONObject.toJSONString(result), response);
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		String ac = request.getParameter("ac");
		String userwx = request.getParameter("userwx");
		String wxaccount = request.getParameter("wxaccount");

		if (ac == null) {
		} else if (ac.equals("fee_")) {
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String code = request.getParameter("code");

			HttpSession session = request.getSession();
			HttpClient httpClient = (CloseableHttpClient) session
					.getAttribute("client");

			ScoreService sDao = new ScoreService();
			String result = sDao.isLogin(httpClient, username, password, code);

			if (result.equals("ok")) {
				result = sDao.flushFee(httpClient);

				session.removeAttribute("client");
				httpClient = null;
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
			sDao = null;
			BackJs.backJs(JSONObject.toJSONString(result), response);
		} else if (ac.equals("login")) {
			String username = request.getParameter("username").trim();
			String password = request.getParameter("password").trim();
			String code = request.getParameter("code").trim();

			HttpSession session = request.getSession();
			HttpClient httpClient = (CloseableHttpClient) session
					.getAttribute("client");

			ScoreService sDao = new ScoreService();
			String result = sDao.isLogin(httpClient, username, password, code);

			if (result.equals("ok")) {
				Student stu = sDao.getStuInfo(httpClient);
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
			sDao = null;
			BackJs.backJs(JSONObject.toJSONString(result), response);
		} else if (ac.equals("confirmCourse") || ac.equals("confirmSport")) {
			String xkkh = request.getParameter("xkkh");

			HttpSession session = request.getSession();
			HttpClient httpClient = (CloseableHttpClient) session
					.getAttribute("client");

			int cate = 1;// 校选
			if (ac.equals("confirmSport")) {
				cate = 2;
			}

			ScoreService scoreService = new ScoreService();
			String result = scoreService
					.submitSelCourse(httpClient, xkkh, cate);
			BackJs.backJs(JSONObject.toJSONString(result), response);
		}
	}
}

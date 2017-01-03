package com.wxschool.web;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.httpclient.HttpException;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;

import com.alibaba.fastjson.JSONArray;
import com.wxschool.dao.VoteDao;
import com.wxschool.dao.WxUserDao;
import com.wxschool.dpo.WechatService;
import com.wxschool.entity.Config;
import com.wxschool.entity.WxUser;
import com.wxschool.util.BackJs;
import com.wxschool.util.HttpUtils;

public class TestServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html");
		String ac = request.getParameter("ac");

		if (ac.equals("a")) {
			WechatService wechatService = new WechatService();
			String token = wechatService.getAccessToken("gh_b315c2abe8ce");
			WxUser user = wechatService.getUserInfo(token,
					"owRT7jkSaUtH04JpPL7IGX6YJfuk");

			if (user != null) {
				user.setWxaccount("测试");

				WxUserDao wxUserDao = new WxUserDao();
				boolean isSuccess = wxUserDao.addUser(user);
				wxUserDao = null;
				if (isSuccess) {
					response.getWriter()
							.write("<script type='text/javascript'>alert('success');</script>");
				} else {
					response.getWriter()
							.write("<script type='text/javascript'>alert('false');</script>");
				}
			}
			wechatService = null;
		} else if (ac.equals("b")) {
			request.getRequestDispatcher(
					"weixin://contacts/profile/gh_b315c2abe8ce").forward(
					request, response);
			// response.sendRedirect("weixin://contacts/profile/gh_b315c2abe8ce");
		} else if (ac.equals("c")) {
			int i = 10 / 0;
			System.out.println(i);
		} else if (ac.equals("d")) {
			for (int i = 0; i < 100; i++) {
				String url = Config.SITEURL + "/backup/ad1.jsp";
				try {
					HttpUtils.doGet(url, null, "utf-8");
				} catch (HttpException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		} else if (ac.equals("wxSign")) {
			System.out.println(request.getParameter("pageUrl"));
			String[] arrStr = { "appId", "timestamp", "nonceStr", "signature" };
			BackJs.backJs(JSONArray.toJSONString(arrStr), response);
		} else if (ac.equals("uptP")) {
			VoteDao voteDao = new VoteDao();
			int id = 17757;
			for (int i = 1; i <= 854; i++) {
				voteDao.updateFiledVal(id, i);
				id++;
			}
		} else if (ac.equals("testHttpclient1")) {
			System.out.println("aa");
			try {
				CloseableHttpClient client = HttpClients.createDefault();
				HttpGet httpGet = new HttpGet("http://www.baidu.com");
				client.execute(httpGet);
				HttpSession session = request.getSession();
				session.setAttribute("client", client);
			} catch (Exception e) {
				e.printStackTrace();
			}
			request.getRequestDispatcher("test?ac=testHttpclient2").forward(
					request, response);
		} else if (ac.equals("testHttpclient2")) {
			HttpSession session = request.getSession();
			CloseableHttpClient client = (CloseableHttpClient) session
					.getAttribute("client");
			System.out.println(client == null);
			request.getRequestDispatcher("test?ac=testHttpclient3").forward(
					request, response);
			response.sendRedirect("test?ac=testHttpclient3");
		} else if (ac.equals("testHttpclient3")) {
			HttpSession session = request.getSession();
			CloseableHttpClient client = (CloseableHttpClient) session
					.getAttribute("client");
			System.out.println(client == null);
		}
	}
}
